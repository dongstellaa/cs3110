(*here we do moving elements*)
type move = Up | Down | Left | Right
type gamemode = Score of int | Reverse | Normal | Unselected

let gamemode_type = ref Unselected

let move_grid m input_grid gm =
  match !gm with
  | Reverse ->
      let grid' =
        match m with
        | Left -> Grid.left_shift_grid_rev input_grid
        | Right -> Grid.right_shift_grid_rev input_grid
        | Up -> Grid.up_shift_grid_rev input_grid
        | Down -> Grid.down_shift_grid_rev input_grid
      in
      Grid.add_tile_rev grid'
  | _ ->
      let grid' =
        match m with
        | Left -> Grid.left_shift_grid input_grid
        | Right -> Grid.right_shift_grid input_grid
        | Up -> Grid.up_shift_grid input_grid
        | Down -> Grid.down_shift_grid input_grid
      in
      Grid.add_tile grid'

let init_grid gm =
  Grid.score := 0;
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
          match !gm with
          | Reverse ->
              List.mapi
                (fun k x ->
                  if k = j then if Random.bool () then 2048 else 1024 else x)
                (List.nth board i)
          | _ ->
              List.mapi
                (fun k x ->
                  if k = j then if Random.bool () then 2 else 4 else x)
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
  | Normal ->
      List.exists
        (fun row -> List.exists (fun tile -> tile = 2048) row)
        input_grid
  | Score n -> !Grid.score >= n
  | Reverse ->
      List.exists (fun row -> List.exists (fun tile -> tile = 1) row) input_grid
  | Unselected -> false

let check_lose grid =
  let rows = List.length grid in
  let cols = List.length (List.hd grid) in
  let is_adjacent_same r c =
    let current = List.nth (List.nth grid r) c in
    let left = if c > 0 then List.nth (List.nth grid r) (c - 1) else -1 in
    let right =
      if c < cols - 1 then List.nth (List.nth grid r) (c + 1) else -1
    in
    let up = if r > 0 then List.nth (List.nth grid (r - 1)) c else -1 in
    let down =
      if r < rows - 1 then List.nth (List.nth grid (r + 1)) c else -1
    in
    current = left || current = right || current = up || current = down
  in
  let rec check_rows r c =
    if r >= rows then true
    else if c >= cols then check_rows (r + 1) 0
    else if List.nth (List.nth grid r) c = 0 then false
    else if is_adjacent_same r c then false
    else check_rows r (c + 1)
  in
  check_rows 0 0
