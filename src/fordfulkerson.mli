open Graph

val findAugmentingPath : int graph -> id -> id -> int arc list

val fordfulkerson : int graph -> id -> id -> (int*(int graph))

val flowgraph_from_ecart : int graph -> int graph -> int graph
