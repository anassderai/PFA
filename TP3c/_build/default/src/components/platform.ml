open Component_defs
open System_defs

let create x y w h texture mass =
  let p = new platform in
  p#pos#set Vector.{ x = float x; y = float y };
  p#rect#set Rect.{width = w; height = h};
  p#texture#set texture;
  p#mass#set Float.infinity;
  p#index#set 7;
  Draw_system.register (p :> drawable);
  Collision_system.register (p :> collidable);
  Force_system.register (p :> physics);
  p
