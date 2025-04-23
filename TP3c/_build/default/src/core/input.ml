let key_table = Hashtbl.create 16
let has_key s = Hashtbl.mem key_table s
let set_key s = Hashtbl.replace key_table s ()
let unset_key s = Hashtbl.remove key_table s

let action_table = Hashtbl.create 16
let register key action = Hashtbl.replace action_table key action

let saut_pressed = ref false 

let handle_input () =
  let p = Player.player () in 
  let () =
    match Gfx.poll_event () with
    | KeyDown "z" -> set_key "z"; p#move#set 1
    | KeyDown "q" -> set_key "q"; p#move#set 2
    | KeyDown "d" -> set_key "d"; p#move#set 3

    | KeyDown s -> set_key s
    | KeyUp s -> unset_key s; p#move#set 0
    | Quit -> exit 0
    | _ -> ()
  in
  Hashtbl.iter (fun key action ->
      if has_key key then action ()) action_table

let () =
  register "z" (fun () -> Player.(move_player (player ()) Cst.player_up));
  (* register "s" (fun () -> Player.(move_player (player ()) Cst.player_down)); *)
  register "d" (fun () -> Player.(move_player (player ()) Cst.player_right));
  register "q" (fun () -> Player.(move_player (player ()) Cst.player_left));
