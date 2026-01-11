(** A simple? iterative Binary Coded Decimal representation for 32 bit integers, with some additions and tweaks for AoC Day 2 *)

open! Core
open! Hardcaml
open! Signal

module I = struct
  type 'a t = 
    { clock : 'a
    ; reset : 'a
    ; convert : 'a
    ; start_value: 'a [@bits 32]
    ; increment : 'a
    }
  [@@deriving hardcaml]
end

module O = struct 
  type 'a t = 
    { ready : 'a
    ; output : 'a [@bits 40]
    ; num_digits : 'a [@bits 4]
    }
  [@@deriving hardcaml]
end

module States = struct
  type t = 
    | Idle
    | Converting
    | Done
  [@@deriving sexp_of, compare ~localize, enumerate]
end

let create scope ({ clock; reset; convert; start_value; increment } : _ I.t) : _ O.t
  = 
  let open Always in
  let spec = Reg_spec.create ~clock ~clear:reset () in
  let sm = State_machine.create (module States) spec in

  let _increment = increment in
  let _scope = scope in

  let%hw_var int_value = Variable.reg spec ~width:32 in
  let%hw_var bits_processed = Variable.reg spec ~width:6 in (* keep track processed bits *)
  let%hw_var bcd_value = Variable.reg spec ~width:40 in

  let ready = Variable.reg spec ~width:1 in
  let num_digits = Variable.reg spec ~width:4 in
  let _is_invalid = Variable.reg spec ~width:1 in
  
  let double_dabble_adder value = mux2 (value >=:. 5) (value +:. 3) value in

  (* double dabble algorithm; adjust then shift *)
  let process_bit () =
    let adjusted_digits = List.init 10 ~f:(fun i -> 
      let digit = select bcd_value.value ~high:((i+1)*4 - 1) ~low:(i*4) in
      double_dabble_adder digit
    ) in

    let bcd_adjusted_value = concat_msb (List.rev adjusted_digits) in
    let next_bit = msb int_value.value in
    let bcd_shifted = concat_msb [ sel_bottom ~width:39 bcd_adjusted_value; next_bit] in
    let int_shifted = sll int_value.value ~by:1 in

    [
      bcd_value <-- bcd_shifted;
      int_value <-- int_shifted;
      bits_processed <-- bits_processed.value +:. 1
    ]
  in

  (* helper to find the most significant digit in 10-digit BCD *)
  let rec most_sig_digit = function
    | [] -> zero 4
    | (i, x) :: xs -> mux2 (x ==:. 0) (most_sig_digit xs) i
  in

  let bcd_value_to_digits bcd = List.init 10 ~f:(fun i ->
    (of_int_trunc ~width:4 (i+1), select bcd ~high:((i+1)*4 - 1) ~low:(i*4))
  ) in

  compile
    [ sm.switch
      [ 
        (Idle, 
        [
          when_ convert [
            bcd_value <-- zero 40;
            bits_processed <-- zero 6;
            int_value <-- start_value;
            ready <-- gnd;
            sm.set_next Converting;
          ]
        ]
        );
        (Converting,
        (process_bit ()) @ [
          when_ (bits_processed.value ==:. 31) [
            sm.set_next Done;
          ];
        ]
        );
        (Done,
        [
          ready <-- vdd;
          num_digits <-- most_sig_digit (List.rev (bcd_value_to_digits bcd_value.value));
        ]
        );
      ]
    ];

  { ready = ready.value; output = bcd_value.value; num_digits = num_digits.value }
;;

let hierarchical scope = 
  let module Scoped = Hierarchy.In_scope (I) (O) in
  Scoped.hierarchical ~scope ~name:"bcd" create
;;

