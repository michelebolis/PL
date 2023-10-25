open Graphs
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