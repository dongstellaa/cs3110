type move =
  | Up
  | Down
  | Left
  | Right  (** The type of move defined by which direction is indicated. *)

type gamemode = Score | Tile | Unselected

val gamemode_type : gamemode ref

val move_grid : move -> int list list -> int list list
(** [move_grid m g] is the int list list that results from shifting g in the
    direction indicated by m. *)

val init_grid : int list list
val check_win : gamemode ref -> int list list -> bool
