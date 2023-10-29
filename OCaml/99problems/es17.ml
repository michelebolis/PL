let split l n = 
  let rec split acc k = function 
    | [] -> (List.rev acc, []) 
    | h::tl when k = n -> (List.rev (h::acc), tl)
    | h::tl -> split (h::acc) (k+1) tl 
  in split [] 1 l;;
split ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"] 3;;
split ["a"; "b"; "c"; "d"] 5;;