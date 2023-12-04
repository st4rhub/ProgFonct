open Graph

(*Takes a string graph and changes the int label into a tuple label with (flow=0, capacity=a.lbl)
   Works *)
val initialize_graph : string graph -> string graph
val min_ecart : int arc list -> int
val add_flow : int graph -> id -> id -> int -> int graph
val getNeighbors : int graph -> id -> id list
val printNeighbors : id list -> unit
(*
(*takes a tuple and turns it into a string
   Works*)
val string_of_tuple : (int * int) -> string


(*converts a tuple graph into string graph
   Works*)
val convert_to_graph : (int * int) graph -> string graph


(*calculates the gap between capacity and flow of an arc
   Works*)
val residual_arc : (int * int) arc -> int


(*calculates the flow coming out of the source
   Works*)
val flow_of_graph : (int * int) graph -> id -> int


(*calcule le min des écarts des arcs
   Works*)
val min_ecart : (int * int) arc list -> int


(*Adds n to an arc's flow - the arc going from id1 to id2, with an error if it doesn't exist
   Works*)
val add_flow : (int * int) graph -> id -> id -> int -> (int * int) graph
*)
