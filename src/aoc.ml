(** Sample AOC FPGA source *)

open! Core
open! Hardcaml
open! Signal

module I = struct 
  type 'a t =
    { clock : 'a
    ; reset : 'a
    ; data : 'a [@bits 32]
    ; data_ready : 'a
    ; completed : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = 
    {
      result : 'a With_valid.t [@bits 32]
    }
  [@@deriving hardcaml]
end

let create scope ({ clock; reset; data; data_ready; completed } : _ I.t) : _ O.t
  = 
  let open Always in
  let _spec = Reg_spec.create ~clock ~clear:reset () in
  let _data = data in
  let _completed = completed in
  let _scope = scope in

  let result = Variable.wire ~default:(zero 32) () in
  let result_valid = Variable.wire ~default:gnd () in

  compile 
    [
      result <-- data;
      result_valid <-- data_ready;
    ]; 

  { result = { value = result.value; valid = result_valid.value } }
;;

let hierarchical scope = 
  let module Scoped = Hierarchy.In_scope (I) (O) in
  Scoped.hierarchical ~scope ~name:"aoc" create
;;
