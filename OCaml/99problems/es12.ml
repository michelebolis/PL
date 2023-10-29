type 'a rle =
    | One of 'a
    | Many of int * 'a;;
let decode l = 
  let rec add_n x acc = function
    | 1 -> x::acc
    | k -> add_n x (x::acc) (k-1)
  in   
    let rec decode acc = function 
      | [] -> acc 
      | One x::tl -> decode (x::acc) tl 
      | Many (n, x)::tl -> decode (add_n x acc n) tl
    in List.rev (decode [] l);;
decode [Many (4, "a"); One "b"; Many (2, "c"); Many (2, "a"); One "d"; Many (4, "e")];;