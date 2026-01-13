(** Sample AOC FPGA source *)

open! Core
open! Hardcaml
open! Signal

module I = struct 
  type 'a t =
    { clock : 'a
    ; reset : 'a
    ; data : 'a With_valid.t [@bits 32]
    ; puzzle : 'a [@bits 5] (* 4 bit for day, 1 bit for part 1/2 *)
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = 
    { result : 'a With_valid.t [@bits 32] 
    ; data_ready : 'a 
    }
  [@@deriving hardcaml]
end

let create scope ({ clock; reset; data; puzzle} : _ I.t) : _ O.t
  = 
  let open Always in
  let spec = Reg_spec.create ~clock ~clear:reset () in

  let result = Variable.reg spec ~width:32 in
  let result_valid = Variable.reg spec ~width:1 in
  let data_ready = Variable.wire ~default:gnd () in

  let day2 enable =
    let convert = Variable.reg spec ~width:1 in
    let convert_started = Variable.reg spec ~width:1 in
    let increment = Variable.reg spec ~width:1 in 
    let bcd_reset = ~:enable in

    let start_value = Variable.reg spec ~width:32 in
    let end_value = Variable.reg spec ~width:32 in
    let%hw_var range = Variable.reg spec ~width:32 in
    let%hw_var range_counter = Variable.reg spec ~width:32 in
    let%hw_var invalid_counter = Variable.reg spec ~width:32 in

    let bcd = Bcd.hierarchical scope in
    let number = bcd { Bcd.I.clock = clock; reset = bcd_reset; convert = convert.value; start_value = start_value.value; increment = increment.value } in

    (* todo *)
    [
      if_ (start_value.value ==:. 0) [
        data_ready <-- vdd;

        when_ (data.valid) [
          start_value <-- data.value;
        ];
      ] (elif (end_value.value ==:. 0) [
        data_ready <-- vdd;

        when_ (data.valid) [
          end_value <-- data.value;
        ];
      ] [
        range <-- (end_value.value -: start_value.value) +:. 1;
        convert <-- gnd;
        increment <-- gnd;

        when_ ~:(convert_started.value) [
          convert <-- vdd;
          convert_started <-- vdd;
        ];

        when_ (convert_started.value ==: vdd) [
          if_ (range_counter.value <=: range.value) [
            when_ ((number.ready ==: vdd) &: (increment.value ==: gnd)) [
              invalid_counter <-- invalid_counter.value +: (uresize number.is_invalid ~width:32);
              increment <-- vdd;
              range_counter <-- range_counter.value +:. 1;
            ];
          ] [
            result <-- invalid_counter.value;
            result_valid <-- vdd;
          ];
        ];
      ]);
    ]
  in

  compile 
    [
      when_ (puzzle ==:. 0b100) (day2 vdd) (* day 2 part 1 *)
    ]; 

  { result = { value = result.value; valid = result_valid.value }; data_ready = data_ready.value }
;;

let hierarchical scope = 
  let module Scoped = Hierarchy.In_scope (I) (O) in
  Scoped.hierarchical ~scope ~name:"aoc" create
;;
