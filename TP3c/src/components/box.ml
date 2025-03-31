open Component_defs
open System_defs
open Cst

(* On crée une boîte *)

let boxs = ref [||]


let create x y texture mass =
  let b = new box in
  b#pos#set Vector.{ x = float x; y = float y };
  b#rect#set Rect.{width = 50; height = 50};
  b#texture#set texture;
  b#mass#set mass;
  b#index#set 3;
  Draw_system.register (b :> drawable);
  Collision_system.register (b :> collidable);
  Move_system.register (b :> movable);
  Force_system.register (b :> physics);
  b

  
  let box_1 texture =
    boxs := [|
    create 300 (window_height - ground_thickness - 50 - 50) texture 1.0
  |]