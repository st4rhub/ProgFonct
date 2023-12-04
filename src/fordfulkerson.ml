open Graph
open Tools


(*
define a source and dest, pris en argument, par défaut 0 et 5

initialize_graph string graph -> tuple graph DONE
  changer le label en tuple avec how full it is right now and the max capacity
  set all edges' capacity à 0

the loop: (while there is an augmenting path)

finds_augmenting_path tuple graph -> src -> dst -> 'a arc list 
  an algorithm BFS that looks for augmenting path from s to d

min_ecart arc list -> min int DONE 
  calculer l'écart pour chaque edge et prendre le min

ajouter l'ecart a chaque arc du chemin (add_arc)

display final graph
maximal flow value ?


what to do:
fonction qui cherche un chemin (augmentant)
have to do flow of graph, enlever de in arcs

*)


(*Takes a string graph and changes the int label into a tuple label with (flow=0, capacity=a.lbl) *)
let initialize_graph gr = e_fold gr (fun g x-> new_arc g {src=x.tgt;tgt=x.src;lbl="0"}) gr;;


(*on donne la liste des arcs qui vont de gauche à droite /A PATH/ et on renvoie l'écart minimum*)
let min_ecart list_arc = 
  let acc = (List.hd list_arc).lbl in 
  let rec aux list_arc acc = 
    match list_arc with
      | [] -> acc
      | x::rest -> aux rest (min x.lbl acc) in 
  aux list_arc acc;;

(* Adds n to an arc's flow - the arc going from id1 to id2, subtracts n from id2 to id1)*)
let add_flow gr id1 id2 n = 
  let graph_aux = add_arc gr id1 id2 (-n) in 
  add_arc graph_aux id2 id1 n ;;

(*calculates the flow coming out of the source, HAVE TO TAKE OUT IN ARCS*)
let flow_of_graph gr src =  (*we could test to see if the node actually exists*)
  let list_of_arcs = out_arcs gr src in (*is the list of arcs coming out of the source*)
  let f acc arc = acc + arc.lbl in  
  List.fold_left f 0 list_of_arcs (*starts from 0 and adds the flow of each arc*)
;;







(*
let finds_augmenting_path gr src dst = ()
;;*)

(*recup les neighbors of a node: returns id list*)
let getNeighbors gr node =
  let f acc arc = [arc.tgt]@acc in 
  List.fold_left f [] (out_arcs gr node) 
;;

(*prints list of int*)
let printNeighbors list = 
  List.iter (fun x -> Printf.printf "%d %!" x) list
;;



(*
let rec finds_augmenting_path g alreadyvisited tovisit fAdd fDo =
  match tovisit with 
    [] -> ()
    |sommetCourant::reste ->  
           if (isinListe alreadyvisited sommetCourant) then 
            finds_augmenting_path g alreadyvisited reste fAdd fTraitement                 
           else
            begin
             fTraitement sommetCourant;

             let voisins = getNeighbors g sommetCourant 
             in

             let resteavisiter = fAdd reste voisins 
             in

             let cequiaetevisite = sommetCourant::alreadyvisited 
             in

             finds_augmenting_path g cequiaetevisite resteavisiter fAdd fDo
            end
  ;;
  *)