(* Hangman game in OCaml *)

(* List of words to choose from *)
let word_list = [ "ocaml"; "functional"; "programming"; "language"; "hangman" ]
let is_alpha = function 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false

(* Function to pick a random word from the list *)
let pick_word lst =
  let len = List.length lst in
  let index = Random.int len in
  List.nth lst index

(* Function to convert a word to a list of characters *)
let to_char_list word =
  let rec helper i acc =
    if i < 0 then acc else helper (i - 1) (word.[i] :: acc)
  in
  helper (String.length word - 1) []

(* Function to print the current state of the game *)
let print_state word guessed_chars =
  let print_char c =
    if List.mem c guessed_chars then Printf.printf "%c " c
    else Printf.printf "_ "
  in
  List.iter print_char (to_char_list word);
  print_newline ()

(* Function to get a guess from the user *)
let get_guess () =
  Printf.printf "Enter your guess: ";
  let guess = read_line () in
  if String.length guess <> 1 || not (is_alpha guess.[0]) then
    failwith "Invalid guess"
  else Char.lowercase_ascii guess.[0]

(* Function to update the guessed characters list *)
let update_guessed_chars c guessed_chars =
  if List.mem c guessed_chars then guessed_chars else c :: guessed_chars

(* Function to check if the player has won *)
let has_won word guessed_chars =
  let char_set = List.sort_uniq Char.compare (to_char_list word) in
  let guessed_set = List.sort_uniq Char.compare guessed_chars in
  char_set = guessed_set

(* Function to play the game *)
let play_game () =
  Random.self_init ();
  let word = pick_word word_list in
  let guessed_chars = ref [] in
  let rec helper tries_left =
    if tries_left = 0 then failwith ("You lose! The word was " ^ word)
    else if has_won word !guessed_chars then print_endline "You win!"
    else (
      Printf.printf "Tries left: %d\n" tries_left;
      print_state word !guessed_chars;
      let guess = get_guess () in
      guessed_chars := update_guessed_chars guess !guessed_chars;
      if not (List.mem guess (to_char_list word)) then helper (tries_left - 1)
      else helper tries_left)
  in
  helper 7

(* Start the game *)
let () = play_game ()
