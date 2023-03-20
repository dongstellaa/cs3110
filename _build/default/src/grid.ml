type grid = int list list

let board : grid = [[0]]

let left_shift_no_add row = 
  let rec shift_helper acc = function
    | [] -> (List.rev acc)
    | h :: tl when h = 0 -> shift_helper acc tl
    | h :: tl when acc = [] -> shift_helper [h] tl
    | h :: tl -> shift_helper (h :: acc) tl
  in
  shift_helper [] row

let left_shift_row row = 
  let rec shift_helper acc = function
    | [] -> (List.rev acc)
    | h :: tl when h = 0 -> shift_helper acc tl
    | h :: tl when acc = [] -> shift_helper [h] tl
    | h :: tl when h = List.hd acc -> left_shift_no_add (shift_helper ((2*h) :: List.tl acc @ tl) [] )
    | h :: tl -> shift_helper (h :: acc) tl
  in
  shift_helper [] row

let left_shift_grid grid = List.map left_shift_row grid

let move_to_four row = (left_shift_row row ) @ List.init (4 - (List.length row)) (fun _ ->0)

let right_shift_row row = 
  (List.rev row) |> left_shift_row |> List.rev

let right_shift_grid grid = List.map right_shift_row grid