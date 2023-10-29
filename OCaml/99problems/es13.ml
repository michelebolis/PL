let duplicate l = 
  let rec duplicate acc = function 
   | [] -> acc
   | h::tl -> duplicate (h::(h::acc)) tl
  in List.rev (duplicate [] l);;
duplicate ["a"; "b"; "c"; "c"; "d"];;