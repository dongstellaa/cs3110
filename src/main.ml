(* let test_grid =
   [ [ 2; 0; 2; 0 ]; [ 4; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 2; 0; 2; 2 ] ] *)

(* let test_grid =
   [ [ 0; 0; 4; 8 ]; [ 4; 2; 0; 8 ]; [ 0; 2; 0; 0 ]; [ 16; 0; 4; 8 ] ] *)

(* let test_grid =
   [ [ 1024; 1024; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ] *)

let test_grid =
  [ [ 2; 2; 0; 0 ]; [ 2; 2; 0; 4 ]; [ 2; 2; 4; 8 ]; [ 0; 8; 8; 16 ] ]

(* let test_grid =
   [ [ 2; 2; 2; 2 ]; [ 2; 2; 2; 2 ]; [ 2; 2; 2; 2 ]; [ 2; 2; 2; 2 ] ] *)

(* let test_grid =
   [ [ 2; 2; 4; 8 ]; [ 4; 4; 8; 8 ]; [ 16; 64; 32; 32 ]; [ 16; 8; 4; 2 ] ] *)

let user_input grid () =
  print_endline "Press w, a, s, d to play or q to exit:";
  Ui.output grid;
  let rec user_input_helper grid =
    let input = read_line () in
    if input = "q" then print_endline "quitting 2048"
    else
      let new_grid = Input.grid_action input grid in
      Ui.output new_grid;
      print_endline "Press w, a, s, d to play or q to exit:";
      user_input_helper new_grid
  in
  user_input_helper grid

let () = user_input test_grid ()
