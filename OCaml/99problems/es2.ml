let rec last_two = function
| [] -> None 
| [x] -> None
| [x; y] -> Some (x,y)
| _ :: t -> (last_two [@tailcall]) t;;

last_two ["a"; "b"; "c"; "d"];;
last_two ["a"];;