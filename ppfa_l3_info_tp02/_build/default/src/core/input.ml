let key_table = Hashtbl.create 16
let has_key s = Hashtbl.mem key_table s
let set_key s= Hashtbl.replace key_table s ()
let unset_key s = Hashtbl.remove key_table s

let action_table = Hashtbl.create 16
let register key action = Hashtbl.replace action_table key action

let saut_pressed = ref false 

let handle_input () =
  let p1 = Player.player1() in 
  let () =
    match Gfx.poll_event () with
     KeyDown " " -> 
      if ((not !saut_pressed) && p1#on_ground#get) then begin
        saut_pressed := true ;
        p1#on_ground#set false;
        Player.(move_player (p1) Cst.player_jump)
      end;
    | KeyUp " " -> saut_pressed := false ;
                  p1#on_ground#set false
    | KeyDown s -> set_key s
    | KeyUp s -> unset_key s
    | Quit -> exit 0
    | _ -> ()
  in
  Hashtbl.iter (fun key action ->
      if has_key key then action ()) action_table

let () =
  (* register "z" (fun () -> Player.(move_player (player1()) Cst.player_up));
  register "s" (fun () -> Player.(move_player (player1()) Cst.player_down)); *)
  register "d" (fun () -> Player.(move_player (player1()) Cst.player_right));
  register "q" (fun () -> Player.(move_player (player1()) Cst.player_left));

