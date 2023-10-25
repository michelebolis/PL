(*Let's write a function (or a pool of functions) that given a quite large text (over than 2000 words) 
counts how frequent each word occurs in the text.

The text is read from a file (look at the pervasive module in the manual) and it is a real text with punctuation 
(i.e., commas, semicolons, ...) that should be counted.

Note that words with different case should be considered the same.*)
(*usare prima #load "str.cma";;*)
let channel = open_in "text.txt";;
(* Funzione che dato un canale di input, restituisce una lista contenente le parole *)
let read channel= 
  let rec read_row l = 
    try 
      read_row (List.append l (Str.split (Str.regexp " ") (input_line channel))) 
    with 
      End_of_file -> l
  in read_row [];;
(* Funzione che data una lista di stringhe, le fa diventare tutte minuscole*)
let to_lower l =
  let rec to_lower_rec acc l= 
    match l with
    | h::tl -> to_lower_rec ((String.lowercase_ascii h)::acc) tl
    | _ -> acc
  in to_lower_rec [] l;;
(* Funzione che inserisce nella lista l, la coppia chiave, valore *)
let insert k v l = (k, v) :: l
(* Funzione che cerca la chive k nella lista *)
let rec lookup k = function
  | [] -> None
  | (k', v) :: t -> if k = k' then Some v else lookup k t
(* Funzione che data una lista di stringhe, restituisce una lista stringa, occorrenza *)
let occurrency l =
  let rec occurency_rec map = function
  | [] -> map
  | h::tl -> try 
                occurency_rec ((h, ((List.assoc h map)+1))::(List.remove_assoc h map)) tl
              with 
                Not_found -> occurency_rec (insert h 1 map) tl
  in occurency_rec [] l;;

let parole = (to_lower (read channel));;
occurrency parole;; 