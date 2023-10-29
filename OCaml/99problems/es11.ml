type 'a rle =
    | One of 'a
    | Many of int * 'a;;
let encode = function 
  | [] -> []
  | h::tl -> 
    let create_rle x = function
      | 1 -> One x
      | k -> Many (k, x) 
    in 
      let rec encode count acc = function
        | [] -> []
        | [x] -> (create_rle x (count + 1)) :: acc
        | h :: (next :: _ as tl) ->
            if h = next then encode (count + 1) acc tl
            else encode 0 ((create_rle h (count + 1)) :: acc) tl 
      in
      List.rev (encode 0 [] (h::tl));;
encode ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e"];;