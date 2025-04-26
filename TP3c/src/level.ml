open Cst
open System_defs

let textures = ref [||]

let textures_player = ref [|[||]|]

let room = ref 0

let level_0 t1 t2 = (* Desert *)
  textures := t1;
  textures_player := t2;

  Platform.unregister ();

  ignore (Background.create !textures.(0) );

  ignore (Player.create player_x player_y player_width player_height !textures_player player_mass);

  ignore(Portal.create 700 (window_height - ground_thickness - 64) 64 64 !textures.(5));
  
  Box.box_0 !textures.(7)
  (* init walls *)

  (* init portal *)

let level_1 () = (* Deep Forest *)
  Background.set_img !textures.(1);
  Box.unregister ();
  Portal.unregister ();

  Platform.platform_1 ();
  ignore (Portal.create 736 96 64 64 !textures.(5));
  Player.change_room !room



let level_2 () = (* Moon *)
  Background.set_img !textures.(2);
  Platform.unregister ();
  Portal.unregister ();

  Platform.platform_3 ();
  ignore (Portal.create 100 260 64 64 !textures.(5));
  Player.change_room !room

let level_3 () = (* Landscape *)
  Background.set_img !textures.(3);
  Portal.unregister ();
  Platform.unregister ();

  Platform.platform_2 ();
  ignore (Portal.create 24 36 64 64 !textures.(5));
  Player.change_room !room

let level_4 () = (* Fireworks *)  
  Background.set_img !textures.(4);
  Portal.unregister ();
  Platform.unregister ();

  Platform.platform_4 ();
  Player.change_room !room


let next_level () = 
  room := !room + 1;
  match !room with
    |1 -> level_1 ()
    |2 -> level_2 ()
    |3 -> level_3 ()
    |4 -> level_4 ()
    |_ -> failwith "No level found"