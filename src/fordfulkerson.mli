open Graph

(*Takes a string graph and changes the int label into a tuple label with (flow=0, capacity=a.lbl)
   Works *)
val initialize_graph : string graph -> string graph
val min_ecart : int arc list -> int
val add_flow : int graph -> id -> id -> int -> int graph
val getNeighbors : int graph -> id -> id list
val printNeighbors : id list -> unit
