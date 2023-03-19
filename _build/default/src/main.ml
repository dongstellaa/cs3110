let test_grid = 
  [[2; 0; 2; 0]; 
  [4; 0; 0; 0];
  [0; 0; 0; 0];
  [2; 0; 2; 2] ]

let () = print_endline "Press w, a, s, d to play";
  let input = read_line () in 
  Input.grid_action input test_grid