(*
sin(x) can be approximate by the Taylor's series:


Similarly you can approximate all the trigonometric and transcendent functions (look at: http://en.wikipedia.org/wiki/Taylor_series).
Let's write a module to implement sin x n by using the Taylor's series 
(where n is the level of approximation, i.e., 1 only one item, 2 two items, 3 three items and so on). 

Do the same with cosine, tangent, logarithm and so on.

Let's compare your functions with those implemented in the pervasive module at the growing of the approximation level.   
*)
module Trigonometric : 
  sig
    val sin : float -> int -> float
  end
  = 
  struct 
    let rec fact = function
      | 1 -> 1
      | x -> x * (fact (x - 1))
    ;;

    let rec pow x = function
      | 0 -> 1.0
      | i -> x *. (pow x (i-1))
    ;;

    let sin x n = 
      if(x = 0.0) then 0.0 else
      let rec sin_add = function
        | 1 -> x
        | i -> if(i mod 2==0) then
                let exp = ((i*2)-1) in -.(pow x exp /. (float (fact exp))) +. sin_add (i-1)
              else
                let exp = ((i*2)-1) in (pow x exp /. (float (fact exp))) +. sin_add (i-1)
      in sin_add n
    ;;
  end
;;