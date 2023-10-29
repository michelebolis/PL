let rotate l = 
  let rec rotate l_r acc count lim = function 
  | [] -> (List.rev_append acc (List.rev l_r)) 
  | h::tl when count <= lim -> rotate (h::l_r) acc (count+1) lim tl 
  | h::tl -> rotate l_r (h::acc) (count+1) lim tl
in 
  function 
    | k when k>0 -> rotate [] [] 1 k l
    | k when k<0 -> let n = List.length l
                      in rotate [] [] 1 (n + (k mod n)) l
    | _ -> l;;

rotate ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"] 3;;
(*- : string list = ["d"; "e"; "f"; "g"; "h"; "a"; "b"; "c"]*)
rotate ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"] (-2);;
(*- : string list = ["g"; "h"; "a"; "b"; "c"; "d"; "e"; "f"]*)