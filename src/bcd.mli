open! Core
open! Hardcaml

module I : sig
  type 'a t =
    { clock : 'a
    ; reset : 'a
    ; convert : 'a
    ; start_value : 'a
    ; increment : 'a
    }
  [@@deriving hardcaml]
end

module O : sig
  type 'a t = 
    { ready : 'a
    ; output : 'a
    } 
  [@@deriving hardcaml]
end

val hierarchical : Scope.t -> Signal.t I.t -> Signal.t O.t
