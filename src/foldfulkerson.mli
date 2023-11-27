open Graph


(*Takes a string graph and changes the int label into a tuple label with (flow=0, capacity=a.lbl) *)
val initialize_graph : string graph -> (int * int) graph


(*takes a tuple and turns it into a string*)
val string_of_tuple : (int * int) -> string


(*converts a tuple graph into string graph*)
val convert_to_graph : (int * int) graph -> string graph


(*calculates the gap between capacity and flow of an arc*)
val residual_arc : (int * int) arc -> int


(*calculates the flow coming out of the source*)
val flow_of_graph : (int * int) graph -> int

(*calcule le min des écarts des arcs*)
val min_ecart :  (int * int) arc list -> int -> int

