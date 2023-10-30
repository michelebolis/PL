let lotto_select n m = 
  let range i k = 
    let rec range_rec acc low high = function 
      | count when count = high -> count::acc
      | count -> range_rec (count::acc) low high (count + 1)
    in 
    match (i, k) with
      | (i, k) when i<k -> List.rev (range_rec [] i k i)
      | (i, k) when i>k -> range_rec [] k i k
      | (i, _) -> [i] 
  in 
  let rand_select l n = 
    let rec remove pos count acc = function 
      | [] -> ([], [])
      | h::tl when count = pos -> ([h], (List.rev_append acc tl))
      | h::tl -> remove pos (count + 1) (h::acc) tl
    in 
      let rec rand_select acc l = function 
        | k when k = n -> acc
        | k -> let remove_rand = remove (Random.int (List.length l)) 0 [] l
                in match remove_rand with 
                  | ([x], l) -> rand_select (x::acc) (l) (k+1)
                  | (_, _) -> acc
      in rand_select [] l 0
  in rand_select (range 1 m) n;;
lotto_select 6 49;;
(*- : int list = [10; 20; 44; 22; 41; 2]*)