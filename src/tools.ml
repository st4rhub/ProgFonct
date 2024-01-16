(* Yes, we have to repeat open Graph. *)
open Graph


let clone_nodes gr = n_fold gr (fun graph id -> new_node graph id) empty_graph;;

let gmap gr f =
  (* Replaces an arc a's label by f(a) *)
  let f1 gr a = new_arc gr {src=a.src;tgt=a.tgt;lbl=(f a.lbl)}   in 
  e_fold gr f1 (clone_nodes gr);;

let add_arc gr id1 id2 n = 
  let a = find_arc gr id1 id2 in (*looks for the arc*)
  match a with  (* if it doesn't exist, creates it *)
  |None -> new_arc gr {src=id1; tgt=id2; lbl=n}
  |Some arc -> new_arc gr {src=id1; tgt=id2; lbl=(n+arc.lbl)};; (* if does, adds n to the label *)