open Component_defs
open System_defs

let platform = ref [||]

let create x y w h  =
  let p = new platform in
  p#pos#set Vector.{ x = float x; y = float y };
  p#rect#set Rect.{width = w; height = h};
  p#texture#set Texture.blue;
  p#mass#set Float.infinity;
  p#index#set 7;
  Draw_system.register (p :> drawable);
  Collision_system.register (p :> collidable);
  Force_system.register (p :> physics);
  p


let platform_1 () =
  Gfx.debug "Platform 1\n %!";
  platform := 
    [|
      create 56 320 48 8;
      create 64 272 40 8;
      create 48 372 52 8;
      create 176 400 44 8;
      create 172 296 32 4;
      create 216 344 56 8; 
      create 232 448 40 8;
      create 176 500 44 8;
      create 328 328 56 8;
      create 480 308 56 8;
      create 532 252 68 4;
      create 636 200 52 8;
      create 740 160 60 8;
    |]

let unregister_1 () = 
  Array.iter (fun p -> 
    Draw_system.unregister (p :> drawable);
    Collision_system.unregister (p :> collidable);
    Force_system.unregister (p :> physics);
  ) !platform;
  platform := [||]
