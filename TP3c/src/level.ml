open Cst

let textures = ref [||]

let level_0 t = 
  textures := t;
  ignore (Background.create !textures.(0) );

  ignore (Player.create player_x player_y player_width player_height player_texture player_mass)

  (* init platform *)

  (* init portal *)

let level_1 = () 

let level_2 = ()

let level_3 = () 

let level_4 = ()  

let level_5 = ()

let next_level = 
  let p = Player.player () in
  p#room#set (p#room#get + 1);
  match p#room#get with
    |1 -> level_1
    |2 -> level_2
    |3 -> level_3
    |4 -> level_4
    |5 -> level_5 
    |_ -> failwith "No level found"