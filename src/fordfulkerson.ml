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


what to do:
fonction qui cherche un chemin (augmentant)
have to do flow of graph, enlever de in arcs

*)




(*have to map to int graph first and thne initialize the other arcs to 0*)
(* Crée le graphe d'écart par dessus le graphe initial avec les arcs instanciés à 0 *)
let initialize_graph gr = e_fold gr (fun g x-> new_arc g {src=x.tgt;tgt=x.src;lbl="0"}) gr
;;





(* On donne la liste des arcs qui vont de gauche à droite /A PATH/ et on renvoie l'écart minimum*)
let min_ecart list_arc = 
  if list_arc == [] then failwith "liste arcs vide" else 								(*si liste arc vide: path vide et alors quoi ?*)
  let acc = (List.hd list_arc).lbl in 
  let rec aux list_arc acc = 
    match list_arc with
      | [] -> acc
      | x::rest -> aux rest (min x.lbl acc) in 
  aux list_arc acc
;;




(* Adds n to an arc's flow - the arc going from id1 to id2, subtracts n from id2 to id1)*)
let add_flow gr id1 id2 n = 
  let graph_aux = add_arc gr id1 id2 (-n) in 
    add_arc graph_aux id2 id1 n 
;;



  
(*calculates the flow coming out of the source, HAVE TO TAKE OUT IN ARCS*)
let flow_of_graph gr src =                 														(*we could test to see if the node actually exists*)
  let list_of_arcs = out_arcs gr src in (*is the list of arcs coming out of the source*)
  let f acc arc = acc + arc.lbl in  
    List.fold_left f 0 list_of_arcs (*starts from 0 and adds the flow of each arc*)
;;







(*recup les neighbors of a node: returns 'a arc list*)
let getNeighbors gr node =
  let f acc arc = [arc]@acc in 
    List.fold_left f [] (out_arcs gr node)
;;

(* Takes an arc a->b and finds the opposite arc b->a with the residual values *)
let getOppositeArc gr arc = 
  let neighb = getNeighbors gr arc.tgt in 
    let opp = List.find (fun x-> x.tgt = arc.src) neighb in
    Printf.printf "opposite arc : (%d, %d, %d) \n" opp.src opp.tgt opp.lbl;
    opp
;;


(*prints list of int*)
let printNeighbors list = 
  List.iter (fun x -> Printf.printf "%d %!" x) list
;;

let rec printPath path =
  Printf.printf "Printing path.....\n%!";
  match path with
  |[] -> ()
  |x::rest -> Printf.printf "(%d, %d)\n%!" x.src x.tgt; printPath rest;
  Printf.printf "End of path....\n%!";;




(* Finds a path from source to sink in the graph if it is possible *)
let findAugmentingPath myGraph sourceid sinkid = 	

	let rec findAugmentingPath2 sourceid2 precedingPath =

	

		(*Condidtion used to filter the list of edges : not already in the path*)
		let cond x =
			(*Creates a list with only the destinations *)
      (* Basically we don't want to go to a place that's already been visited *)
			let b = List.map (fun arc -> arc.tgt) precedingPath in 
			( (not (List.mem x.tgt b)) && (not (x.tgt=sourceid)) && (x.lbl > 0) && ((getOppositeArc myGraph x).lbl>=0)) (*useless double condition , remove the opp arc one*)
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
				let arcsCorrects = List.filter cond (getNeighbors myGraph sourceid2) in	

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




let rec modifyResidual gr path =
  let ecart = min_ecart path in 
    match path with
      | [] -> gr
      | arc::rest -> modifyResidual (add_flow gr arc.src arc.tgt ecart) rest
;;


let fordfulkerson gr sourceid sinkid = 
  
	let rec inner_ford_fulk myGraph source sink out_flow =
		try

      Printf.printf "im in fordfulkerson\n \n \n %!";
			(* As long as we find a path we make one more iteration with the new graph and the augmented flow *)
			let aPath = findAugmentingPath myGraph source sink in	
      printPath aPath;
      Printf.printf "i found the path \n \n \n %!";
			
			let b = List.map (fun arc -> string_of_int arc.tgt) aPath in (*Creates a list with only the label values from the path *)
			let strg = String.concat ", " b in (*Creates a string from the list*)
			print_endline ("Path found : "^(string_of_int source)^", "^strg); (*Displays the string *)
			
			print_endline ("Flow : "^(string_of_int (flow_of_graph myGraph source)));
			
      if aPath <> [] then 
			inner_ford_fulk (modifyResidual myGraph aPath) source sink (out_flow + (flow_of_graph myGraph source))
      else (out_flow, myGraph)
		with
			(* When finding a path is no longer possible we return the final flow *)
			| Not_found -> (out_flow, myGraph)	
	in 
	inner_ford_fulk gr sourceid sinkid 0

;;