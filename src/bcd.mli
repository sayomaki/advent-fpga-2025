open! Core
open! Hardcaml

val num_bits : int

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
    ; bcd_value : 'a
    ; int_value : 'a
    ; num_digits : 'a
    ; is_invalid : 'a
    } 
  [@@deriving hardcaml]
end

val hierarchical : Scope.t -> Signal.t I.t -> Signal.t O.t
