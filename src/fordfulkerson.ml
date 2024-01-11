open Graph
open Tools

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

(*takes the path we went through and an arc we're testing, returns true if we can go there*)
let isCorrectArc sourceid precedingPath arc = 
		let b = [sourceid]@List.map (fun x -> x.tgt) precedingPath in (*list of nodes we go through*)
		((not (List.mem arc.tgt b)) && (arc.lbl > 0)) 
;;


let findAugmentingPath_other myGraph sourceid sinkid = 	

	let rec findAugmentingPath_rec sourceid2 precedingPath =

		(*Function to test all arcs that are proven to be correct*)
		let rec tester_tous_les_arcs arclist =
			match arclist with
					| [] -> raise Not_found   					(*If the list is empty we cannot find a path*)
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

		
		match (sourceid2,sinkid) with
		| (a,b) when a=b -> precedingPath   (*If source=sink, we found path and we return it*)
		| _ -> 
			(*Else we search all correct edges (non null and non already in the path) 
			amongst all those starting from source*)
			begin						
				let arcsCorrects = List.filter (isCorrectArc sourceid2 precedingPath) (out_arcs myGraph sourceid2) in	
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
			let aPath = findAugmentingPath_other gr source sink in	
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