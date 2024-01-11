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
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
    
  (*Convert string graph to int graph*)
  let graph_init = gmap graph int_of_string in

  (*Apply FordFulkerson to graph*)
  let result = fordfulkerson graph_init source sink in

  (*Print flow*)
  Printf.printf "Final Flow : %d" (fst result); 

  (*Convert final int graph to string graph*)
  let graph_final = gmap (snd result) string_of_int in
  
  (*Write graph final in outfile and export it into .dot to see the graph*)
  let () = write_file outfile graph_final; export (outfile^".dot") graph_final; in

  ();


