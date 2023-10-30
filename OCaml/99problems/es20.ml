let remove_at i l = 
  let rec remove_at count acc = function 
    | [] -> acc 
    | h::tl when count = i -> List.rev_append acc tl
    | h::tl -> remove_at (count + 1) (h::acc) tl 
  in remove_at 0 [] l;;
remove_at 1 ["a"; "b"; "c"; "d"];;
(*- : string list = ["a"; "c"; "d"]*)