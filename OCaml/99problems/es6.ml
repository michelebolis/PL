let is_palindrome l = 
  let rec is_palindrome = function 
  | [], [] -> true  
  | [], _ -> false 
  | _, [] -> false
  | h1::tl1, h2::tl2 when h1=h2-> is_palindrome (tl1, tl2) 
  | _ -> false  
in is_palindrome (l, (List.rev l));;
is_palindrome ["x"; "a"; "m"; "a"; "x"];;
not (is_palindrome ["a"; "b"]);;

(* let is_palindrome list =
    list = List.rev list *)