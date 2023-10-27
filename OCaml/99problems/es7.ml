type 'a node =
| One of 'a 
| Many of 'a node list;;
let flatten l =
  let rec flatten acc = function 
  | [] -> acc 
  | One x ::tl -> flatten (x::acc) tl
  | Many x ::tl -> flatten (flatten acc x) tl
in List.rev (flatten [] l);;
flatten [One "a"; Many [One "b"; Many [One "c" ;One "d"]; One "e"]];;