(*Let's write a function (or a pool of functions) that given a quite large text (over than 2000 words) 
counts how frequent each word occurs in the text.

The text is read from a file (look at the pervasive module in the manual) and it is a real text with punctuation 
(i.e., commas, semicolons, ...) that should be counted.

Note that words with different case should be considered the same.*)
(*usare prima #load "str.cma";;*)
type map_entry = {s:string; n:int};;
let channel = Stdlib.open_in "text.txt";;
let leggi channel= 
  let rec leggi_riga l = 
    try leggi_riga (List.append l (Str.split (Str.regexp " ") (Stdlib.input_line channel))) with End_of_file -> l
  in leggi_riga [];;
let to_lower l =
  let rec to_lower_rec acc list= 
    match list with
    | (h::tl) -> to_lower_rec ((String.lowercase_ascii h)::acc) tl
    | _ -> acc
  in to_lower_rec [] l;;
let occurrency l =
  let rec occurency_rec map= function
  | h::tl -> try let x = (List.find (fun x -> (x.s==h)) map) (*(occurency_rec x.n==((x.n)+1))::map tl*) 
              with Not_found -> occurency_rec {s=h;n=1}::map tl;
              occurency_rec x.n==((x.n)+1)::map tl;
  | [] -> map
  in occurency_rec [] l;;
let parole = (to_lower (leggi channel));;
occurrency parole;; 