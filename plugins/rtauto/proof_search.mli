(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2012     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

open Util

type form=
    Atom of int
  | Arrow of form * form
  | Bot
  | Conjunct of form * form
  | Disjunct of form * form

module Fmap : Map.S with type key = form

type sequent =
    {rev_hyps: form Intmap.t;
     norev_hyps: form Intmap.t;
     size:int;
     left:int Fmap.t;
     right:(int*form) list Fmap.t;
     cnx:(int*int*form*form) list;
     abs:int option;
     gl:form}

type proof =
    Ax of int
  | I_Arrow of proof
  | E_Arrow of int*int*proof
  | D_Arrow of int*proof*proof
  | E_False of int
  | I_And of proof*proof
  | E_And of int*proof
  | D_And of int*proof
  | I_Or_l of proof
  | I_Or_r of proof
  | E_Or of int*proof*proof
  | D_Or of int*proof
  | Pop of int*proof


type rule =
    SAx of int
  | SI_Arrow
  | SE_Arrow of int*int
  | SD_Arrow of int
  | SE_False of int
  | SI_And
  | SE_And of int
  | SD_And of int
  | SI_Or_l
  | SI_Or_r
  | SE_Or of int
  | SD_Or of int


type 'a with_deps =
    {dep_it:'a;
     dep_goal:bool;
     dep_hyps:Intset.t}

type slice=
    {proofs_done:proof list;
     proofs_todo:sequent with_deps list;
     step:rule;
     needs_goal:bool;
     needs_hyps:Intset.t;
     changes_goal:bool;
     creates_hyps:Intset.t}


type state =
    Complete of proof
  | Incomplete of sequent * slice list


val project: state -> proof

val init_state : ('a * form * 'b)  list -> form -> state

val branching: state -> state list

val success: state -> bool

val pp: state -> Pp.std_ppcmds

val pr_form : form -> unit

val reset_info : unit -> unit

val pp_info : unit -> unit
