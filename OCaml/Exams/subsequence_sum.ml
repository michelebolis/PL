(*
  "dato una lista di interi, una sequenza è data da numeri consecutivi nella lista 
  e si chiude con uno o più zeri. Restituire una lista con le somme delle sequenze"
  Tipo per [1, 2, 3, 0, 4, 5, 0, 0, 6, 0] deve restituire [6, 9, 6]   
*)
let subsequence_sum a =  
  let rec subsequence_sum_rec acc = function 
    | [] -> (match acc with 
              0 -> [] 
            | n -> [n])
    | h::tl when h=0 -> subsequence_sum_rec acc tl
    | h::next::tl when next=0-> (acc+h)::(subsequence_sum_rec 0 tl)
    | h::tl -> subsequence_sum_rec (acc+h) tl
  in subsequence_sum_rec 0 a;;
let arr_test = [1; 2; 3; 0; 4; 5; 0; 0; 6]
let test = subsequence_sum arr_test ;;