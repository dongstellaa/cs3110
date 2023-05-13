open Board

let run_game () =
  print_endline Ui.start_game_cat;
  print_endline
    "Type any number to play the Score gamemode for your custom score!\n\
     Press n to play for normal mode! \n\
     Press e to play for easy mode (Get 512 to win)!  \n\
     Press r to play for reverse mode (Start at 2048, get to 1)! \n\
     Press i to play for invisible mode (The numbers are invis ?)! \n\
     Press anything else for unlimited play!";
  let input = read_line () in
  Input.pick_gamemode input;
  print_endline "\nPress w, a, s, d to play, q to exit:";
  let grid = Game.init_grid Game.gamemode_type in
  Ui.output grid Game.gamemode_type;
  let rec user_input_helper grid gamemo =
    let input = read_line () in
    if input = "q" then print_endline "quitting 2048"
    else
      let new_grid = Input.grid_action input grid gamemo in
      Ui.output new_grid Game.gamemode_type;
      print_endline ("Score: " ^ string_of_int !Grid.score);
      if Game.check_win Game.gamemode_type new_grid then
        print_endline Ui.end_game_cat
      else if Game.check_lose new_grid then print_endline Ui.lose_game_cat
      else print_endline "Press w, a, s, d to play or q to exit:";
      user_input_helper new_grid gamemo
  in
  user_input_helper grid Game.gamemode_type

let () = run_game ()
