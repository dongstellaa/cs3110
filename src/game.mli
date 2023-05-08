type move =
  | Up
  | Down
  | Left
  | Right  (** The type of move defined by which direction is indicated. *)

val move_grid : move -> int list list -> int list list
(** [move_grid m g] is the int list list that results from shifting g in the
    direction indicated by m. *)

val init_grid : int list list
