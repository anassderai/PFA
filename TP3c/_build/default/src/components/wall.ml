open Component_defs
open System_defs

let create x y w h texture =
  let wall = new wall in
  wall#pos#set Vector.{x = float x; y = float y};
  wall#rect#set Rect.{width = w; height = h };
  wall#texture#set texture;
  wall#mass#set Float.infinity;
  wall#sum_forces#set Vector.zero;
  wall#index_draw#set 2;

  Draw_system.register (wall :> drawable);
  Collision_system.register (wall :> collidable);
  Force_system.register (wall :> physics);
  wall
