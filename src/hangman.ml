let word_list =
  [
    "ocaml";
    "functional";
    "programming";
    "language";
    "hangman";
    "cat";
    "kitten";
    "feline";
    "whiskers";
    "purr";
    "meow";
    "claws";
    "paws";
    "pussy";
    "silly";
    "litter";
    "calico";
    "siamese";
    "ragdoll";
    "sphynx";
    "rawr";
    "poop";
    "nap";
    "cuddle";
    "catnip";
    "kitty";
    "bigboy";
  ]

let is_alpha = function 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false

let pick_word lst =
  let len = List.length lst in
  let index = Random.int len in
  List.nth lst index

let to_char_list word =
  let rec helper i acc =
    if i < 0 then acc else helper (i - 1) (word.[i] :: acc)
  in
  helper (String.length word - 1) []

let print_state word guessed_chars =
  let print_char c =
    if List.mem c guessed_chars then Printf.printf "%c " c
    else Printf.printf "_ "
  in
  List.iter print_char (to_char_list word);
  print_newline ()

let get_guess () =
  Printf.printf "Enter your guess: ";
  let guess = read_line () in
  if String.length guess <> 1 || not (is_alpha guess.[0]) then
    failwith "Invalid guess"
  else Char.lowercase_ascii guess.[0]

let update_guessed_chars c guessed_chars =
  if List.mem c guessed_chars then guessed_chars else c :: guessed_chars

let has_won word guessed_chars =
  let char_set = List.sort_uniq Char.compare (to_char_list word) in
  let non_repeating_chars =
    List.filter (fun c -> not (List.mem c [ '_'; '-' ])) char_set
  in
  List.for_all (fun c -> List.mem c guessed_chars) non_repeating_chars

let run_game () =
  let play_game () =
    Random.self_init ();
    let word = pick_word word_list in
    let guessed_chars = ref [] in
    let rec helper tries_left =
      if tries_left = 0 then false
      else if has_won word !guessed_chars then true
      else (
        Printf.printf "Tries left: %d\n" tries_left;
        print_state word !guessed_chars;
        let guess = get_guess () in
        guessed_chars := update_guessed_chars guess !guessed_chars;
        if not (List.mem guess (to_char_list word)) then helper (tries_left - 1)
        else helper tries_left)
    in
    helper 7
  in
  play_game ()
