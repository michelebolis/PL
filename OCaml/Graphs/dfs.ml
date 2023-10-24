open Graph
(* transforms a list of arcs in a graph *)
let arcs_to_graph arcs =
  let rec arcs_to_graph g = function
    [] -> g
    | (s,d)::tl -> arcs_to_graph (add_arc s d g) tl
  in arcs_to_graph (empty()) arcs
(* extract a tree out of acyclic graph with the given node as the root *)
let graph_to_tree g root =
  let rec make_tree n = function
    [] -> Leaf(n)
    | adj_to_n -> Tree(n, (make_forest adj_to_n))
  and make_forest = function
    [] -> []
    | hd::tl -> (make_tree hd (adjacents hd g))::(make_forest tl)
  in make_tree root (adjacents root g)

let dfs g v =
  let rec dfs g v g' = function
    [] -> g'
  | hd::tl when (node_is_in_graph hd g') -> dfs g v g' tl
  | hd::tl -> dfs g v (add_arc v hd (dfs g hd (add_node hd g') (adjacents hd g))) tl
  in
    if (is_empty g) then raise TheGraphIsEmpty
    else if not (node_is_in_graph v g) then raise TheNodeIsNotInGraph
      else graph_to_tree (dfs g v (add_node v (empty())) (adjacents v g)) v