
module type GraphADT =
  sig 
    type 'a graph
    val create : unit -> 'a graph 
    val add_node : 'a -> 'a graph -> 'a graph 
    val add_arc : 'a -> 'a -> 'a graph -> 'a graph
    val ret : 'a graph -> ('a list * ('a * 'a) list)
    val visit : 'a graph -> ('a * ('a list)) list
end;;