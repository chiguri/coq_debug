(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2012     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(** Maps using the generic comparison function of ocaml. Same interface as
   the module [Map] from the ocaml standard library. *)

type ('a,'b) t =
    Empty
  | Node of ('a,'b) t * 'a * 'b * ('a,'b) t * int


val empty : ('a,'b) t
val is_empty : ('a,'b) t -> bool
val add : 'a -> 'b -> ('a,'b) t -> ('a,'b) t
val find : 'a -> ('a,'b) t -> 'b
val remove : 'a -> ('a,'b) t -> ('a,'b) t
val mem :  'a -> ('a,'b) t -> bool
val iter : ('a -> 'b -> unit) -> ('a,'b) t -> unit
val map : ('b -> 'c) -> ('a,'b) t -> ('a,'c) t
val fold : ('a -> 'b -> 'c -> 'c) -> ('a,'b) t -> 'c -> 'c

(** Additions with respect to ocaml standard library. *)

val dom : ('a,'b) t -> 'a list
val rng : ('a,'b) t -> 'b list
val to_list : ('a,'b) t -> ('a * 'b) list
