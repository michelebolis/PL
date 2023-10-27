let rec rev = function 
| [] ->  []
| h::tl -> List.append (rev tl) [h];;
rev ["a"; "b"; "c"];;