(** A simple? iterative Binary Coded Decimal representation for n-bit integers, with some additions and tweaks for AoC Day 2 *)

open! Core
open! Hardcaml
open! Signal

let num_bits = 34
let bcd_digits = 11

let () = assert (Float.((2. ** (Float.of_int num_bits)) <= (10. ** (Float.of_int bcd_digits))))

module I = struct
  type 'a t = 
    { clock : 'a
    ; reset : 'a
    ; convert : 'a
    ; start_value: 'a [@bits num_bits]
    ; increment : 'a
    }
  [@@deriving hardcaml]
end

module O = struct 
  type 'a t = 
    { ready : 'a
    ; bcd_value : 'a [@bits 4*bcd_digits]
    ; int_value : 'a [@bits num_bits]
    ; num_digits : 'a [@bits 5] (* update this if changing bcd_digits *)
    ; is_invalid : 'a
    }
  [@@deriving hardcaml]
end

module States = struct
  type t = 
    | Idle
    | Converting
    | Incrementing
    | Checking
  [@@deriving sexp_of, compare ~localize, enumerate]
end

let create scope ({ clock; reset; convert; start_value; increment } : _ I.t) : _ O.t
  = 
  let open Always in
  let spec = Reg_spec.create ~clock ~clear:reset () in
  let sm = State_machine.create (module States) spec in
  let _scope = scope in

  let int_value = Variable.reg spec ~width:num_bits in
  let bcd_value = Variable.reg spec ~width:(4*bcd_digits) in
  let%hw_var convert_buffer = Variable.reg spec ~width:num_bits in
  let%hw_var bits_processed = Variable.reg spec ~width:6 in (* keep track processed bits *)

  let ready = Variable.wire ~default:gnd () in
  let num_digits = Variable.reg spec ~width:5 in
  let is_invalid = Variable.reg spec ~width:1 in
  let checking_digits = Variable.reg spec ~width:1 in
  
  let double_dabble_adder value = mux2 (value >=:. 5) (value +:. 3) value in

  (* double dabble algorithm; adjust then shift *)
  let process_bit () =
    let adjusted_digits = List.init bcd_digits ~f:(fun i -> 
      let digit = select bcd_value.value ~high:((i+1)*4 - 1) ~low:(i*4) in
      double_dabble_adder digit
    ) in

    let bcd_adjusted_value = concat_msb (List.rev adjusted_digits) in
    let next_bit = msb convert_buffer.value in
    let bcd_shifted = concat_msb [ sel_bottom ~width:(4*bcd_digits - 1) bcd_adjusted_value; next_bit] in
    let int_shifted = sll convert_buffer.value ~by:1 in

    [
      bcd_value <-- bcd_shifted;
      convert_buffer <-- int_shifted;
      bits_processed <-- bits_processed.value +:. 1
    ]
  in

  (* helper to find the most significant digit position in the BCD *)
  let rec most_sig_digit_pos = function
    | [] -> zero 5
    | (i, x) :: xs -> mux2 (x ==:. 0) (most_sig_digit_pos xs) (of_int_trunc ~width:5 i)
  in

  let bcd_value_to_digits bcd = List.init bcd_digits ~f:(fun i ->
    (i+1, select bcd ~high:((i+1)*4 - 1) ~low:(i*4))
  ) in

  (* AoC 2025 day2 specific -- check if number is "invalid" *)
  let check_is_invalid bcd digits =
    mux2 (lsb digits) gnd (
      mux (srl digits ~by:1) ([
        gnd;  (* 0 digits? *)
        (* hardcoded cases for 2, 4, 6, 8 and 10 digits respectively *)
        select bcd ~high:3 ~low:0 ==: select bcd ~high:7 ~low:4;
        select bcd ~high:7 ~low:0 ==: select bcd ~high:15 ~low:8;
        select bcd ~high:11 ~low:0 ==: select bcd ~high:23 ~low:12;
        select bcd ~high:15 ~low:0 ==: select bcd ~high:31 ~low:16;
        select bcd ~high:19 ~low:0 ==: select bcd ~high:39 ~low:20;
      ] @ if bcd_digits > 11 then [  
        (* additional cases for 64-bit/20 digit support *)
        select bcd ~high:23 ~low:0 ==: select bcd ~high:47 ~low:24;
        select bcd ~high:27 ~low:0 ==: select bcd ~high:55 ~low:28;
        select bcd ~high:31 ~low:0 ==: select bcd ~high:63 ~low:32;
        select bcd ~high:35 ~low:0 ==: select bcd ~high:71 ~low:36;
        select bcd ~high:39 ~low:0 ==: select bcd ~high:79 ~low:40;
      ] else [])
    )
  in

  (* another helper to increment a BCD digit *)
  let increment_bcd_digit digit = mux2 (digit >=:.9) (zero 4) (digit +:. 1) in

  let increment_bcd_value () = 
    let rec incremented_digits i carry =
      if i >= bcd_digits then
        []
      else
        let current_digit = select bcd_value.value ~high:((i+1)*4 - 1) ~low:(i*4) in
        let new_digit = mux2 carry (increment_bcd_digit current_digit) current_digit in
        let new_carry = mux2 carry (current_digit ==:. 9) gnd in
      
        new_digit :: incremented_digits (i+1) new_carry
    in

    [
      bcd_value <-- concat_msb (List.rev (incremented_digits 0 vdd)); (* start incrementing; implicit carry -> increment *)
      int_value <-- int_value.value +:. 1;
    ]
  in

  compile
    [ sm.switch
      [ 
        (Idle, 
        [
          ready <-- vdd;

          if_ convert [
            bcd_value <-- zero (4*bcd_digits);
            bits_processed <-- zero 6;
            convert_buffer <-- start_value;
            int_value <-- start_value;
            ready <-- gnd;
            sm.set_next Converting;
          ] (elif increment [
            sm.set_next Incrementing;
          ] []);
        ]
        );
        (Converting,
        (process_bit ()) @ [
          when_ (bits_processed.value ==:. (num_bits - 1)) [
            sm.set_next Checking;
          ];
        ]
        );
        (Incrementing,
        (increment_bcd_value ()) @ [
          sm.set_next Checking;
        ]
        );
        (Checking,
        [
          if_ ~:(checking_digits.value) [
            num_digits <-- most_sig_digit_pos (List.rev (bcd_value_to_digits bcd_value.value));
            checking_digits <-- vdd;
          ] [
            is_invalid <-- check_is_invalid bcd_value.value num_digits.value;
            checking_digits <-- gnd;
            sm.set_next Idle;
          ];
        ]
        );
      ]
    ];

  { ready = ready.value; bcd_value = bcd_value.value; int_value = int_value.value; num_digits = num_digits.value; is_invalid = is_invalid.value }
;;

let hierarchical scope = 
  let module Scoped = Hierarchy.In_scope (I) (O) in
  Scoped.hierarchical ~scope ~name:"bcd" create
;;

