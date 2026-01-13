open! Core
open! Hardcaml
open! Hardcaml_waveterm
open! Hardcaml_test_harness
module Bcd = Hardcaml_demo_project.Bcd
module Harness = Cyclesim_harness.Make (Bcd.I) (Bcd.O)

let ( <--. ) = Bits.( <--. )

let simple_testbench (sim : Harness.Sim.t) =
  let inputs = Cyclesim.inputs sim in
  let outputs = Cyclesim.outputs sim in
  let cycle ?n () = Cyclesim.cycle ?n sim in

  (* Reset the design *)
  inputs.reset := Bits.vdd;
  cycle ();
  inputs.reset := Bits.gnd;
  cycle ();

  inputs.start_value <--. 11;

  let print_value () = 
    let is_invalid = Bits.to_bool !(outputs.is_invalid) in
    printf "Value: %x [%d] (%s)\n" 
      (Bits.to_unsigned_int !(outputs.bcd_value))
      (Bits.to_unsigned_int !(outputs.int_value))
      (if is_invalid then "Invalid" else "Valid");
  in

  (* Pulse the convert signal *)
  inputs.convert := Bits.vdd;
  cycle ();
  inputs.convert := Bits.gnd;
  cycle ();
  cycle ();
  
  (* Wait for result to become valid *)
  while not (Bits.to_bool !(outputs.ready)) do
    cycle ()
  done;

  print_value ();

  (* Helper to increment the BCD value *)
  let do_increment () =
    inputs.increment := Bits.vdd;
    cycle ();
    inputs.increment := Bits.gnd;
    cycle ();

    while not (Bits.to_bool !(outputs.ready)) do
      cycle ()
    done;

    print_value ();
  in
    
  for _ = 1 to 11 do
    do_increment ();
  done;

  cycle ~n:2 ();
;;

(* The [waves_config] argument to [Harness.run] determines where and how to save waveforms
   for viewing later with a waveform viewer. The commented examples below show how to save
   a waveterm file or a VCD file. *)
let waves_config = Waves_config.no_waves

(* let waves_config = *)
(*   Waves_config.to_directory "/tmp/" *)
(*   |> Waves_config.as_wavefile_format ~format:Hardcamlwaveform *)
(* ;; *)

(* let waves_config = *)
(*   Waves_config.to_directory "/tmp/" *)
(*   |> Waves_config.as_wavefile_format ~format:Vcd *)
(* ;; *)

let%expect_test "Simple test, optionally saving waveforms to disk" =
  Harness.run_advanced ~waves_config ~create:Bcd.hierarchical simple_testbench;
  [%expect {|
    Value: 11 (Invalid)
    Value: 12 (Valid)
    Value: 13 (Valid)
    Value: 14 (Valid)
    Value: 15 (Valid)
    Value: 16 (Valid)
    Value: 17 (Valid)
    Value: 18 (Valid)
    Value: 19 (Valid)
    Value: 20 (Valid)
    Value: 21 (Valid)
    Value: 22 (Invalid)
    |}]
;;

let%expect_test "Simple test with printing waveforms directly" =
  (* For simple tests, we can print the waveforms directly in an expect-test (and use the
     command [dune promote] to update it after the tests run). This is useful for quickly
     visualizing or documenting a simple circuit, but limits the amount of data that can
     be shown. *)
  let display_rules =
    [ Display_rule.port_name_matches
        ~wave_format:(Bit_or Unsigned_int)
        (Re.Glob.glob "bcd*" |> Re.compile)
    ]
  in

  Harness.run_advanced
    ~create:Bcd.hierarchical
    ~trace:`All_named
    ~print_waves_after_test:(fun waves ->
      Waveform.print
        ~display_rules
          (* [display_rules] is optional, if not specified, it will print all named
             signals in the design. *)
        ~signals_width:22
        ~display_width:186
        ~wave_width:1
        (* [wave_width] configures how many chars wide each clock cycle is *)
        ~start_cycle:34
        waves)
    simple_testbench;
  [%expect
    {|
    Value: 11 (Invalid)
    Value: 12 (Valid)
    Value: 13 (Valid)
    Value: 14 (Valid)
    Value: 15 (Valid)
    Value: 16 (Valid)
    Value: 17 (Valid)
    Value: 18 (Valid)
    Value: 19 (Valid)
    Value: 20 (Valid)
    Value: 21 (Valid)
    Value: 22 (Invalid)
    ┌Signals─────────────┐┌Waves─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                    ││────┬───────────────┬───────────────┬───────────────┬───────────────┬───────────────┬───────────────┬───────────────┬───────────────┬───────────────┬─────────────│
    │bcd$bcd_value       ││ 5  │17             │18             │19             │20             │21             │22             │23             │24             │25             │32           │
    │                    ││────┴───────────────┴───────────────┴───────────────┴───────────────┴───────────────┴───────────────┴───────────────┴───────────────┴───────────────┴─────────────│
    │                    ││────┬─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │bcd$bits_processed  ││ 31 │32                                                                                                                                                           │
    │                    ││────┴─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │bcd$i$clock         ││┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─│
    │                    ││  └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ │
    │bcd$i$convert       ││                                                                                                                                                                  │
    │                    ││──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │bcd$i$increment     ││            ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐ │
    │                    ││────────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └─│
    │bcd$i$reset         ││                                                                                                                                                                  │
    │                    ││──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │                    ││──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │bcd$i$start_value   ││ 11                                                                                                                                                               │
    │                    ││──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │                    ││────┬─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │bcd$int_value       ││ 21.│0                                                                                                                                                            │
    │                    ││────┴─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │bcd$o$is_invalid    ││            ┌───────────────┐                                                                                                                                     │
    │                    ││────────────┘               └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │                    ││────────┬─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │bcd$o$num_digits    ││ 0      │2                                                                                                                                                        │
    │                    ││────────┴─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │                    ││────┬───────────────┬───────────────┬───────────────┬───────────────┬───────────────┬───────────────┬───────────────┬───────────────┬───────────────┬─────────────│
    │bcd$o$output        ││ 5  │17             │18             │19             │20             │21             │22             │23             │24             │25             │32           │
    │                    ││────┴───────────────┴───────────────┴───────────────┴───────────────┴───────────────┴───────────────┴───────────────┴───────────────┴───────────────┴─────────────│
    │bcd$o$ready         ││            ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐           ┌───┐ │
    │                    ││────────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └───────────┘   └─│
    └────────────────────┘└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    |}]
;;
