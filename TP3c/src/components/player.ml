open Component_defs
open System_defs
open Cst


let player_instance = ref None

let player_textures = ref [|[||]|]

let in_move = ref 0

let create x y w h texture mass = 
  let p = new player in 
  p#pos#set Vector.{x = x; y = y };
  p#rect#set Rect.{width = w; height = h};
  p#mass#set mass;
  p#sum_forces#set Vector.zero;
  p#on_ground#set true;
  p#index#set 1;
  p#move#set 0;
  
  player_textures := texture;
  p#texture#set (Texture.Animation texture.(0));

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

let change_room n = 
  let p = player () in
  (* p#pos#set Vector.{x = 700.0; y = player_y}; *)
  p#sum_forces#set Vector.zero;
  p#on_ground#set true;
  p#move#set 0;
  p#velocity#set Vector.zero;
  (* p#texture#set !player_textures.(n) *)
  


(* let check_move = 
  let textures = get_textures in
  let p = player () in
  match p#move#get with
  |0 -> set_img textures.(0)
  | 1 -> set_img (Array.sub textures 2 5)
  | 2 -> set_img textures 
  | 3 -> set_img textures
  | _ -> () *)