open Graph
open Tools


(*
define a source and dest, pris en argument, par défaut 0 et 5 DONE

initialize_graph string graph -> tuple graph DONE
  add arcs that go the other way at capacity 0

the loop: (while there is an augmenting path)

finds_augmenting_path tuple graph -> src -> dst -> 'a arc list 
  an algorithm BFS that looks for augmenting path from s to d

min_ecart arc list -> min int DONE 
  calculer l'écart pour chaque edge et prendre le min

ajouter l'ecart a chaque arc du chemin (add_arc)

display final graph
maximal flow value
*)

(*prints list of id*)
let printIdList list = 
  List.iter (fun x -> Printf.printf "%d %!" x) list
;;

(*prints list of arcs*)
let rec printPath path =
  Printf.printf "Printing path.....\n%!";
  match path with
  |[] -> Printf.printf "End of path....\n%!"
  |x::rest -> Printf.printf "(%d, %d)\n%!" x.src x.tgt; printPath rest
;;




(*takes arc list (a path), returns the minimum ecart*)
let min_ecart list_arc = 
		let acc = (List.hd list_arc).lbl in (*normalement on na pas de path vide*)
		let rec min_ecart_rec list_arc acc = 
			match list_arc with
				| [] -> acc
				| x::rest ->  min_ecart_rec rest (min x.lbl acc) 
		in 
		min_ecart_rec list_arc acc
;;




(*adds n to an arc's flow /subtract n to the arc going from id1 to id2, add n from id2 to id1/*)
let add_flow gr id1 id2 n = 
  let graph_aux = add_arc gr id1 id2 (-n) in 
  add_arc graph_aux id2 id1 n 
;;

(*takes graph path minecart and takes minecart out of all arc in path*)
let updateGraph gr path minEcart = 
	let rec updateGraph_rec gr path =
		match path with
			| [] -> gr
			| arc::rest -> updateGraph_rec (add_flow gr arc.src arc.tgt minEcart) rest
	in
	updateGraph_rec gr path
;;



(*returns neighbors of node, only the people coming in and not out: returns id list*)
let getNeighbors gr node =
  let f acc arc = [arc.tgt]@acc in 
  List.fold_left f [] (out_arcs gr node)
;;






(* Finds a path from source to sink in the graph if it is possible *)
let findAugmentingPath myGraph sourceid sinkid = 	

	let rec findAugmentingPath2 sourceid2 precedingPath =

	

		(*Condition used to filter the list of edges : not already in the path*)
		let cond x =
			(*Creates a list with only the destinations *)
      (* Basically we don't want to go to a place that's already been visited *)
			let b = List.map (fun arc -> arc.tgt) precedingPath in 
			( (not (List.mem x.tgt b)) && (not (x.tgt=sourceid)) && (x.lbl > 0)) 
		in

    (*TEST A ENLEVER !!!!!!!!!!!!!!!!!!!!*)
    let precedingPath = [] in
    Printf.printf "on na pas deja vu cet arc (%B) \n%!" (cond {src= 0 ;tgt= 1 ;lbl=7}); 
    

		(*Function to test all arcs that are proven to be correct*)
		let rec tester_tous_les_arcs arclist =
			match arclist with
					(*If the list is empty we cannot find a path*)
					| [] -> raise Not_found 
					(*Else we try to find paths for all correct edges 
					and we stop when we have found a correct path*)
					| arc::rest -> 
						begin
							try
								findAugmentingPath2 arc.tgt (arc::precedingPath)
							with
								| Not_found -> tester_tous_les_arcs rest
						end
		in

		(*If the source is equal to the sink then it's finished*)
		match (sourceid2,sinkid) with
		| (a,b) when a=b -> precedingPath
		| _ -> 
			(*Else we search all correct edges (non null and non already in the path) 
			amongst all those starting from source*)
			begin						
				let arcsCorrects = List.filter cond (out_arcs myGraph sourceid2) in	

        Printf.printf "im in augmenting path\n \n \n %!";
        (*Printf.printf "first of arcscorrects : (%d, %d)\n" (List.hd arcsCorrects).src (List.hd arcsCorrects).tgt;*)
        printPath arcsCorrects;
  				(*And we try to find a complete path with all of them*)
				tester_tous_les_arcs arcsCorrects		
			end
	in

  
	
	

	(*Call of the intern function with a null accumulator*)
	let finalpath = findAugmentingPath2 sourceid [] in 
	(*The list in the accumulator has ro be reversed before being returned*)
	  List.rev finalpath 
;;




let findAugmentingPath_other myGraph sourceid sinkid = 	

	let rec findAugmentingPath_rec sourceid2 precedingPath =

	
		(*Condition used to filter the list of destinations : we don't want to go to a place that we have already visited*)
		let cond x =
			let b = List.map (fun arc -> arc.tgt) precedingPath in 
			((not (List.mem x.tgt b)) && (not (x.tgt=sourceid)) && (x.lbl > 0)) 
		in

		(*Function to test all arcs that are proven to be correct*)
		let rec tester_tous_les_arcs arclist =
			match arclist with
					(*If the list is empty we cannot find a path*)
					| [] -> raise Not_found 
					(*Else we try to find paths for all correct edges 
					and we stop when we have found a correct path*)
					| arc::rest -> 
						begin
							try
								findAugmentingPath_rec arc.tgt (arc::precedingPath)
							with
								| Not_found -> tester_tous_les_arcs rest
						end
		in

		(*If the source is equal to the sink then it's finished*)
		match (sourceid2,sinkid) with
		| (a,b) when a=b -> precedingPath
		| _ -> 
			(*Else we search all correct edges (non null and non already in the path) 
			amongst all those starting from source*)
			begin						
				let arcsCorrects = List.filter cond (out_arcs myGraph sourceid2) in	

				Printf.printf "im in augmenting path\n \n \n %!";
				(*Printf.printf "first of arcscorrects : (%d, %d)\n" (List.hd arcsCorrects).src (List.hd arcsCorrects).tgt;*)
				printPath arcsCorrects;
					(*And we try to find a complete path with all of them*)
				tester_tous_les_arcs arcsCorrects		
			end
	in

	
	

let finalpath_reversed = findAugmentingPath_rec sourceid [] in 
List.rev finalpath_reversed 
;;





let fordfulkerson originalGraph sourceid sinkid = 
	let rec inner_ford_fulk gr source sink out_flow =
		try
			(* As long as we find a path we make one more iteration with the new graph and the augmented flow *)
			let aPath = findAugmentingPath gr source sink in	
			let minEcart = min_ecart aPath in
			let updatedGraph = updateGraph gr aPath minEcart in

			(*on fait un cas pour path =[] ?? *)
			inner_ford_fulk updatedGraph source sink (out_flow + minEcart)
		with
			(* When finding a path is no longer possible we return the final flow *)
			| Not_found -> (out_flow, gr)	
	in 
	inner_ford_fulk originalGraph sourceid sinkid 0
;;

(*  let f1 gr a = new_arc gr {src=a.src;tgt=a.tgt;lbl=(f a.lbl)}   in   (*prend b graphe et a arc et rend b graph*) *)

let flowgraph_from_ecart gr_init gr_ecart =
	let final_graph = empty_graph in 
	let f graph a = new_arc graph {src=a.src;tgt=a.tgt;lbl=(Option.get (find_arc gr_ecart a.tgt a.src)).lbl} 
in e_fold gr_init f final_graph;;