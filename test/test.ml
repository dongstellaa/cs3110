open OUnit2
open Board
open Grid

let rec list_to_string lst =
  match lst with
  | [] -> "[]"
  | [ x ] -> "[" ^ string_of_int x ^ "]"
  | x :: xs -> "[" ^ string_of_int x ^ "; " ^ list_to_string xs ^ "]"

let row_move_test (name : string) (input : int list) (output : int list) : test
    =
  name >:: fun _ -> assert_equal output (delete_zeros input)

let left_shift_test (name : string) (input : int list) (output : int list) :
    test =
  name >:: fun _ ->
  assert_equal ~printer:list_to_string output (left_shift input)

let right_shift_test (name : string) (input : int list) (output : int list) :
    test =
  name >:: fun _ ->
  assert_equal ~printer:list_to_string (right_shift input) output

let grid_tests =
  [
    row_move_test "all zeros" [ 0; 0; 0; 0 ] [];
    row_move_test "two values not equal" [ 0; 0; 2; 4 ] [ 2; 4 ];
    row_move_test "two values equal" [ 0; 0; 2; 2 ] [ 2; 2 ];
    row_move_test "three values, two of which are equal" [ 0; 4; 2; 2 ]
      [ 4; 2; 2 ];
    row_move_test "three values, all are equal" [ 0; 2; 2; 2 ] [ 2; 2; 2 ];
    row_move_test "four values, all of which are equal" [ 2; 2; 2; 2 ]
      [ 2; 2; 2; 2 ];
    left_shift_test "one value left shift" [ 0; 2; 0; 0 ] [ 2; 0; 0; 0 ];
    left_shift_test "one value left shift, more jumps" [ 0; 0; 0; 2 ]
      [ 2; 0; 0; 0 ];
    left_shift_test "two value left shift, no spaces" [ 0; 2; 4; 0 ]
      [ 2; 4; 0; 0 ];
    left_shift_test "two value left shift, spaces between" [ 0; 2; 0; 8 ]
      [ 2; 8; 0; 0 ];
    left_shift_test "two equal value left shift" [ 0; 2; 2; 0 ] [ 4; 0; 0; 0 ];
    left_shift_test "three equal value left shift" [ 0; 2; 2; 2 ] [ 4; 2; 0; 0 ];
    right_shift_test "one value right shift" [ 0; 0; 2; 0 ] [ 0; 0; 0; 2 ];
    right_shift_test "two value right shift, spaces between" [ 8; 0; 0; 2 ]
      [ 0; 0; 8; 2 ];
    right_shift_test "two equal values right shift" [ 0; 2; 2; 0 ]
      [ 0; 0; 0; 4 ];
  ]

let suite = "test suite for A2" >::: List.flatten [ grid_tests ]
let _ = run_test_tt_main suite
