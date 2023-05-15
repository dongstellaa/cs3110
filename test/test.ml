(**
    Test Plan:
    Game
    - Majority of the Game module was manually tested through running the game
      through terminal because it relied on connections with other modules and 
      user input or for functions like move_grid, relied on the correctness of 
      other modules. 
    - We used OUnit (glass box testing) for check_win and check_lose to get all 
      possible branches in the code and make sure a win and a loss is always 
      correctly detected.

    Grid
    - This module used mostly OUnit testing, specifically glass box. Because the
      movement of the grid is so important to the game, we used tried to get as 
      much coverage as possible and also ran the game in terminal, found cases 
      errors, then created OUnit tests for those as well.
    - Add_tile and add_tile_rev were manually tested in the terminal because 
      their outputs are randomized. Because this function is called in between 
      each move, it was easy to keep playing the game and evaluate each grid for 
      the correct output from add_tile.

    Hangman
    - Many of the functions in hangman are of type unit and print in the 
      terminal, so for those functions, we manually tested them as they were
      implemented.
    - The remaining few functions, like to_char_list, used both glass box 
      testing and manual testing. Glass box testing was used throughout the
      implementation and then as we were figuring out how to connect this module
      to the rest of the game, we ended up playing a lot of hangman :|.

    Input
    - Most of the Input module was testing manually as the executable game file 
      was set up or as functions were added, like adding a new gamemode had to
      repeatedly test the functions called to make the gamemode work. Through 
      that sequence of testing as implementation progressed, we know that each
      feature that we added works as needed.
    - grid_action used OUnit testing specifically to test invalid moves, when a 
      move did not actually update the grid, to get full coverage of the
      function.

    Ui
    - For the few functions in Ui, they were only tested manually because they 
      all print directly to the terminal. Because those functions are called for
      every single move, it's obvious when they were not implemented correctly 
      and could easily be debugged.
*)

open OUnit2
open Board
open Grid
open Game
open Hangman
open Input

let list_to_string lst =
  let element_to_string elem = string_of_int elem in
  let elements_str = List.map element_to_string lst in
  String.concat " " elements_str

let list_list_to_string (lst : int list list) : string =
  let row_to_string row =
    let elements_str = List.map string_of_int row in
    String.concat " " elements_str
  in
  let rows_str = List.map row_to_string lst in
  String.concat "\n" rows_str

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

let row_tests =
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
    left_shift_test "4 of the same, all add" [ 2048; 2048; 2048; 2048 ]
      [ 4096; 4096; 0; 0 ];
    right_shift_test "one value right shift" [ 0; 0; 2; 0 ] [ 0; 0; 0; 2 ];
    right_shift_test "two value right shift, spaces between" [ 8; 0; 0; 2 ]
      [ 0; 0; 8; 2 ];
    right_shift_test "two equal values right shift" [ 0; 2; 2; 0 ]
      [ 0; 0; 0; 4 ];
    right_shift_test "multiple values, no adding" [ 8; 4; 0; 2 ] [ 0; 8; 4; 2 ];
    right_shift_test "multiple values, w adding" [ 2048; 4; 4; 2 ]
      [ 0; 2048; 8; 2 ];
    right_shift_test "4 of the same, all add" [ 2048; 2048; 2048; 2048 ]
      [ 0; 0; 4096; 4096 ];
    left_shift_test_rev "empty" [ 0; 0; 0; 0 ] [ 0; 0; 0; 0 ];
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
    right_shift_test_rev "empty" [ 0; 0; 0; 0 ] [ 0; 0; 0; 0 ];
    right_shift_test_rev "one value right shift" [ 0; 0; 2048; 0 ]
      [ 0; 0; 0; 2048 ];
    right_shift_test_rev "two value right shift, spaces between"
      [ 2048; 0; 0; 2 ] [ 0; 0; 2048; 2 ];
    right_shift_test_rev "two equal values right shift" [ 0; 2048; 2048; 0 ]
      [ 0; 0; 0; 1024 ];
    right_shift_test_rev "multiple values, no adding" [ 2048; 1024; 0; 512 ]
      [ 0; 2048; 1024; 512 ];
    right_shift_test_rev "multiple values, w adding" [ 2048; 4; 4; 2 ]
      [ 0; 2048; 2; 2 ];
    right_shift_test_rev "4 of the same, all add" [ 2048; 2048; 2048; 2048 ]
      [ 0; 0; 1024; 1024 ];
  ]

let up_shift_test_grid (name : string) (input : int list list)
    (output : int list list) : test =
  name >:: fun _ ->
  assert_equal ~printer:list_list_to_string (up_shift_grid input) output

let down_shift_test_grid (name : string) (input : int list list)
    (output : int list list) : test =
  name >:: fun _ ->
  assert_equal ~printer:list_list_to_string (down_shift_grid input) output

let grid_tests =
  [
    up_shift_test_grid "all 0s"
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ];
    up_shift_test_grid "one value"
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 2048; 0; 0; 0 ] ]
      [ [ 2048; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ];
    up_shift_test_grid "multiple columns, no merge"
      [
        [ 0; 1024; 0; 0 ];
        [ 0; 2048; 0; 0 ];
        [ 0; 0; 512; 0 ];
        [ 2048; 0; 0; 512 ];
      ]
      [
        [ 2048; 1024; 512; 512 ];
        [ 0; 2048; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
      ];
    up_shift_test_grid "one in each column"
      [
        [ 0; 1024; 0; 0 ];
        [ 0; 0; 2048; 0 ];
        [ 0; 0; 0; 0 ];
        [ 2048; 0; 0; 512 ];
      ]
      [
        [ 2048; 1024; 2048; 512 ];
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
      ];
    up_shift_test_grid "multiple columns, merge"
      [
        [ 0; 1024; 0; 0 ];
        [ 0; 2048; 0; 512 ];
        [ 2048; 0; 512; 0 ];
        [ 2048; 0; 0; 512 ];
      ]
      [
        [ 4096; 1024; 512; 1024 ];
        [ 0; 2048; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
      ];
    up_shift_test_grid "multiple columns, don't want pair merge"
      [
        [ 0; 1024; 0; 1024 ];
        [ 0; 2048; 0; 512 ];
        [ 2048; 0; 512; 0 ];
        [ 2048; 0; 0; 512 ];
      ]
      [
        [ 4096; 1024; 512; 1024 ];
        [ 0; 2048; 0; 1024 ];
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
      ];
    up_shift_test_grid "two different adjacent pairs"
      [
        [ 2048; 1024; 0; 1024 ];
        [ 2048; 2048; 0; 512 ];
        [ 2; 0; 512; 0 ];
        [ 2; 0; 0; 512 ];
      ]
      [
        [ 4096; 1024; 512; 1024 ];
        [ 4; 2048; 0; 1024 ];
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
      ];
    up_shift_test_grid "multiple columns, 3 of the same"
      [
        [ 0; 1024; 0; 512 ];
        [ 0; 2048; 0; 0 ];
        [ 2048; 0; 512; 512 ];
        [ 2048; 0; 0; 512 ];
      ]
      [
        [ 4096; 1024; 512; 1024 ];
        [ 0; 2048; 0; 512 ];
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
      ];
    up_shift_test_grid "multiple columns, 4 of the same"
      [
        [ 0; 1024; 0; 512 ];
        [ 0; 2048; 0; 512 ];
        [ 2048; 0; 512; 512 ];
        [ 2048; 0; 0; 512 ];
      ]
      [
        [ 4096; 1024; 512; 1024 ];
        [ 0; 2048; 0; 1024 ];
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
      ];
    up_shift_test_grid "grid all same number"
      [
        [ 512; 512; 512; 512 ];
        [ 512; 512; 512; 512 ];
        [ 512; 512; 512; 512 ];
        [ 512; 512; 512; 512 ];
      ]
      [
        [ 1024; 1024; 1024; 1024 ];
        [ 1024; 1024; 1024; 1024 ];
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
      ];
    down_shift_test_grid "all 0s"
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ];
    down_shift_test_grid "one value, no movement"
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 2048; 0; 0; 0 ] ]
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 2048; 0; 0; 0 ] ];
    down_shift_test_grid "one value, movement"
      [ [ 2048; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 2048; 0; 0; 0 ] ];
    down_shift_test_grid "multiple columns, no merge"
      [
        [ 2048; 0; 0; 0 ];
        [ 0; 512; 0; 1024 ];
        [ 0; 0; 0; 0 ];
        [ 0; 4096; 0; 0 ];
      ]
      [
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 0; 512; 0; 0 ];
        [ 2048; 4096; 0; 1024 ];
      ];
    down_shift_test_grid "one in each column"
      [
        [ 0; 1024; 0; 0 ];
        [ 0; 0; 2048; 0 ];
        [ 0; 0; 0; 0 ];
        [ 2048; 0; 0; 512 ];
      ]
      [
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 2048; 1024; 2048; 512 ];
      ];
    down_shift_test_grid "multiple columns, merges"
      [
        [ 2048; 0; 0; 0 ];
        [ 0; 512; 0; 1024 ];
        [ 2; 512; 0; 0 ];
        [ 2; 4096; 0; 0 ];
      ]
      [
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 2048; 1024; 0; 0 ];
        [ 4; 4096; 0; 1024 ];
      ];
    down_shift_test_grid "multiple columns, twi different merges adjacent"
      [
        [ 4; 0; 0; 2048 ];
        [ 4; 512; 0; 1024 ];
        [ 2; 512; 0; 0 ];
        [ 2; 4096; 0; 0 ];
      ]
      [
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 8; 1024; 0; 2048 ];
        [ 4; 4096; 0; 1024 ];
      ];
    down_shift_test_grid "multiple columns, three of the same"
      [
        [ 0; 0; 0; 2048 ];
        [ 2; 512; 0; 1024 ];
        [ 2; 512; 0; 0 ];
        [ 2; 4096; 0; 0 ];
      ]
      [
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 2; 1024; 0; 2048 ];
        [ 4; 4096; 0; 1024 ];
      ];
    down_shift_test_grid "multiple columns, 4 of the same"
      [
        [ 2048; 0; 0; 1024 ];
        [ 0; 512; 0; 1024 ];
        [ 2; 512; 0; 1024 ];
        [ 2; 4096; 0; 1024 ];
      ]
      [
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 2048; 1024; 0; 2048 ];
        [ 4; 4096; 0; 2048 ];
      ];
    down_shift_test_grid "grid all same number"
      [
        [ 512; 512; 512; 512 ];
        [ 512; 512; 512; 512 ];
        [ 512; 512; 512; 512 ];
        [ 512; 512; 512; 512 ];
      ]
      [
        [ 0; 0; 0; 0 ];
        [ 0; 0; 0; 0 ];
        [ 1024; 1024; 1024; 1024 ];
        [ 1024; 1024; 1024; 1024 ];
      ];
  ]

let check_win_test (name : string) (gm : gamemode ref) (grid : int list list)
    (output : unit) : test =
  name >:: fun _ -> assert_equal output (check_win gm grid)

let check_lose_test (name : string) (grid : int list list) (output : unit) :
    test =
  name >:: fun _ -> assert_equal output (check_lose grid)

let ref_normal = ref Normal
let ref_easy = ref Easy
let ref_rev = ref Reverse
let ref_unl = ref Unselected

let game_tests =
  [
    check_win_test "all 0s" ref_normal
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (game_won := true);
    check_win_test "has 2048" ref_normal
      [ [ 0; 0; 0; 2048 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (game_won := true);
    check_win_test "doesnt have 2048" ref_normal
      [ [ 0; 0; 0; 2 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (game_won := false);
    check_win_test "has 512" ref_easy
      [ [ 0; 0; 0; 512 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (game_won := true);
    check_win_test "doesnt have 512" ref_easy
      [ [ 0; 0; 0; 2 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (game_won := false);
    check_win_test "has 1" ref_rev
      [
        [ 0; 0; 0; 1024 ];
        [ 2048; 0; 1024; 0 ];
        [ 512; 2; 1; 512 ];
        [ 0; 0; 4; 0 ];
      ]
      (game_won := true);
    check_win_test "doesnt have 1" ref_rev
      [
        [ 0; 0; 0; 1024 ];
        [ 2048; 0; 1024; 0 ];
        [ 512; 2; 2; 512 ];
        [ 0; 0; 4; 0 ];
      ]
      (game_won := false);
    check_win_test "unselected always false" ref_unl
      [
        [ 0; 0; 0; 1024 ];
        [ 2048; 0; 1024; 0 ];
        [ 512; 2; 2; 512 ];
        [ 0; 0; 4; 0 ];
      ]
      (game_won := false);
    check_lose_test "all 0s"
      [ [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      (game_lose := true);
    check_lose_test
      "all full board w/ adjacent numbers, up and down, right to left both work"
      [
        [ 4; 4; 2; 16 ];
        [ 4; 32; 1024; 512 ];
        [ 2; 8; 64; 128 ];
        [ 256; 256; 2; 8 ];
      ]
      (game_lose := false);
    check_lose_test "all full board w/ adjacent numbers side to side"
      [
        [ 4; 4; 2; 16 ];
        [ 8; 32; 1024; 512 ];
        [ 2; 8; 64; 128 ];
        [ 4; 256; 2; 8 ];
      ]
      (game_lose := false);
    check_lose_test "all full board w/ multiple sets of adjacent numbers"
      [
        [ 4; 4; 2; 16 ];
        [ 8; 32; 32; 512 ];
        [ 2; 8; 64; 512 ];
        [ 256; 256; 256; 8 ];
      ]
      (game_lose := false);
    check_lose_test "all full board w/ adjacent numbers up and down"
      [
        [ 4; 8; 2; 16 ];
        [ 4; 32; 1024; 512 ];
        [ 2; 8; 64; 128 ];
        [ 4; 256; 2; 8 ];
      ]
      (game_lose := false);
    check_lose_test "all full board w/o adjacent numbers"
      [
        [ 8; 4; 2; 16 ];
        [ 4; 32; 1024; 512 ];
        [ 2; 8; 64; 128 ];
        [ 256; 4; 2; 8 ];
      ]
      (game_lose := true);
    check_lose_test "w/o adjacent numbers with 0s"
      [
        [ 1028; 4; 2; 16 ];
        [ 4; 32; 0; 512 ];
        [ 2; 8; 64; 128 ];
        [ 256; 4; 2; 8 ];
      ]
      (game_lose := false);
    check_lose_test "only adjacent numbers are 0s"
      [
        [ 8; 4; 2; 1028 ];
        [ 4; 32; 0; 0 ];
        [ 2; 8; 64; 128 ];
        [ 256; 4; 2; 1028 ];
      ]
      (game_lose := false);
  ]

let to_char_list_test (name : string) (word : string) (output : char list) :
    test =
  name >:: fun _ -> assert_equal output (to_char_list word)

let has_won_test (name : string) (word : string) (guessed_chars : char list)
    (output : bool) : test =
  name >:: fun _ -> assert_equal output (has_won word guessed_chars)

let hangman_tests =
  [
    to_char_list_test "empty string" "" [];
    to_char_list_test "simple word" "cat" [ 'c'; 'a'; 't' ];
    to_char_list_test "word w/ spaces" "big boy"
      [ 'b'; 'i'; 'g'; ' '; 'b'; 'o'; 'y' ];
    has_won_test "simple word" "cat" [ 'c'; 'a'; 't' ] true;
    has_won_test "word w repeating letters" "pussy" [ 'p'; 'u'; 's'; 'y' ] true;
    has_won_test "not in order" "pussy" [ 's'; 'y'; 'u'; 'p' ] true;
    has_won_test "false case" "pussy" [ 's'; 'u'; 'p' ] false;
    has_won_test "word with spaces" "ra wr" [ 'r'; 'a'; ' '; 'w' ] true;
  ]

let grid_action_test (name : string) (input : string) (grid : int list list)
    (gm : gamemode ref) (output : int list list) : test =
  name >:: fun _ ->
  assert_equal ~printer:list_list_to_string output (grid_action input grid gm)

let input_tests =
  [
    grid_action_test "invalid move left" "a"
      [ [ 0; 0; 0; 0 ]; [ 32; 16; 8; 4 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      ref_normal
      [ [ 0; 0; 0; 0 ]; [ 32; 16; 8; 4 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ];
    grid_action_test "invalid move right" "d"
      [ [ 0; 0; 0; 0 ]; [ 32; 16; 8; 4 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ]
      ref_normal
      [ [ 0; 0; 0; 0 ]; [ 32; 16; 8; 4 ]; [ 0; 0; 0; 0 ]; [ 0; 0; 0; 0 ] ];
    grid_action_test "invalid move up" "w"
      [ [ 16; 2; 0; 0 ]; [ 8; 4; 0; 0 ]; [ 4; 8; 0; 0 ]; [ 2; 16; 0; 0 ] ]
      ref_normal
      [ [ 16; 2; 0; 0 ]; [ 8; 4; 0; 0 ]; [ 4; 8; 0; 0 ]; [ 2; 16; 0; 0 ] ];
    grid_action_test "invalid move down" "s"
      [ [ 16; 2; 0; 0 ]; [ 8; 4; 0; 0 ]; [ 4; 8; 0; 0 ]; [ 2; 16; 0; 0 ] ]
      ref_normal
      [ [ 16; 2; 0; 0 ]; [ 8; 4; 0; 0 ]; [ 4; 8; 0; 0 ]; [ 2; 16; 0; 0 ] ];
  ]

let suite =
  "test suite for our project"
  >::: List.flatten
         [ row_tests; grid_tests; game_tests; hangman_tests; input_tests ]

let _ = run_test_tt_main suite
