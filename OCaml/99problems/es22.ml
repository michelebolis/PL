let range i k = 
  let rec range_rec acc low high = function 
    | count when count = high -> count::acc
    | count -> range_rec (count::acc) low high (count + 1)
  in 
  match (i, k) with
    | (i, k) when i<k -> List.rev (range_rec [] i k i)
    | (i, k) when i>k -> range_rec [] k i k
    | (i, _) -> [i] ;;
range 4 9;;
(*- : int list = [4; 5; 6; 7; 8; 9]*)
range 9 4;;
(*- : int list = [9; 8; 7; 6; 5; 4]*)