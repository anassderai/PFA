open Cst
open System_defs

let textures = ref [||]

let room = ref 0



let level_0 t = 
  textures := t;

  Platform.unregister_1 ();

  ignore (Background.create !textures.(0) );

  ignore (Player.create player_x player_y player_width player_height player_texture player_mass);

  ignore(Portal.create 700 (window_height - ground_thickness - 64) 64 64 !textures.(2));
  (* init platform *)
  
  Box.box_1 !textures.(4)

  (*Portal.portal_tst !textures.(2)*)

  (* init walls *)

  (* init portal *)

let level_1 =

  Platform.platform_1 ()
    


let level_2 = ()

let level_3 = () 

let level_4 = ()  

let level_5 = ()

let next_level = 
  room := !room + 1;
  match !room with
    |1 -> level_1
    |2 -> level_2
    |3 -> level_3
    |4 -> level_4
    |5 -> level_5 
    |_ -> failwith "No level found"