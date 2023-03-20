let test_grid = 
  [[2; 0; 2; 0]; 
  [4; 0; 0; 0];
  [0; 0; 0; 0];
  [2; 0; 2; 2] ]

let rec user_input grid () = 
  print_endline "Press w, a, s, d to play or quit to exit:";
  Ui.output grid;
  let input = read_line () in 
  if input = "quit" then
    print_endline "quitting 2048"
  else begin
    let new_grid = Input.grid_action input grid in
    user_input new_grid ()
  end

let () = user_input test_grid ()

