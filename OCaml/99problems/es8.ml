let compress l =
  let rec compress acc = function 
  | h::[] -> h::acc 
  | h::mid::tl when h=mid -> compress acc (mid::tl)
  | h::mid::tl -> compress (h::acc) (mid::tl)
in List.rev (compress [] l);;
compress ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e"];;