(*here we do moving elements*)
type move = Up | Down | Left | Right
type gamemode = Score | Tile | Unselected

let gamemode_type = ref Unselected

let move_grid m input_grid =
  let grid' =
    match m with
    | Left -> Grid.left_shift_grid input_grid
    | Right -> Grid.right_shift_grid input_grid
    | _ -> failwith "not implemented"
  in
  Grid.add_tile grid'

let init_grid =
  Random.self_init ();
  let empty_row = List.init 4 (fun _ -> 0) in
  let empty_board = List.init 4 (fun _ -> empty_row) in
  let rec add_tile n board =
    if n = 0 then board
    else
      let i = Random.int 4 in
      let j = Random.int 4 in
      if List.nth (List.nth board i) j = 0 then
        let new_row =
          List.mapi
            (fun k x -> if k = j then if Random.bool () then 2 else 4 else x)
            (List.nth board i)
        in
        let new_board =
          List.mapi (fun k row -> if k = i then new_row else row) board
        in
        add_tile (n - 1) new_board
      else add_tile n board
  in
  add_tile 2 empty_board

let check_win gm input_grid =
  match !gm with
  | Tile ->
      List.exists
        (fun row -> List.exists (fun tile -> tile = 2048) row)
        input_grid
  | Score -> !Grid.score >= 1000000
  | Unselected -> failwith "check win"
