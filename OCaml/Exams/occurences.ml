(*
input [4; 4; 4; 4; 4; 4; 5; 5; 3; 5; 5; 5; 8; 9; 9]
output [6; 2; 1; 3; 1; 2]
*)
let occurencies a = 
  let rec occurencies_rec result current_count = function 
    | _::[] -> current_count::result
    | h::next::tl when h=next -> occurencies_rec result (current_count+1) (next::tl) 
    | h::next::tl -> occurencies_rec (current_count::result) 1 (next::tl) 
  in List.rev (occurencies_rec [] 1 a)

let arr_test = [4; 4; 4; 4; 4; 4; 5; 5; 3; 5; 5; 5; 8; 9; 9];;
let test = occurencies arr_test;;