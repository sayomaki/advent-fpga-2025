(** Sample AOC FPGA source *)

open! Core
open! Hardcaml
open! Signal

module I = struct 
  type 'a t =
    { clock : 'a
    ; reset : 'a
    ; data : 'a With_valid.t [@bits 64]
    ; puzzle : 'a [@bits 5] (* 4 bit for day, 1 bit for part 1/2 *)
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = 
    { result : 'a With_valid.t [@bits 64] 
    ; data_ready : 'a 
    ; debug : 'a [@bits 2]
    }
  [@@deriving hardcaml]
end

let create scope ({ clock; reset; data; puzzle} : _ I.t) : _ O.t
  = 
  let open Always in
  let spec = Reg_spec.create ~clock ~clear:reset () in

  let result = Variable.reg spec ~width:64 in
  let result_valid = Variable.reg spec ~width:1 in
  let data_ready = Variable.reg spec ~width:1 in
  let debug = Variable.reg spec ~width:2 in

  let day2_module ~enable =
    let convert = Variable.reg spec ~width:1 in
    let convert_started = Variable.reg spec ~width:1 in
    let increment = Variable.reg spec ~width:1 in 

    let start_value = Variable.reg spec ~width:34 in
    let end_value = Variable.reg spec ~width:34 in
    let%hw_var range = Variable.reg spec ~width:34 in
    let%hw_var range_counter = Variable.reg spec ~width:34 in
    let%hw_var invalid_sum = Variable.reg spec ~width:64 in

    let bcd = Bcd.hierarchical scope in
    let number = bcd { Bcd.I.clock = clock; reset = reset; convert = convert.value; start_value = start_value.value; increment = increment.value } in

    when_ enable [
      if_ (start_value.value ==:. 0) [
        debug <--. 0;
        data_ready <-- vdd;

        when_ (data.valid) [
          start_value <-- sel_bottom data.value ~width:34;
          data_ready <-- gnd;
        ];
      ] (elif (end_value.value ==:. 0) [
        debug <--. 1;
        data_ready <-- vdd;

        when_ (data.valid) [
          end_value <-- sel_bottom data.value ~width:34;
          data_ready <-- gnd;
        ];
      ] [
        data_ready <-- gnd;
        result_valid <-- gnd;

        range <-- (end_value.value -: start_value.value) +:. 1;
        convert <-- gnd;
        increment <-- gnd;

        when_ ~:(convert_started.value) [
          convert <-- vdd;
          convert_started <-- vdd;
        ];

        when_ (convert_started.value ==: vdd) [
          if_ (range_counter.value <=: range.value) [
            debug <--. 2;
            when_ ((number.ready ==: vdd) &: (increment.value ==: gnd)) [
              debug <--. 3;
              when_ (number.is_invalid) [
                invalid_sum <-- invalid_sum.value +: (uresize number.int_value ~width:64)
              ];

              increment <-- vdd;
              range_counter <-- range_counter.value +:. 1;
            ];
          ] [
            result <-- invalid_sum.value;
            result_valid <-- vdd;
            
            when_ result_valid.value [
              range_counter <--. 0;
              start_value <--. 0;
              end_value <--. 0;
              convert_started <-- gnd;
            ];
          ];
        ];
      ]);
    ]
 in

  let day2_logic = day2_module ~enable:(puzzle ==:. 0b100) in

  compile [
    day2_logic (* day 2 part 1 *)
  ];

  { result = { value = result.value; valid = result_valid.value }; data_ready = data_ready.value; debug = debug.value }
;;

let hierarchical scope = 
  let module Scoped = Hierarchy.In_scope (I) (O) in
  Scoped.hierarchical ~scope ~name:"aoc" create
;;
