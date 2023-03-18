(* open OUnit2
open Grid
open Move

let left_shift_row_test (name : string) (row : list)
    (expected_output : list) : test =
  name >:: fun _ ->
  (* the [printer] tells OUnit how to convert the output to a string *)
  assert_equal expected_output (left_shift_row (row))

let grid_tests =
  [
    
  ]

  let move_tests =
    [
      
    ]
let suite =
  "test suite for A2"
  >::: List.flatten [ grid_tests; move_tests ]

let _ = run_test_tt_main suite
 *)