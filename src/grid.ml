let score = ref 0

(* let finish_multiplier_tail row =
   let rec shift_helper acc = function
     | [] -> acc
     | h :: tl when h = 0 -> shift_helper acc tl
     | h :: tl when h = (acc |> List.rev |> List.hd) ->
         score := !score + h;
         shift_helper (acc |> List.rev |> List.tl |> List.rev) tl @ [ 2 * h ]
     (* | h :: tl when acc = [] -> shift_helper [ h ] tl *)
     | h :: tl -> shift_helper (h :: acc) tl
   in
   shift_helper [] row *)

let add_right (row : int list) : int list =
  let rec addition (acc : int list) (r : int list) : int list =
    match List.rev r with
    | h1 :: h2 :: t when h1 = h2 ->
        score := !score + (2 * h1);
        addition (acc @ [ 2 * h1 ]) (t @ [ 0 ])
    (* | h1 :: h2 :: t when h1 <> h2 -> addition (acc @ [ h1 ]) (h2 :: t) *)
    | h :: t -> addition (acc @ [ h ]) t
    | [] -> List.rev acc
  in
  addition [] row

let add_left (row : int list) : int list =
  let rec addition (acc : int list) (r : int list) : int list =
    match r with
    | h1 :: h2 :: t when h1 = h2 ->
        score := !score + (2 * h1);
        addition (acc @ [ 2 * h1 ]) (t @ [ 0 ])
    (* | h1 :: h2 :: t when h1 <> h2 -> addition (acc @ [ h1 ]) (h2 :: t) *)
    | h :: t -> addition (acc @ [ h ]) t
    | [] -> acc
  in
  addition [] row

let delete_zeros row =
  let rec shift_helper acc r =
    match r with
    | [] -> acc
    | h :: tl when h = 0 -> shift_helper acc tl
    | h :: tl -> shift_helper (acc @ [ h ]) tl
  in
  shift_helper [] row
(* | h :: tl when acc = [] -> shift_helper [ h ] tl
     | h :: tl when h = (acc |> List.rev |> List.hd) ->
         score := !score + h;
         shift_helper
           ((acc |> List.rev |> List.tl |> List.rev) @ [ 2 * h ] @ tl)
           []
     | h :: tl -> shift_helper (acc @ [ h ]) tl
   in
   shift_helper [] row *)

(* let left_shift row =
   match List.length (delete_zeros row) with
   | 0 -> List.rev (delete_zeros row) @ [ 0; 0; 0; 0 ]
   | 1 -> List.rev (delete_zeros row) @ [ 0; 0; 0 ]
   | 2 -> List.rev (delete_zeros row) @ [ 0; 0 ]
   | 3 -> List.rev (delete_zeros row) @ [ 0 ]
   | _ -> List.rev (delete_zeros row) @ [] *)

let left_shift row =
  match List.length (row |> delete_zeros) with
  | 0 -> (row |> delete_zeros |> add_left) @ [ 0; 0; 0; 0 ]
  | 1 -> (row |> delete_zeros |> add_left) @ [ 0; 0; 0 ]
  | 2 -> (row |> delete_zeros |> add_left) @ [ 0; 0 ]
  | 3 -> (row |> delete_zeros |> add_left) @ [ 0 ]
  | _ -> (row |> delete_zeros |> add_left) @ []
(* let right_shift row = List.rev row |> shift_left |> List.rev *)

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
(* grid |> List.map List.rev |> transpose |> left_shift_grid |> transpose
   |> List.map List.rev *)

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
    let new_tile = if Random.int 10 < 9 then 2 else 4 in
    List.mapi
      (fun x row ->
        if x = i then
          List.mapi (fun y tile -> if y = j then new_tile else tile) row
        else row)
      board
