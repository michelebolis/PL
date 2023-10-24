(*
A social network is a social structure made of individuals (or organizations) called nodes, 
which are tied (connected) by one or more specific types of interdependency, 
such as friendship, kinship, financial exchange, dislike, sexual relationships, or relationships of beliefs, knowledge or prestige.

A graph is an abstract representation of a set of objects where some pairs of the objects are connected by links. 
The interconnected objects are represented by mathematical abstractions called vertices, 
and the links that connect some pairs of vertices are called edges.

The exercise consists of:
- implementing the social network as a graph, i.e., to define the graph data structure 
with the operations you consider necessary to implement a social network
- implementing an operation that visits in a convenient way all the elements of the graph
testing it against a dummy social network.
*)

module type GraphADT =
  sig 
    type 'a graph
    val create : unit -> 'a graph 
    val add_node : 'a -> 'a graph -> 'a graph 
    val add_arc : 'a -> 'a -> 'a graph -> 'a graph
    val ret : 'a graph -> ('a list * ('a * 'a) list)
    val visit : 'a graph -> ('a * ('a list)) list
  end;;

module Graph : GraphADT =
  struct 
    exception NodesNotFound
    type 'a graph = Graph of ('a list * ('a * 'a) list)
    let create ()= 
      Graph ([], [])
    ;;
    let prepend_to_list n = function 
    | [] -> [n]
    | h::tl -> n::(h::tl)
    ;;
    let add_node n = function 
    | Graph([], arcs) -> Graph([n], arcs)
    | Graph (nodes, arcs) -> Graph((List.rev (prepend_to_list n nodes)), arcs)
    ;;
    let exists_in_graph n = function 
      Graph (nodes, arcs) -> List.exists n nodes
    ;;
    let add_arc n1 n2 = function 
      Graph (nodes, arcs) -> 
        match ((List.exists (fun x -> x=n1) nodes), (List.exists (fun x -> x=n2) nodes)) with
        | (true, true) -> Graph (nodes, [(n1, n2)] @ arcs)
        | _ -> raise NodesNotFound
    ;;
    let ret = function Graph(nodes, arcs) -> (nodes, arcs);;
    let rec adjacts_to n l = function 
    | [] -> l
    | h::tl -> 
      match h with
      | (from, destination) -> 
        if from==n then adjacts_to n (destination::l) tl
        else adjacts_to n l tl
    ;;
    let visit = function 
    | Graph([], _) -> []
    | Graph(nodes, arcs) ->
      let rec dfs_rec l =  
        function 
        | h::tl -> (dfs_rec ((h, (adjacts_to h [] arcs))::l) tl)
        | [] -> l
      in dfs_rec [] nodes
  end;;