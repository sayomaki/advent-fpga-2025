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

  inputs.start_value := Bits.of_int_trunc ~width:32 0;

  (* Reset the design *)
  inputs.reset := Bits.vdd;
  cycle ();
  inputs.reset := Bits.gnd;
  cycle ();

  inputs.start_value <--. 6767;

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

  let bcd_output = sprintf "%x" (Bits.to_unsigned_int !(outputs.output)) in
  print_s [%message "Result" (bcd_output : string)];

  (* Show in the waveform that [valid] stays high. *)
  cycle ~n:2 ()
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
  [%expect {| (Result (bcd_output 6767)) |}]
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
        ~signals_width:32
        ~display_width:186
        ~wave_width:1
        (* [wave_width] configures how many chars wide each clock cycle is *)
        waves)
    simple_testbench;
  [%expect
    {|
    (Result (bcd_output 6767))
    ┌Signals───────────────────────┐┌Waves───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                              ││────────────────────────────────────────────────────────────────────────────────────────────┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────────│
    │bcd$bcd_value                 ││ 0                                                                                          │1  │3  │6  │19 │38 │82 │261│529│10.│21.│57.│13.│26471      │
    │                              ││────────────────────────────────────────────────────────────────────────────────────────────┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───────────│
    │                              ││────────────────┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────────│
    │bcd$bits_processed            ││ 0              │1  │2  │3  │4  │5  │6  │7  │8  │9  │10 │11 │12 │13 │14 │15 │16 │17 │18 │19 │20 │21 │22 │23 │24 │25 │26 │27 │28 │29 │30 │31 │32         │
    │                              ││────────────────┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───────────│
    │bcd$i$clock                   ││┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ │
    │                              ││  └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─│
    │bcd$i$convert                 ││        ┌───┐                                                                                                                                           │
    │                              ││────────┘   └───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │bcd$i$reset                   ││────┐                                                                                                                                                   │
    │                              ││    └───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │                              ││────────┬───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │bcd$i$start_value             ││ 0      │6767                                                                                                                                           │
    │                              ││────────┴───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────│
    │                              ││────────────┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────────│
    │bcd$int_value                 ││ 0          │67.│13.│27.│54.│10.│21.│43.│86.│17.│34.│69.│13.│27.│55.│11.│22.│44.│88.│17.│35.│28.│13.│26.│93.│18.│37.│31.│20.│40.│37.│32.│21.│0          │
    │                              ││────────────┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───────────│
    │                              ││────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┬───────│
    │bcd$o$num_digits              ││ 0                                                                                                                                              │4      │
    │                              ││────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┴───────│
    │                              ││────────────────────────────────────────────────────────────────────────────────────────────┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────────│
    │bcd$o$output                  ││ 0                                                                                          │1  │3  │6  │19 │38 │82 │261│529│10.│21.│57.│13.│26471      │
    │                              ││────────────────────────────────────────────────────────────────────────────────────────────┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───────────│
    │bcd$o$ready                   ││                                                                                                                                                ┌───────│
    │                              ││────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘       │
    └──────────────────────────────┘└────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    |}]
;;
