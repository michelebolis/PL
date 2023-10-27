let pack l =
  let rec pack acc temp = function 
  | [] -> []
  | h::[] -> (h::temp)::acc 
  | h::mid::tl when h=mid -> pack acc (h::temp) (mid::tl)
  | h::mid::tl -> pack ((h::temp)::acc) [] (mid::tl)
in List.rev (pack [] [] l);;
pack ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "d"; "e"; "e"; "e"; "e"];;