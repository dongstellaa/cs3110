(** Controls grid movements and attributes. *)

val score : int ref
(** [score] represents the score of the current game. When two numbers are
    merged, the resulting sum is added the the score. *)

val delete_zeros : int list -> int list
(** [delete_zeros r] is the int list resulted from shifting all the values
       of the list to the left.
       Example: [delete_zeros [2; 0; 2; 4] = [2; 2;4].] *)

val add_right : int list -> int list
(** [add_right r] is the int list resulted from adding equal values
       of the deleted 0s list to the right.
       Example: [delete_zeros [2; 2; 2] = [ 2;4].] *)

val add_left : int list -> int list
(** [add_left r] is the int list resulted from adding equal values
       of the deleted 0s list to the left.
       Example: [delete_zeros [2; 2; 2] = [ 4;2].] *)

val left_shift : int list -> int list
(** [left_shift r] is a int list that has 0s to the end of the list r to make it
       a list of length 4.
       Example: [left_shift [2;2] = [4; 0;0;0].] *)

val right_shift : int list -> int list
(** [right_shift r] is a int list that has 0s to the beginning of the list r to
       make it a list of length 4
       Example: [left_shift [2;2] = [0;0;0; 4].] *)

val left_shift_grid : int list list -> int list list
(** [left_shift_grid g] is the int list list that has shifted all rows to the
       left, summing equal values. *)

val right_shift_grid : int list list -> int list list
(** [right_shift_grid g] is the int list list that has shifted all rows to the
       right, summing equal values. *)

val up_shift_grid : int list list -> int list list
(** [left_shift_grid g] is the int list list that has shifted all rows up, 
    summing equal values. *)

val down_shift_grid : int list list -> int list list
(** [right_shift_grid g] is the int list list that has shifted all rows down, 
    summing equal values. *)

val left_shift_grid_rev : int list list -> int list list
(** [left_shift_grid g] is the int list list that has shifted all rows to the
     left, subtracting equal values. *)

val right_shift_grid_rev : int list list -> int list list
(** [right_shift_grid g] is the int list list that has shifted all rows to the
       right, subtracting equal values. *)

val up_shift_grid_rev : int list list -> int list list
(** [left_shift_grid g] is the int list list that has shifted all rows up, 
       subtracting equal values. *)

val down_shift_grid_rev : int list list -> int list list
(** [right_shift_grid g] is the int list list that has shifted all rows down, 
       subtracting equal values. *)

val transpose : int list list -> int list list
(** [transpose g] is the transpose of the matrix the grid produces. *)

val add_tile : int list list -> int list list
(** [add_tile g] is the int list list with a randomly generated 2 or 4 in a
    randomly selected place, replacing a 0.*)

val add_tile_rev : int list list -> int list list
(** [add_tile g] is the int list list with a randomly generated 2 or 4 in a
        randomly selected place, replacing a 0.*)

val left_shift_rev : int list -> int list
(** [left_shift r] is a int list that has 0s to the end of the list r to make it
       a list of length 4.
       Example: [left_shift [2048;2048] = [1024; 0;0;0].] *)

val right_shift_rev : int list -> int list
(** [right_shift r] is a int list that has 0s to the beginning of the list r to
       make it a list of length 4
       Example: [left_shift [2048;2048] = [0;0;0; 1024].] *)
