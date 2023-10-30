let permutation l = 
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
  in rand_select l (List.length l);;
;;
permutation ["a"; "b"; "c"; "d"; "e"; "f"];;
(*- : string list = ["a"; "e"; "f"; "b"; "d"; "c"]*)