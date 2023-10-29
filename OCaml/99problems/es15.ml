let replicate l n = 
  let rec add_n x acc = function
  | 1 -> x::acc
  | k -> add_n x (x::acc) (k-1)
  in   
    let rec replicate acc = function 
    | [] -> acc
    | h::tl -> replicate (add_n h acc n) tl
    in List.rev (replicate [] l);;
replicate ["a"; "b"; "c"] 3;;