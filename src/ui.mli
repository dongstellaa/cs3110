val top_line : string
(** A string of ascii characters that make up the top of the table. *)

val middle_line : string
(** A string of ascii characters that make up the lines between rows of the 
    table. *)

val bottom_line : string
(** A string of ascii characters that make up the bottom of the table. *)

val build_row : int list -> string
(** [build_row r] is the string version of r, replacing each 0 with an
    empty cell and adding barriers between each column. *)

val output : int list list -> unit
(** [output g] prints the constructed ascii version of g. *)
