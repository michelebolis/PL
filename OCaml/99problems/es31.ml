let is_prime = function 
  | 1 -> false 
  | x ->
  let rec is_prime = function 
    | 1 -> true 
    | y when x mod y = 0 -> false 
    | y -> is_prime (y - 1)
  in is_prime (x-1);;
not (is_prime 1);;
(*- : bool = true*)
is_prime 7;;
(*- : bool = true*)
not (is_prime 12);;
(*- : bool = true*)