type grid = string list list

let board : grid = [[""]]

let left_shift_row row =
  let rec shift_helper acc = function
    | [] -> List.rev acc
    | h :: tl when h = 0 -> shift_helper acc tl
    | h :: tl when acc = [] -> shift_helper [h] tl
    | h :: tl when h = List.hd acc -> shift_helper ((2*h) :: List.tl acc @ tl) []
    | h :: tl -> shift_helper (h :: acc) tl
  in
  shift_helper [] row

let right_shift_row row = 
  (List.rev row) |> left_shift_row |> List.rev