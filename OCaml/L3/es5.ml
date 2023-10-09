(*
Define the following functions/operators on strings:

is_palindrome: string → bool that checks if the string is palindrome, 
  a string is palindrome when the represented sentence can be read the same way in either directions in spite of spaces, 
  punctual and letter cases, e.g., detartrated, "Do geese see God?", "Rise to vote, sir.", ...
operator (-): string → string → string that subtracts the letters in a string from the letters in another string, 
  e.g., "Walter Cazzola"-"abcwxyz" will give "Wlter Col" note that the operator - is case sensitive
anagram : string → string list → boolean that given a dictionary of strings, 
  checks if the input string is an anagram of one or more of the strings in the dictionary
*)
let parola = "a,.a";;
let is_palindrome s= 
  let rec is_palindrome_rec = function
    | "" -> true
    | s -> if ((String.length s)==1) then true 
          else if ((String.get s 0)==(String.get s ((String.length s)-1))) then 
            is_palindrome_rec (String.sub s 1 ((String.length s)-2)) 
          else false
  in is_palindrome_rec (String.concat "" (Str.split (Str.regexp "[,. \t]+?!") s));;
is_palindrome parola;;
let meno s1 s2 =
  let rec substract s1 s2 = 
    match s1 with 
      "" -> ""
    | _ ->  
      match s2 with 
        "" -> s1 
      | s -> substract (String.concat "" (Str.split (Str.regexp (Char.escaped (String.get s2 0))) s1)) (String.sub s2 1 ((String.length s2)-1))
  in substract s1 s2 
;;
meno "Walter Cazzola" "abcwxyz";;

let rec is_anagram = function
  | "", "" -> true
  | s1, s2 -> if (String.length s1)!=(String.length s2) then false 
          else is_anagram (meno s1 (String.make 1 (String.get s1 0)), meno s2 (String.make 1 (String.get s1 0)))
;;
let rec anagram s = function
  | [] -> false 
  | h::tl -> if (is_anagram (s, h)) then true else anagram s tl;;
anagram "calendario" ["aocandiera"; "locandiera"];;