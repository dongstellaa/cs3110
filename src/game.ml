(*here we do moving elements*)
type move = Up | Down | Left | Right

let move_grid m input_grid =
  match m with
  | Left -> Grid.left_shift_grid input_grid
  | Right -> Grid.right_shift_grid input_grid
  | _ -> failwith "not implemented"