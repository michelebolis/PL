(*
Put into a list, called alkaline_earth_metals, the atomic numbers of the six alkaline earth metals: 
beryllium (4), magnesium (12), calcium (20), strontium (38), barium (56), and radium (88). Then

Write a function that returns the highest atomic number in alkaline_earth_metals.
Write a function that sorts alkaline_earth_metals in ascending order (from the lightest to the heaviest).
Put into a second list, called noble_gases, the noble gases: helium (2), neon (10), argon (18), krypton (36), xenon (54), and radon (86). Then

Write a function (or a group of functions) that merges the two lists and print the result as couples (name, atomic number) sorted in ascending order on the element names.   
*)

let alkaline_earth_metals = [4;12;20;38;56;88];;

let heaviest l =  
  let rec find_max max = function
    [] -> max 
    | h::tl -> if(h>max) then find_max h tl else find_max max tl
  in find_max (-1) l;;
heaviest alkaline_earth_metals;;

let rec sort_reversed = function 
    [] -> []
    | h::tl -> 
            if (h==(heaviest (h::tl))) 
                then h::(sort_reversed tl)
                else sort_reversed (List.append tl [h]);;
let sort l = List.rev (sort_reversed l);;

let rec print_recursive = function 
    [] -> []
    | h::tl -> print_int h; print_string "; "; print_recursive tl;;
print_recursive (sort alkaline_earth_metals);;

let noble_gases = [2; 10; 18; 36; 54; 86];;
let new_list = List.append alkaline_earth_metals noble_gases;;
print_recursive (sort new_list);;