(*
Write the matrix datatype with the following operations:

A function zeroes to construct a matrix of size n×m filled with zeros.
A function identity to construct the identity matrix (the one with all 0s but the 1s on the diagonal) of given size.
A function init to construct a square matrix of a given size n filled with the first n×n integers.
A function transpose that transposes a generic matrix independently of its size and content.
The basics operators + and * that adds and multiplies two matrices non necessarily squared.
*)

(*let zeroes n m = Array.make_matrix n m 0;;*)
let zeroes n m =
  Array.init n (
    fun x -> Array.init m (
        fun x -> 0
      )
  );;
let identity n = 
  Array.init n (
    fun x -> Array.init n (
      fun y -> (if x<>y then 0 else 1)
    )
  );;
let init n =
  Array.init n (
    fun row -> Array.init n (
      fun col -> if(row==0) then col else ((row * n) + col) 
    )
  );;
let transpose m =
  Array.init (Array.length m.(0)) (
    fun row -> Array.init (Array.length m) (
      fun col -> m.(col).(row)
    )
  );;
;;
let piu m1 m2= 
  Array.init (Array.length m1) (
    fun row -> Array.init (Array.length m1.(row)) (
      fun col -> (m1.(row).(col) + m2.(row).(col))
    )
  );;
;;
let per m1 m2= 
  Array.init (Array.length m1) (
    fun row -> Array.init (Array.length m2.(row)) (
      fun col -> 
        let rec a_row acc= function
          | (h1::tl1), (h2::tl2) -> a_row (acc+(h1*h2)) (tl1, tl2)
          | [], [] -> acc
          | _ -> acc
        in a_row 0  ((Array.to_list m1.(row)), (Array.to_list ((transpose m2).(col))))
    )
  );;
;;
zeroes 2 2;;
identity 4;; 
init 4;;
transpose (init 4);;
transpose [|[|10; 11|]; [|20; 21|]; [|30; 31|]|];;
piu (init 4) (init 4);;
piu [|[|1; 2; 3|];[|1;2;3|]|] [|[|-1; -2; -3|];[|-1;-2;-3|]|];;
per [|[|1; 2; 3|]; [|4; 5; 6|]|] [|[|10; 11|]; [|20; 21|]; [|30; 31|]|]