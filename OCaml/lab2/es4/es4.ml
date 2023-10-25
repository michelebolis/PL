(*
goldbach(n) that returns a Goldbach partition for n
goldbach_list(n,m) that returns a list of Goldbach partitions for the even numbers in the range (n,m)   
*)

let is_prime n = 
  let rec is_prime_rec = function 
  | 1 -> true
  | k when n mod k=0-> false 
  | k -> is_prime_rec (k-1) 
in is_prime_rec (n-1);;

let goldbach = function 
  | n when (n mod 2)=1 -> (0, 0)
  | n -> 
  let rec goldbach_rec x1 x2=  
      if (is_prime x1) && (is_prime x2) && ((x1+x2)=n) then (x1, x2) 
      else goldbach_rec (x1-1) (x2+1)
  in goldbach_rec ((n/2)) ((n/2))

let goldbach_list n m =  
  let rec goldbach_list_rec res = function 
    | k when k=m+1 -> res 
    | k when (k mod 2)=0-> goldbach_list_rec ((goldbach k)::res) (k+1)
    | k -> goldbach_list_rec (res) (k+1)
  in List.rev (goldbach_list_rec [] n);;