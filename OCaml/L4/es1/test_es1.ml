open Graph 
let g = Graph.create();;
let a = Graph.add_node 1 g;;
let r = Graph.ret a;;
let a = Graph.add_node 2 a;;
let r = Graph.ret a;;
let a = Graph.add_arc 1 2 a;;
let r = Graph.ret a;;
let a = Graph.add_node 3 a;;
let a = Graph.add_arc 2 3 a;;
let a = Graph.add_arc 1 3 a;;
let r = Graph.ret a;;
let b = Graph.visit a;;
let stampa = function 
| 
stampa b;;