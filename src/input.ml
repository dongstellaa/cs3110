open Game

type action = Move of move | Invalid

let key_to_action = function
  | "w" -> Move Up
  | "s" -> Move Down
  | "a" -> Move Left
  | "d" -> Move Right
  | _ -> Invalid

let grid_action input input_grid =
  let a = key_to_action input in
  match a with Move m -> move_grid m input_grid | Invalid -> input_grid

let key_to_gm = function "s" -> Score | "t" -> Tile | _ -> Unselected
let pick_gamemode input = gamemode_type := key_to_gm input
