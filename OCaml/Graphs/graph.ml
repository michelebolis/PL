type 'a tree = Leaf of 'a | Tree of ('a * 'a tree list);;

module type GraphADT =
  sig
    type 'a graph
    val empty : unit -> 'a graph
    val add_node : 'a -> 'a graph -> 'a graph
    val add_arc : 'a -> 'a -> 'a graph -> 'a graph
    val adjacents : 'a -> 'a graph -> 'a list
    val node_is_in_graph : 'a -> 'a graph -> bool
    val is_empty : 'a graph -> bool
    exception TheGraphIsEmpty
    exception TheNodeIsNotInGraph
  end
;;
module Graph : GraphADT =
struct
  type 'a graph = Graph of ( 'a list ) * ( ( 'a * 'a ) list )
  let empty() = Graph([], [])
  let is_empty = function
    Graph(nodes, _) -> (nodes = [])
    exception TheGraphIsEmpty
    exception TheNodeIsNotInGraph
   
  (* checks if an element belongs to the list *)
  let rec is_in_list ?(res=false) x = function
    [] -> res
    | h::tl -> is_in_list ~res: (res || (x=h)) x tl
  
  (* checks if a node is in the graph *)
  let node_is_in_graph n = function
    Graph(nodes, _) -> is_in_list n nodes

  let rec add_in_list ?(res=[]) x = function
    [] -> List.rev x::res
    | h::tl when (h=x) -> List.rev_append tl (h::res)
    | h::tl -> add_in_list ~res: (h::res) x tl
  
  (* operations to add new nodes and arcs (with their nodes) to the graph, respectively *)
  let add_node n = function
    Graph( [], [] ) -> Graph( [n], [] )
    | Graph( nodes, arcs ) -> Graph( (add_in_list n nodes), arcs )

  let add_arc s d = function
    Graph(nodes, arcs) ->
      Graph( (add_in_list d (add_in_list s nodes)) , (add_in_list (s,d) arcs) )
  
  (* returns the nodes adjacent to the given node *)
  let adjacents n =
    let adjacents n l = List.map snd (List.filter (fun x -> ((fst x) = n)) l)
      in function Graph(_, arcs) -> adjacents n arcs
end