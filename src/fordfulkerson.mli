open Graph

(*Takes a string graph and changes the int label into a tuple label with (flow=0, capacity=a.lbl)
   Works *)
val initialize_graph : string graph -> string graph

(*Takes arc list (a path), renvoie lecart minimum*)
val min_ecart : int arc list -> int

(*Takes graph node1 node2 n, adds n to the flow from id1 to id2*)
val add_flow : int graph -> id -> id -> int -> int graph

(*get rid of that*)
(*val flow_of_graph : int graph -> id -> int*)
val getNeighbors : int graph -> id -> id list

val printNeighbors : id list -> unit
val findAugmentingPath : int graph -> id -> id -> int arc list
val modifyResidual : int graph -> int arc list -> int graph
val fordfulkerson : int graph -> id -> id -> (int*(int graph))


