let run_game grid () =
  print_endline Ui.start_game_cat;
  print_endline
    "Press s to play the Score gamemode (reach 69,000 points to win)!\n\
     Press t to play for the 2048 tile! \n\
     Press anything else for unlimited play!";
  let input = read_line () in
  Input.pick_gamemode input;
  print_endline "\nPress w, a, s, d to play, q to exit:";
  Ui.output grid;
  let rec user_input_helper grid =
    let input = read_line () in
    if input = "q" then print_endline "quitting 2048"
    else
      let new_grid = Input.grid_action input grid in
      Ui.output new_grid;
      print_endline ("Score: " ^ string_of_int !Grid.score);
      if Game.check_win Game.gamemode_type new_grid then
        print_endline Ui.end_game_cat
      else print_endline "Press w, a, s, d to play or q to exit:";
      user_input_helper new_grid
  in
  user_input_helper grid

let () = run_game Game.init_grid ()
