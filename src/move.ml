(*here we do moving elements*)
type move = Up | Down | Left | Right

exception NotImplemented

let move m =
  let grid = match m with
  | Left -> Grid.left_shift_row
  | Right -> Grid.right_shift_row
  | _ -> failwith "not implemented"
  in
  Ui.output grid