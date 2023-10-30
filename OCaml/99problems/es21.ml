let insert_at x i l =
  let rec insert_at count acc = function 
    | [] -> List.rev (x::acc) 
    | h::tl when count = i -> List.rev_append acc (x::h::tl)
    | h::tl -> insert_at (count + 1) (h::acc) tl
  in insert_at 0 [] l;;
insert_at "alfa" 1 ["a"; "b"; "c"; "d"];;
(*- : string list = ["a"; "alfa"; "b"; "c"; "d"]*)
insert_at "alfa" 3 ["a"; "b"; "c"; "d"];;
(*- : string list = ["a"; "b"; "c"; "alfa"; "d"]*)
insert_at "alfa" 4 ["a"; "b"; "c"; "d"];;
(*- : string list = ["a"; "b"; "c"; "d"; "alfa"]*)