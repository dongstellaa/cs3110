open Game

type action = Move of move | Invalid

let key_to_action = function
  | "w" -> Move Up
  | "s" -> Move Down
  | "a" -> Move Left
  | "d" -> Move Right
  | _ -> Invalid

let grid_action input input_grid gm =
  let a = key_to_action input in
  match a with Move m -> move_grid m input_grid gm | Invalid -> input_grid

let is_number str =
  try
    ignore (int_of_string str);
    true
  with Failure _ -> false

let key_to_gm s =
  match s with
  | n when is_number n -> Score (int_of_string n)
  | "n" -> Normal
  | "r" -> Reverse
  | "e" -> Easy
  | "i" -> Invis
  | "h" -> Hangman
  | _ -> Unselected

let pick_gamemode input = gamemode_type := key_to_gm input
