(*
input [4; 4; 4; 4; 4; 4; 5; 5; 3; 5; 5; 5; 8; 9; 9]
output [6; 2; 1; 3; 1; 2]
*)
let occurencies a = 
  let rec occurencies acc count = function 
    | [] -> []
    | _::[] -> count::acc
    | h::next::tl when h=next -> occurencies acc (count + 1) (next::tl) 
    | h::next::tl -> occurencies (count::acc) 1 (next::tl) 
  in List.rev (occurencies [] 1 a)

let arr_test = [4; 4; 4; 4; 4; 4; 5; 5; 3; 5; 5; 5; 8; 9; 9];;
let test = occurencies arr_test;;