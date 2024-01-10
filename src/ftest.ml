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
    
  let graph_init = gmap graph int_of_string in (*convert to int*)

 
  
  (*
  let g1 = add_flow graph_init 0 2 5 in 
  let g2 = add_flow g1 0 2 5 in
  *)
  
  (*
  let g1 = modifyResidual graph_init [{ src= 0 ;tgt= 2 ;lbl=4};{ src= 2 ;tgt= 3 ;lbl=5}] in 
  Printf.printf "ecart min: %d \n%!" (min_ecart [{ src= 0 ;tgt= 2 ;lbl=2};{ src= 2 ;tgt= 3 ;lbl=8};{ src= 4 ;tgt= 3 ;lbl=3}]);
  *)

  (*
  let neighbors = getNeighbors graph_init 4 in
  printNeighbors neighbors;
  *)

  (*let g2 = fordfulkerson graph_init source sink in
  Printf.printf "final flow lets go : %d" (fst g2); (*prints flow*)
  let graph_final = gmap (snd g2) string_of_int in (*graph final en string*)
  *)
  

  let graph_final = gmap graph_init string_of_int in

  let () = export (outfile^".dot") graph_final; write_file outfile graph_final in
  (* Rewrite the graph that has been read. *)
  (*let () = write_file outfile g5 in
  *)
  ();


