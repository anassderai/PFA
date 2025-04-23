open Component_defs
open System_defs 
open Cst

(* On crée un portail *)

let portal_instance = ref None

let create x y w h texture =
  let p = new portal in
  p#pos#set Vector.{ x = float x; y = float y };
  p#rect#set Rect.{width = w; height = h};
  p#texture#set texture;
  p#mass#set Float.infinity;
  p#index#set 6;
  Draw_system.register (p :> drawable);
  Collision_system.register (p :> collidable);
  Force_system.register (p :> physics);
  portal_instance := Some p;
  p

let portal () = 
  match !portal_instance with
    | Some p -> p
    | None -> failwith "Portal not initialized"

let unregister () =
  match !portal_instance with
    | Some p -> 
      Draw_system.unregister (p :> drawable);
      Collision_system.unregister (p :> collidable);
      Force_system.unregister (p :> physics);
      portal_instance := None
    | None -> ()