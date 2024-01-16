open Graph
open Tools

(*prints list of arcs*)
let rec _printPath path =
  Printf.printf "Printing path.....\n%!";
  match path with
  |[] -> Printf.printf "End of path....\n%!"
  |x::rest -> Printf.printf "(%d, %d)\n%!" x.src x.tgt; _printPath rest
;;


(*takes arc list, returns the min ecart*)
let min_ecart list_arc = 
		let acc = (List.hd list_arc).lbl in
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

(*takes graph path min ecart and takes min ecart out of all arc in path, returns updated graph*)
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


(* Finds an augmenting path, given a graph, a source node and a sink node *)
let findAugmentingPath myGraph sourceid sinkid = 	

	let rec findAugmentingPath_rec sourceid2 precedingPath =

		(*Function to test all arcs that are proven to be correct*)
		let rec tester_tous_les_arcs arclist =
			match arclist with
					(*If the list is empty we cannot find a path*)
					| [] -> raise Not_found   					
					(*Else we try to find a path for the first arc of the list*)
					| arc::rest -> 
						begin
							try
								findAugmentingPath_rec arc.tgt (arc::precedingPath)
								(* And if we can't find one, we try to find paths for the arcs in the remaining list *)
							with
								| Not_found -> tester_tous_les_arcs rest
						end
		in
		
		match (sourceid2,sinkid) with
		| (a,b) when a=b -> precedingPath   (*If source = sink, we found an augmenting path and we return it*)
		| _ -> 
			(*Else we search all correct edges (non null and not already in the path) amongst all those starting from source*)
			begin						
				let arcsCorrects = List.filter (isCorrectArc sourceid2 precedingPath) (out_arcs myGraph sourceid2) in	
				tester_tous_les_arcs arcsCorrects		
			end
	in


let finalpath_reversed = findAugmentingPath_rec sourceid [] in 
List.rev finalpath_reversed 
;;


(* Implements the Ford Fulkerson algorithm *)
let fordfulkerson originalGraph sourceid sinkid = 
	let rec inner_ford_fulk gr source sink out_flow =
		try
			(* As long as we find a path we make one more iteration with the new graph and the augmented flow *)
			let aPath = findAugmentingPath gr source sink in	
			let minEcart = min_ecart aPath in
			let updatedGraph = updateGraph gr aPath minEcart in

			inner_ford_fulk updatedGraph source sink (out_flow + minEcart)
		with
			(* When finding a path is no longer possible we return the final flow *)
			| Not_found -> (out_flow, gr)	
	in 
	inner_ford_fulk originalGraph sourceid sinkid 0
;;

(* Transforms a deviation graph into a regular flow graph *)
let flowgraph_from_ecart gr_init gr_ecart =
	let f graph a = 
		(* Find the corresponding arc in gr_ecart, given the arc a in a graph *)
		let ecart_value = (Option.get (find_arc gr_ecart a.src a.tgt)).lbl in
		(* If the value is greater than the capacity *)
		if a.lbl < ecart_value then 
			(* The flow becomes zero *)
			add_arc graph a.src a.tgt (-a.lbl) 
		else
			(* Else, we substract the flow from the original capacity *)
			add_arc graph a.src a.tgt (-ecart_value)
		in
	e_fold gr_init f gr_init
;;