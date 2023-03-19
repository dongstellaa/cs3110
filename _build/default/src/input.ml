open Move

type action = Move of move | Invalid

let key_to_action = function
  | "w" -> Move Up
  | "s" -> Move Down
  | "a" -> Move Left
  | "d" -> Move Right
  | _ -> Invalid

(* let input_to_action () = read_line () |> key_to_action *)

let grid_action input input_grid = 
  let a = key_to_action input in
  match a with
  | Move m -> move_grid m input_grid
  | Invalid -> failwith "not implemented"