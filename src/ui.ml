let top_line = "┌───────┬───────┬───────┬───────┐"

let middle_line = "├───────┼───────┼───────┼───────┤"

let bottom_line = "└───────┴───────┴───────┴───────┘"

let col = "│" 

let cell value = (String.make (6 - (String.length value)) ' ') ^ value

let build_row row=
  let elem_strings = List.map (fun elem -> Printf.sprintf "│ %6d " elem) row in
  String.concat "" elem_strings ^ "│" 
(* 
let build_grid grid = List.map (fun row ->) *)

let output = 
  print_endline top_line



