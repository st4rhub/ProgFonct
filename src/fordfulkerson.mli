open Graph

(*Takes a string graph and changes the int label into a tuple label with (flow=0, capacity=a.lbl)
   Works *)
val initialize_graph : string graph -> string graph
val min_ecart : int arc list -> int
val add_flow : int graph -> id -> id -> int -> int graph
(*val flow_of_graph : int graph -> id -> int*)
val getNeighbors : int graph -> id -> int arc list
val printNeighbors : id list -> unit
val findAugmentingPath : int graph -> id -> id -> int arc list
val modifyResidual : int graph -> int arc list -> int graph
val fordfulkerson : int graph -> id -> id -> (int*(int graph))


