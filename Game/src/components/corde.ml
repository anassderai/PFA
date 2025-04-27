open Component_defs
open System_defs

let create x y w h texture =
  let c = new corde in
  c#pos#set Vector.{ x = float x; y = float y };
  c#rect#set Rect.{width = w; height = h};
  c#texture#set texture;
  c#mass#set Float.infinity;
  c#index#set 4;
  Draw_system.register (c :> drawable);
  Collision_system.register (c :> collidable);
  Force_system.register (c :> physics);
  c
