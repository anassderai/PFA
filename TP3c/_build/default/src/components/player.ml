open Component_defs
open System_defs

let player_instance = ref None

(* let textures = ref [||]
let set_textures t = textures := t
let get_textures = !textures *)

let create x y w h texture mass = 
  let p = new player in 
  p#pos#set Vector.{x = float x; y = float y };
  p#rect#set Rect.{width = w; height = h};
  p#texture#set texture;
  p#mass#set mass;
  p#sum_forces#set Vector.zero;
  p#on_ground#set true;
  p#room#set 0;
  p#index#set 1;
  p#move#set 0;
  

  Draw_system.register (p :> drawable);
  Collision_system.register (p :> collidable);
  Move_system.register (p :> movable);
  Force_system.register (p :> physics);
  player_instance := Some p;
  p

let move_player player vector =
  let pos = player#pos#get in
  let new_pos = Vector.add pos vector in
  player#pos#set new_pos

let player () =
  match !player_instance with
  | Some p -> p
  | None -> failwith "Player not initialized"

let set_img img = 
  let p = player () in
  p#texture#set img

(* let check_move = 
  let textures = get_textures in
  let p = player () in
  match p#move#get with
  |0 -> set_img textures.(0)
  | 1 -> set_img (Array.sub textures 2 5)
  | 2 -> set_img textures 
  | 3 -> set_img textures
  | _ -> () *)