let rec at k = function
| [] -> None
| h::tl when k=1 -> Some h 
| h::tl -> at (k-1) tl;;

at 3 ["a"; "b"; "c"; "d"; "e"];;
at 3 ["a"];;