let score = ref 0

let add_left (row : int list) : int list =
  let rec addition (acc : int list) (r : int list) : int list =
    match r with
    | h1 :: h2 :: t when h1 = h2 ->
        score := !score + (2 * h1);
        addition (acc @ [ 2 * h1 ]) (t @ [ 0 ])
    | h :: t -> addition (acc @ [ h ]) t
    | [] -> acc
  in
  addition [] row

let add_right (row : int list) : int list =
  row |> List.rev |> add_left |> List.rev

let delete_zeros row =
  let rec shift_helper acc r =
    match r with
    | [] -> acc
    | h :: tl when h = 0 -> shift_helper acc tl
    | h :: tl -> shift_helper (acc @ [ h ]) tl
  in
  shift_helper [] row

let left_shift row =
  match List.length (row |> delete_zeros) with
  | 0 -> (row |> delete_zeros |> add_left) @ [ 0; 0; 0; 0 ]
  | 1 -> (row |> delete_zeros |> add_left) @ [ 0; 0; 0 ]
  | 2 -> (row |> delete_zeros |> add_left) @ [ 0; 0 ]
  | 3 -> (row |> delete_zeros |> add_left) @ [ 0 ]
  | _ -> (row |> delete_zeros |> add_left) @ []

let right_shift row =
  match List.length (row |> delete_zeros) with
  | 0 -> [ 0; 0; 0; 0 ] @ (row |> delete_zeros |> add_right)
  | 1 -> [ 0; 0; 0 ] @ (row |> delete_zeros |> add_right)
  | 2 -> [ 0; 0 ] @ (row |> delete_zeros |> add_right)
  | 3 -> [ 0 ] @ (row |> delete_zeros |> add_right)
  | _ -> row |> delete_zeros |> add_right

let transpose (board : int list list) : int list list =
  let rows = List.length board in
  let cols = List.length (List.hd board) in
  List.init cols (fun j ->
      List.init rows (fun i -> List.nth (List.nth board i) j))

let left_shift_grid grid = List.map left_shift grid
let right_shift_grid grid = List.map right_shift grid
let up_shift_grid grid = grid |> transpose |> left_shift_grid |> transpose
let down_shift_grid grid = grid |> transpose |> right_shift_grid |> transpose

let add_left_rev (row : int list) : int list =
  let rec addition (acc : int list) (r : int list) : int list =
    match r with
    | h1 :: h2 :: t when h1 = h2 ->
        score := !score + (2 * h1);
        addition (acc @ [ h1 / 2 ]) (t @ [ 0 ])
    | h :: t -> addition (acc @ [ h ]) t
    | [] -> acc
  in
  addition [] row

let add_right_rev (row : int list) : int list =
  row |> List.rev |> add_left_rev |> List.rev

let left_shift_rev row =
  match List.length (row |> delete_zeros) with
  | 0 -> (row |> delete_zeros |> add_left_rev) @ [ 0; 0; 0; 0 ]
  | 1 -> (row |> delete_zeros |> add_left_rev) @ [ 0; 0; 0 ]
  | 2 -> (row |> delete_zeros |> add_left_rev) @ [ 0; 0 ]
  | 3 -> (row |> delete_zeros |> add_left_rev) @ [ 0 ]
  | _ -> (row |> delete_zeros |> add_left_rev) @ []

let right_shift_rev row =
  match List.length (row |> delete_zeros) with
  | 0 -> [ 0; 0; 0; 0 ] @ (row |> delete_zeros |> add_right_rev)
  | 1 -> [ 0; 0; 0 ] @ (row |> delete_zeros |> add_right_rev)
  | 2 -> [ 0; 0 ] @ (row |> delete_zeros |> add_right_rev)
  | 3 -> [ 0 ] @ (row |> delete_zeros |> add_right_rev)
  | _ -> row |> delete_zeros |> add_right_rev

let left_shift_grid_rev grid = List.map left_shift_rev grid
let right_shift_grid_rev grid = List.map right_shift_rev grid

let up_shift_grid_rev grid =
  grid |> transpose |> left_shift_grid_rev |> transpose

let down_shift_grid_rev grid =
  grid |> transpose |> right_shift_grid_rev |> transpose

let add_tile (board : int list list) : int list list =
  Random.self_init ();
  let empty_tiles = ref [] in
  List.iteri
    (fun i row ->
      List.iteri
        (fun j tile -> if tile = 0 then empty_tiles := (i, j) :: !empty_tiles)
        row)
    board;
  if List.length !empty_tiles = 0 then board
  else
    let i, j = List.nth !empty_tiles (Random.int (List.length !empty_tiles)) in
    let new_tile = if Random.int 10 < 5 then 2 else 4 in
    List.mapi
      (fun x row ->
        if x = i then
          List.mapi (fun y tile -> if y = j then new_tile else tile) row
        else row)
      board

let add_tile_rev (board : int list list) : int list list =
  Random.self_init ();
  let empty_tiles = ref [] in
  List.iteri
    (fun i row ->
      List.iteri
        (fun j tile -> if tile = 0 then empty_tiles := (i, j) :: !empty_tiles)
        row)
    board;
  if List.length !empty_tiles = 0 then board
  else
    let i, j = List.nth !empty_tiles (Random.int (List.length !empty_tiles)) in
    let new_tile = if Random.int 10 < 5 then 2048 else 1024 in
    List.mapi
      (fun x row ->
        if x = i then
          List.mapi (fun y tile -> if y = j then new_tile else tile) row
        else row)
      board
