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

let left_shift_test_rev (name : string) (input : int list) (output : int list) :
    test =
  name >:: fun _ ->
  assert_equal ~printer:list_to_string output (left_shift_rev input)

let right_shift_test_rev (name : string) (input : int list) (output : int list)
    : test =
  name >:: fun _ ->
  assert_equal ~printer:list_to_string (right_shift_rev input) output

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
    left_shift_test_rev "one value left shift" [ 0; 2048; 0; 0 ]
      [ 2048; 0; 0; 0 ];
    left_shift_test_rev "two value left shift, no spaces" [ 0; 2048; 1024; 0 ]
      [ 2048; 1024; 0; 0 ];
    left_shift_test_rev "two value left shift, spaces between"
      [ 0; 2048; 0; 512 ] [ 2048; 512; 0; 0 ];
    left_shift_test_rev "two equal value left shift" [ 0; 2048; 2048; 0 ]
      [ 1024; 0; 0; 0 ];
    left_shift_test_rev "three equal value left shift" [ 0; 2048; 2048; 2048 ]
      [ 1024; 2048; 0; 0 ];
    right_shift_test_rev "one value right shift" [ 0; 0; 2048; 0 ]
      [ 0; 0; 0; 2048 ];
  ]

let check_win_test (name : string) (gm : Game.gamemode ref)
    (grid : int list list) (output : unit) : test =
  name >:: fun _ -> assert_equal output (Game.check_win gm grid)

let check_lose_test (name : string) (grid : int list list) (output : unit) :
    test =
  name >:: fun _ -> assert_equal output (Game.check_lose grid)

let ref_normal = ref Game.Normal
let ref_easy = ref Game.Easy
let ref_rev = ref Game.Reverse

let game_tests =
  [
    check_win_test "all 0s" ref_normal
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (Game.game_won := true);
    check_win_test "has 2048" ref_normal
      [ [ 0; 0; 0; 2048 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (Game.game_won := true);
    check_win_test "doesnt have 2048" ref_normal
      [ [ 0; 0; 0; 2 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (Game.game_won := false);
    check_win_test "has 512" ref_easy
      [ [ 0; 0; 0; 512 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (Game.game_won := true);
    check_win_test "doesnt have 512" ref_easy
      [ [ 0; 0; 0; 2 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (Game.game_won := false);
    check_win_test "has 1" ref_rev
      [
        [ 0; 0; 0; 1024 ];
        [ 2048; 0; 1024; 0 ];
        [ 512; 2; 1; 512 ];
        [ 0; 0; 4; 0 ];
      ]
      (Game.game_won := true);
    check_win_test "doesnt have 1" ref_rev
      [
        [ 0; 0; 0; 1024 ];
        [ 2048; 0; 1024; 0 ];
        [ 512; 2; 2; 512 ];
        [ 0; 0; 4; 0 ];
      ]
      (Game.game_won := false);
    check_lose_test "all 0s"
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (Game.game_lose := true);
    check_lose_test
      "all full board w/ adjacent numbers, up and down, right to left both work"
      [
        [ 4; 4; 2; 16 ];
        [ 4; 32; 1024; 512 ];
        [ 2; 8; 64; 128 ];
        [ 256; 256; 2; 8 ];
      ]
      (Game.game_lose := false);
    check_lose_test "all full board w/ adjacent numbers side to side"
      [
        [ 4; 4; 2; 16 ];
        [ 8; 32; 1024; 512 ];
        [ 2; 8; 64; 128 ];
        [ 4; 256; 2; 8 ];
      ]
      (Game.game_lose := false);
    check_lose_test "all full board w/ multiple sets of adjacent numbers"
      [
        [ 4; 4; 2; 16 ];
        [ 8; 32; 32; 512 ];
        [ 2; 8; 64; 512 ];
        [ 256; 256; 256; 8 ];
      ]
      (Game.game_lose := false);
    check_lose_test "all full board w/ adjacent numbers up and down"
      [
        [ 4; 8; 2; 16 ];
        [ 4; 32; 1024; 512 ];
        [ 2; 8; 64; 128 ];
        [ 4; 256; 2; 8 ];
      ]
      (Game.game_lose := false);
    check_lose_test "all full board w/o adjacent numbers"
      [
        [ 8; 4; 2; 16 ];
        [ 4; 32; 1024; 512 ];
        [ 2; 8; 64; 128 ];
        [ 256; 4; 2; 8 ];
      ]
      (Game.game_lose := true);
    check_lose_test "w/o adjacent numbers with 0s"
      [
        [ 1028; 4; 2; 16 ];
        [ 4; 32; 0; 512 ];
        [ 2; 8; 64; 128 ];
        [ 256; 4; 2; 8 ];
      ]
      (Game.game_lose := false);
    check_lose_test "only adjacent numbers are 0s"
      [
        [ 8; 4; 2; 1028 ];
        [ 4; 32; 0; 0 ];
        [ 2; 8; 64; 128 ];
        [ 256; 4; 2; 1028 ];
      ]
      (Game.game_lose := false);
  ]

let suite =
  "test suite for our project" >::: List.flatten [ grid_tests; game_tests ]

let _ = run_test_tt_main suite
