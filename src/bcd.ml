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
  let _is_invalid = Variable.reg spec ~width:1 in
  let _num_digits = Variable.reg spec ~width:4 in
  
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
        ]
        );
      ]
    ];

  { ready = ready.value; output = bcd_value.value }
;;

let hierarchical scope = 
  let module Scoped = Hierarchy.In_scope (I) (O) in
  Scoped.hierarchical ~scope ~name:"bcd" create
;;

