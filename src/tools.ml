(* Yes, we have to repeat open Graph. *)
open Graph


let clone_nodes gr = n_fold gr (fun graph id -> new_node graph id) empty_graph;;

let gmap gr f = (*f prend a rend b*)
  let f1 gr a = new_arc gr {src=a.src;tgt=a.tgt;lbl=(f a.lbl)}   in   (*prend b graphe et a arc et rend b graph*)
  e_fold gr f1 (clone_nodes gr);;

let add_arc gr id1 id2 n = 
  let a = find_arc gr id1 id2 in (*looks for the arc*)
  match a with  (*if it's not there, creates it*)
  |None -> new_arc gr {src=id1; tgt=id2; lbl=n}
  |Some arc -> new_arc gr {src=id1; tgt=id2; lbl=(n+arc.lbl)};; (*if it's there, switches it*)