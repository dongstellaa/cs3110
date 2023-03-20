type grid = string list list

let board : grid = [ [ "" ] ]

let finish_multiplier_tail row =
  let rec shift_helper acc = function
    | [] -> acc
    | h :: tl when h = 0 -> shift_helper acc tl
    | h :: tl when acc = [] -> shift_helper [ h ] tl
    | h :: tl -> shift_helper (h :: acc) tl
  in
  shift_helper [] row

let delete_zeros row =
  let rec shift_helper acc = function
    | [] -> acc
    | h :: tl when h = 0 -> shift_helper acc tl
    | h :: tl when acc = [] -> shift_helper [ h ] tl
    | h :: tl when h = List.hd acc ->
        finish_multiplier_tail (shift_helper (((2 * h) :: List.tl acc) @ tl) [])
    | h :: tl -> shift_helper (h :: acc) tl
  in
  shift_helper [] row

let left_shift row =
  match List.length (delete_zeros row) with
  | 0 -> List.rev (delete_zeros row) @ [ 0; 0; 0; 0 ]
  | 1 -> List.rev (delete_zeros row) @ [ 0; 0; 0 ]
  | 2 -> List.rev (delete_zeros row) @ [ 0; 0 ]
  | 3 -> List.rev (delete_zeros row) @ [ 0 ]
  | _ -> List.rev (delete_zeros row) @ []

(* let right_shift row = List.rev row |> shift_left |> List.rev *)

let right_shift row =
  match List.length (delete_zeros row) with
  | 0 -> [ 0; 0; 0; 0 ] @ List.rev (delete_zeros row)
  | 1 -> [ 0; 0; 0 ] @ List.rev (delete_zeros row)
  | 2 -> [ 0; 0 ] @ List.rev (delete_zeros row)
  | 3 -> [ 0 ] @ List.rev (delete_zeros row)
  | _ -> List.rev (delete_zeros row)

let left_shift_grid grid = List.map left_shift grid
let right_shift_grid grid = List.map right_shift grid
