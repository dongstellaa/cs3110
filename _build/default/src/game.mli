type move =
  | Up
  | Down
  | Left
  | Right  (** The type of move defined by which direction is indicated. *)

val move_grid : move -> int list list -> int list list
(** [move_grid m g] is the int list list that results from shifting g in the
    direction indicated by m. *)

val score : int ref
(** [score] represents the score of the current game. When two numbers are
    merged, the resulting sum is added the the score. *)

(* val update_score : int ref -> int -> int
   * [update_score x y] updates the current score x by incrementing it by y *)
