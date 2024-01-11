open Graph

(*prints list of arcs*)
val printPath : int arc list -> unit

val findAugmentingPath : int graph -> id -> id -> int arc list

val fordfulkerson : int graph -> id -> id -> (int*(int graph))


