(*here we do moving elements*)
type move = Up | Down | Left | Right

exception NotImplemented

let move_grid m input_grid =
  let grid = match m with
  | Left -> Grid.left_shift_grid input_grid
  | Right -> Grid.right_shift_grid input_grid
  | _ -> failwith "not implemented"
  in Ui.output grid
