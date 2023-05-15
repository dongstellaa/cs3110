val to_char_list : string -> char list
(** [to_char_list s lst] turns s into a list of chars.*)

val has_won : string -> char list -> bool
(** [has_won w lst] compares lst to w to check if all the
    characters of w have been guessed. If they have, return true, else false. *)

val run_game : unit -> bool
(** [run_game ()] runs the intermittent game of hangman.*)
