let test_grid = 
  [[2; 0; 2; 0]; 
  [4; 0; 0; 0];
  [0; 0; 0; 0];
  [2; 0; 2; 2] ]

let rec user_input () = 
  print_endline "Press w, a, s, d to play or quit to exit:";
  let input = read_line () in 
  if input = "quit" then
    print_endline "quitting 2048"
  else begin
    Input.grid_action input test_grid;
    user_input ()
  end

let () = user_input ()

