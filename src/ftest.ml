open Gfile
open Tools
open Fordfulkerson


let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
  
  let _g2 = clone_nodes graph in
  
  (*let f x = "."^x^"." in*)
  let f = int_of_string in
  let g3 = gmap graph f in

  let g4 = add_arc g3 2 4 10000 in
  let g4_2 = gmap g4 string_of_int in

(*
  let x = flow_of_graph g5_2 0 in
  Printf.printf "flow of graph: %d \n%!" x;
  *)

  let graph_init_string = initialize_graph g4_2 in (*graphe init en string*)
  let graph_init = gmap graph_init_string int_of_string in 


  
  let g1 = add_flow graph_init 0 3 5 in 
  let g2 = add_flow g1 0 2 2 in
  
  
  Printf.printf "ecart min: %d \n%!" (min_ecart [{ src= 0 ;tgt= 2 ;lbl=15};{ src= 2 ;tgt= 3 ;lbl=8}]);
  
  let g3 = getNeighbors g2 0 in
  let _g4 = printNeighbors g3 in   



  let graph_final = gmap g2 string_of_int in (*graph final en string qu'on renvoie*)
  let () = export (outfile^".dot") graph_final in
  
  (* Rewrite the graph that has been read. *)
  (*let () = write_file outfile g5 in
  *)
  ();


