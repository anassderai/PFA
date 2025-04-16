open Cst
open System_defs

let textures = ref [||]

let textures_player = ref [|[||]|]

let room = ref 0

let level_0 t1 t2 = 
  textures := t1;
  textures_player := t2;

  Platform.unregister ();

  ignore (Background.create !textures.(0) );

  ignore (Player.create player_x player_y player_width player_height !textures_player player_mass);

  ignore(Portal.create 700 (window_height - ground_thickness - 64) 64 64 !textures.(3));
  
  Box.box_0 !textures.(5)
  (* init walls *)

  (* init portal *)

let level_1 () =
  Background.set_img !textures.(1);
  Box.unregister ();
  Platform.platform_1 ();
  Portal.unregister ();
  Player.change_room !room


  (*let portal_1 () =  (736; 96; Texture.red; 64;64)(*portail*)*)
    


let level_2 () = ()

let level_3 () = () 

let level_4 () = ()  

let level_5 () = ()

let next_level () = 
  room := !room + 1;
  match !room with
    |1 -> level_1 ()
    |2 -> level_2 ()
    |3 -> level_3 ()
    |4 -> level_4 ()
    |5 -> level_5 ()
    |_ -> failwith "No level found"