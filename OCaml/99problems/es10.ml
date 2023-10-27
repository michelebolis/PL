let encode l = 
  let rec encode count acc = function
  | [] -> []
  | h::[] -> (count+1, h)::acc
  | h::mid::tl when h=mid -> encode (count+1) acc (mid::tl)
  | h::mid::tl -> encode 0 ((count+1, h)::acc) (mid::tl)
in List.rev (encode 0 [] l) ;;
encode ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e"];;