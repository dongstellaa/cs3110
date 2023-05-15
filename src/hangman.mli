(** Hangman game in hangman gamemode. *)

val word_list : string list
(** [word_list] is a list of all of the words that can be chosen for hangman*)

val is_alpha : char -> bool
(** [is_alpha c] returns if char c is alphanumeric.*)

val pick_word : string list -> string
(** [pick_word lst] chooses a random string in lst to be the word for hangman game.*)

val to_char_list : string -> char list
(** [to_char_list s lst] turns s into a list of chars.*)

val print_state : string -> char list -> unit
(** [print_state s lst] prints the updated hangman state. Each letter in the 
    word is denoted by a an underscore. If one of the chars in the char list of
    guessed chars is in the word, the _ is replaced with the char. *)

val update_guessed_chars : char -> char list -> char list
(** [update_guessed_chars c lst] adds char c to the list of guessed chars lst
    if it has not been guessed yet. If the char has been guessed before, the 
    list remains unedited*)

val get_guess : unit -> char
(** [get_guess ()] takes in the user input of an alphanumeric char.
    Requires: only one char is inputted. The char must be alphanumeric.*)

val has_won : string -> char list -> bool
(** [has_won w lst] compares lst to w to check if all the
    characters of w have been guessed. If they have, return true, else false. *)

val run_game : unit -> bool
(** [run_game ()] runs the intermittent game of hangman.*)
