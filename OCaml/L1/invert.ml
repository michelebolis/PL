let invert x =
  match x with
  | true -> false 
  | false -> true;;
invert false;;
invert true;;
let invert' = function 
  true -> false
  | false -> true;;