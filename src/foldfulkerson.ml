open Graph



(*
define a source and dest, pris en argument, par défaut 0 et 5

initialize_graph string graph -> tuple graph
  changer le label en tuple avec how full it is right now and the max capacity
  set all edges' capacity à 0

the loop: (while there is an augmenting path)

finds_augmenting_path tuple graph -> src -> dst -> 'a arc list 
  an algorithm BFS that looks for augmenting path from s to d
min_ecart arc list -> min int
  calculer l'écart pour chaque edge et prendre le min
ajouter l'ecart a chaque arc du chemin (add_arc)

display final graph
maximal flow value ?


what to do:
string_of_tuple  DONE 
fonction qui set à 0  DONE
fonction qui cherche un chemin
fonction qui calcule le flow courant d'un graphe DONE
fonction calcule ecart d'un arc  DONE
*)

(*Takes a string graph and changes the int label into a tuple label with (flow=0, capacity=a.lbl) *)
let initialize_graph gr = gmap gr (fun x -> (0,int_of_string x));;

(*takes a tuple and turns it into a string*)
let  string_of_tuple (a,b) = (string_of_int a)^"/"^(string_of_int b);;

(*converts a tuple graph into string graph*)
let convert_to_graph gr = gmap gr string_of_tuple;;

(*calculates the gap between capacity and flow of an arc*)
let residual_arc a = (snd a.lbl) - (fst a.lbl) ;;

(*calculates the flow coming out of the source*)
let flow_of_graph gr src =  (*we could test to see if the node actually exists*)
  let list_of_arcs = out_arcs gr src in (*is the list of arcs coming out of the source*)
  let f acc arc = acc + fst (arc.lbl) in  
  List.fold_left f 0 list_of_arcs (*starts from 0 and adds the flow of each arc*)
;;

let rec min_ecart list_of_tuple acc = 
  match list_of_tuple with
    | [] -> acc
    | x::rest -> min_ecart rest (min x acc);;



