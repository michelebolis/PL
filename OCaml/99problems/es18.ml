let slice l i k = 
  let rec slice acc count = function 
    | [] -> acc 
    | h::tl when (count>=i && count<=k) -> slice (h::acc) (count+1) tl
    | _::tl -> slice acc (count+1) tl 
  in List.rev (slice [] 0 l);;
slice ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"] 2 6;;