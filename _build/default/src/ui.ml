let start_game_cat =
  "             *     ,MMM8&&&.            *\n\
  \                  MMMM88&&&&&    .\n\
  \                 MMMM88&&&&&&&\n\
  \       *         MMM88&&&&&&&&\n\
  \                 MMM88&&&&&&&&\n\
  \                 'MMM88&&&&&&'\n\
  \                   'MMM8&&&'      *\n\
  \        |\\___/|\n\
  \        )     (             .              '\n\
  \       =\\     /=\n\
  \         )===(       *\n\
  \        /     \\ \n\
  \        |     | \n\
  \       /       \\ \n\
  \       \\       / \n\
   _/\\_/\\_/\\__  _/_/\\_/\\_/\\_/\\_/\\_/\\_/\\_/\\_/\\_\n\
   |  |  |  |( (  |  |  |  |  |  |  |  |  |  |\n\
   |  |  |  | ) ) |  |  |  |  |  |  |  |  |  |\n\
   |  |  |  |(_(  |  |  |  |  |  |  |  |  |  |\n\
   |  |  |  |  |  |  |  |  |  |  |  |  |  |  |\n\
   |  |  |  |  |  |  |  |  |  |  |  |  |  |  |\n\
  \   \n\
  \     WELCOME TO 2048! -kitten slay boss\n\
  \   \n\
  \   "

let end_game_cat =
  "you beat 2048! :)\n\
  \ \n\
  \             *     ,MMM8&&&.            *\n\
  \                  MMMM88&&&&&    .\n\
  \                 MMMM88&&&&&&&\n\
  \       *         MMM88&&&&&&&&\n\
  \                 MMM88&&&&&&&&\n\
  \                 'MMM88&&&&&&'\n\
  \                   'MMM8&&&'      *\n\
  \          |\\___/|     /\\___/\\ \n\
  \          )     (     )    ~( .              '\n\
  \         =\\     /=   =\\~    /=\n\
  \           )===(       ) ~ (\n\
  \          /     \\     /     \\ \n\
  \          |     |     ) ~   ( \n\
  \         /       \\   /     ~ \\ \n\
  \         \\       /   \\~     ~/\n\
  \  _/\\_/\\_/\\__  _/_/\\_/\\__~__/_/\\_/\\_/\\_/\\_/\\_ \n\
  \  |  |  |  |( (  |  |  | ))  |  |  |  |  |  |\n\
  \  |  |  |  | ) ) |  |  |//|  |  |  |  |  |  |\n\
  \  |  |  |  |(_(  |  |  (( |  |  |  |  |  |  |\n\
  \  |  |  |  |  |  |  |  |\\)|  |  |  |  |  |  |\n\
  \  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |"

let top_line = "┌────────┬────────┬────────┬────────┐"

let middle_line = "├────────┼────────┼────────┼────────┤"

let bottom_line = "└────────┴────────┴────────┴────────┘"

let build_row row =
  let elem_strings =
    List.map
      (fun elem ->
        if elem = 0 then Printf.sprintf "│        "
        else Printf.sprintf "│ %6d " elem)
      row
  in
  String.concat "" elem_strings ^ "│"

let output grid =
  print_endline top_line;
  for i = 0 to 2 do
    print_endline (build_row (List.nth grid i));
    print_endline middle_line
  done;
  print_endline (build_row (List.nth grid 3));
  print_endline bottom_line
