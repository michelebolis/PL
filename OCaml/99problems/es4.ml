let length l = 
  let rec length n = function 
  | [] -> n 
  | _::tl -> length (n+1) tl 
in length 0 l;;
length ["a"; "b"; "c"];;
length [];;