open Graph

(*prints list of id*)
val printIdList : id list -> unit

(*prints list of arcs*)
val printPath : int arc list -> unit




(*takes arc list (a path), returns the minimum ecart*)
val min_ecart : int arc list -> int

(*takes graph node1 node2 n, adds n to the flow from id1 to id2*)
val add_flow : int graph -> id -> id -> int -> int graph

(*takes graph path minecart and takes minecart out of all arc in path*)
val updateGraph : int graph -> int arc list -> int -> int graph

(*kinda meh have to fix*)
val getNeighbors : int graph -> id -> id list




val findAugmentingPath : int graph -> id -> id -> int arc list
val fordfulkerson : int graph -> id -> id -> (int*(int graph))


