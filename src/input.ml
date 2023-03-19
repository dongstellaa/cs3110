open Move

type act = Move of move | Invalid

let key_to_action = function
  | "w" -> Move Up
  | "s" -> Move Down
  | "a" -> Move Left
  | "d" -> Move Right
  | _ -> Invalid

let action () = read_line () |> key_to_action
