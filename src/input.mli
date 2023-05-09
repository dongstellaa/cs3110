type action
(** The type of action taking place in the game, which can be a move via a 
    valid key press or invalid by an invalid key press. *)

val key_to_action : string -> action
(** [key_to_action s] is the type of action indicated by s. *)

val grid_action : string -> int list list -> int list list
(** [grid_action i g] is the int list list after performing the correct action
    on g indicated by i*)

val key_to_gm : string -> Game.gamemode
(** [key_to_gm s] is the type of gamemode indicated by s. *)

val pick_gamemode : string -> unit
(** [pick_gamemode i] updates Game.gamemode_type as indicated by i*)
