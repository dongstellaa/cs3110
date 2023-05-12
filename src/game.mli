type move =
  | Up
  | Down
  | Left
  | Right  (** The type of move defined by which direction is indicated. *)

type gamemode =
  | Score of int
  | Reverse
  | Normal
  | Unselected  (** The type of gamemode defined by which type is indicated. *)

val gamemode_type : gamemode ref

val move_grid : move -> int list list -> gamemode ref -> int list list
(** [move_grid m g] is the int list list that results from shifting g in the
    direction indicated by m. *)

val init_grid : gamemode ref -> int list list
(** [init_grid] is the initial grid of the 2048 game which is an empty
    4x4 board, except for 2 tiles which have a random chance of being a 2 or 
    4.*)

val check_win : gamemode ref -> int list list -> bool
(** [check_win gm grid] checks grid for a winning grid, which varies by 
    what gm is selected by the player. *)

val check_lose : int list list -> bool
(** [check_lose grid] checks grid for a losing grid, which is defined by having
    no adjacent numbers that are the same, except for 0s. *)
