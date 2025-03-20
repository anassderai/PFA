open Component_defs
open System_defs

let create x y w h texture mass =
  let b = new box in
  b#pos#set Vector.{ x = float x; y = float y };
  b#rect#set Rect.{width = w; height = h};
  b#texture#set texture;
  b#mass#set mass;
  b#index#set 3;
  Draw_system.register (b :> drawable);
  Collision_system.register (b :> collidable);
  Move_system.register (b :> movable);
  Force_system.register (b :> physics);
  b
