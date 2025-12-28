(** Advent Of Code (FPGA) in Hardcaml *)

open! Core
open! Hardcaml

module I : sig
  type 'a t = 
    { clock : 'a
    ; reset : 'a
    ; data : 'a
    ; data_ready : 'a
    ; completed : 'a
    }
  [@@deriving hardcaml]
end

module O : sig 
  type 'a t = { result : 'a With_valid.t } [@@deriving hardcaml]
end

val hierarchical : Scope.t -> Signal.t I.t -> Signal.t O.t
