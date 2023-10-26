open NaturalI
module N : NaturalI =
  struct
    type natural = Zero | Succ of natural 
    exception NegativeNumber
    exception DivisionByZero
    let rec eval = function 
    | Zero -> 0 
    | Succ (x) -> 1 + (eval x) 
    ;;
    let rec convert = function 
      | 0 -> Zero 
      | x when x>0 -> Succ(convert (x-1))
      | _ -> raise NegativeNumber
    ;;

    let rec ( + ) x y =  
      match (x, y) with 
      | (Zero, Zero) -> Zero 
      | (Succ(a), Zero) -> Succ(a)
      | (Zero, Succ(a)) -> Succ(a)
      | (a, Succ(b)) -> Succ(a) + Succ(b)
    ;;
    let rec ( - ) x y = 
      match (x, y) with 
      | (Zero, Zero) -> Zero 
      | (Succ(a), Zero) -> Succ(a)
      | (Zero, Succ(a)) -> raise NegativeNumber
      | (Succ(a), Succ(b)) -> a - b
    ;;
    let rec ( * ) x y = 
      match (x, y) with 
      | (Zero, Zero) -> Zero 
      | (Succ(a), Zero) -> Zero
      | (Zero, Succ(a)) -> Zero
      | (a, Succ(b)) -> (a * b) + a
    ;;
    let rec ( / ) x y = 
      match (x, y) with 
      | (_, Zero) -> raise DivisionByZero 
      | (Zero, _) -> Zero
      | (a, b) -> 
        if (compare a b = 1) then Zero else Succ((a-b) / b)
    ;;

    let rec compare = function 
    | (Succ(x), Zero) -> 0
    | (Zero, Succ(x)) -> 1
    | (Zero, Zero) -> (-1) 
    | (Succ(a), Succ(b)) -> compare (a,b)
  end;;