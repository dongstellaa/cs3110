let top_line = "┌────────┬────────┬────────┬────────┐"

let middle_line = "├────────┼────────┼────────┼────────┤"

let bottom_line = "└────────┴────────┴────────┴────────┘"

let build_row row=
  let elem_strings = List.map (fun elem -> Printf.sprintf "│ %6d " (int_of_string elem)) row in
  String.concat "" elem_strings ^ "│" 

let output grid= 
  print_endline top_line;
  for i = 0 to 2 do
    print_endline (build_row (List.nth grid i));
    print_endline middle_line;
  done;
  print_endline (build_row (List.nth grid 3));
  print_endline bottom_line;
