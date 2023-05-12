open OUnit2
open Board
open Grid

let row_move_test (name : string) (input : int list) (output : int list) : test
    =
  name >:: fun _ -> assert_equal output (delete_zeros input)

let grid_tests = [ row_move_test "all zeros" [ 0; 0; 0; 0 ] [ 0; 0; 0; 0 ] ]
let suite = "test suite for A2" >::: List.flatten [ grid_tests ]
let _ = run_test_tt_main suite
