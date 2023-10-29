let drop l n = 
  let rec drop acc k = function 
    | [] -> acc 
    | h::tl when k = 1 -> drop acc n tl 
    | h::tl -> drop (h::acc) (k-1) tl 
  in List.rev (drop [] n l);;
drop ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"] 3;;
(*- : string list = ["a"; "b"; "d"; "e"; "g"; "h"; "j"]*)