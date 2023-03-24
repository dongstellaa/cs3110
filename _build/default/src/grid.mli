val delete_zeros : int list -> int list
(** [delete_zeros r] is the int list resulted from shifting all the values
    of the list to the left and summing equal values.
    Example: [delete_zeros [2; 0; 2; 4] = [4;4].] *)

val left_shift : int list -> int list
(** [left_shift r] is a int list that has 0s to the end of the list r to make it 
    a list of length 4.
    Example: [left_shift [2;2] = [2;2;0;0].] *)

val right_shift : int list -> int list
(** [right_shift r] is a int list that has 0s to the beginning of the list r to 
    make it a list of length 4
    Example: [left_shift [2;2] = [0;0;2;2].] *)

val left_shift_grid : int list list -> int list list
(** [left_shift_grid g] is the int list list that has shifted all rows to the
    left, summing equal values. *)

val right_shift_grid : int list list -> int list list
(** [right_shift_grid g] is the int list list that has shifted all rows to the
    right, summing equal values. *)
