(* let test_grid_1 =
   [ [ 2; 0; 2; 0 ]; [ 4; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 2; 0; 2; 2 ] ] *)

(* let test_grid_2 =
   [ [ 0; 0; 4; 8 ]; [ 4; 2; 0; 8 ]; [ 0; 2; 0; 0 ]; [ 16; 0; 4; 8 ] ] *)

(* let test_grid_3 =
   [[1024; 1024; 0; 0];
   [0; 0; 0; 0];
   [0; 0; 0; 0];
   [0; 0; 0; 0]] *)

let test_grid_4 =
  [ [ 2; 2; 0; 0 ]; [ 2; 2; 0; 4 ]; [ 2; 2; 4; 8 ]; [ 0; 0; 0; 0 ] ]

let user_input grid () =
  print_endline "Press w, a, s, d to play or quit to exit:";
  Ui.output grid;
  let rec user_input_helper grid =
    let input = read_line () in
    if input = "quit" then print_endline "quitting 2048"
    else
      let new_grid = Input.grid_action input grid in
      Ui.output new_grid;
      user_input_helper new_grid
  in
  user_input_helper grid

let () = user_input test_grid_4 ()
