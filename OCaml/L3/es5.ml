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
            is_palindrome (String.sub s 1 ((String.length s)-2)) 
          else false
  in is_palindrome_rec (String.concat "" (Str.split (Str.regexp "[,. \t]+?!") s));;
is_palindrome parola;;