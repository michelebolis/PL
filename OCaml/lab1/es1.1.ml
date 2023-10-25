(*
Put into a list, called alkaline_earth_metals, the atomic numbers of the six alkaline earth metals: 
beryllium (4), magnesium (12), calcium (20), strontium (38), barium (56), and radium (88). Then

Write a function that returns the highest atomic number in alkaline_earth_metals.
Write a function that sorts alkaline_earth_metals in ascending order (from the lightest to the heaviest).
Put into a second list, called noble_gases, the noble gases: helium (2), neon (10), argon (18), krypton (36), xenon (54), and radon (86). Then

Write a function (or a group of functions) that merges the two lists and print the result as couples (name, atomic number) sorted in ascending order on the element names.   
*)
type metal = {name: string; atomic_number : int};;
let alkaline_earth_metals = [
  {name= "beryllium"; atomic_number= 4};
  {name= "magnesium"; atomic_number= 12};
  {name= "calcium"; atomic_number= 20};
  {name= "strontium"; atomic_number= 38};
  {name= "barium"; atomic_number= 56};
  {name= "radium"; atomic_number= 88}
];;
let noble_gases = [
  {name= "helium"; atomic_number=2}; 
  {name= "neon"; atomic_number=10}; 
  {name="argon"; atomic_number=18};
  {name="krypton"; atomic_number=36};
  {name="xenon"; atomic_number=54}; 
  {name="radon"; atomic_number=86}  
];;
let heaviest l =  
  let rec find_max max = function
    [] -> max 
    | h::tl -> if(h.atomic_number>max) then find_max h.atomic_number tl else find_max max tl
  in find_max (-1) l;;
heaviest alkaline_earth_metals;;
let rec sort_reversed = function 
    [] -> []
    | h::tl -> if (h.atomic_number==(heaviest (h::tl))) 
                then h::(sort_reversed tl)
                else sort_reversed (List.append tl [h]);;
let sort l = List.rev (sort_reversed l);;
let rec print_recursive = function 
    [] -> []
    | h::tl -> print_string h.name; print_string " "; print_int h.atomic_number; print_string "\n"; print_recursive tl;;
print_recursive (sort alkaline_earth_metals);;
let new_list = List.append alkaline_earth_metals noble_gases;;
print_recursive (sort new_list);;