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


  (* Functions to convert String graph into our graph type and back *)
  let string_to_our_type = int_of_string in
  let our_type_to_string = string_of_int in

  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and source = string_to_our_type Sys.argv.(2)
  and sink = string_to_our_type Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
    
  (*Convert string graph to int graph*)
  let graph_init = gmap graph string_to_our_type in

  (*Apply FordFulkerson to graph*)
  let resultTuple = fordfulkerson graph_init source sink in

  (*Print flow*)
  Printf.printf "\n \n Final Flow : %d \n \n %!" (fst resultTuple); 

  (*Convert ecart graph into flow graph*)
  let graphFlow = flowgraph_from_ecart graph_init (snd resultTuple) in

  (*Convert final int graph to string graph*)
  let graph_final = gmap graphFlow our_type_to_string in
  
  (*Write graph final in outfile and export it into .dot to see the graph*)
  let () = write_file outfile graph_final; export (outfile^".dot") graph_final; in

  ();


