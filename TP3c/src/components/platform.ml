open Component_defs
open System_defs

let platform = ref [||]

let create x y w h texture =
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


let platform_1 () =
  platform := Array.map create
    Cst.[
      (56, 320, Texture.yellow, 48, 8);
      (64, 272,Texture.yellow, 40, 8);
      (48,372, Texture.yellow, 52, 8);
      (176,400, Texture.yellow, 44,8);
      (172,296, Texture.yellow, 32,4);
      (216, 344, Texture.yellow,56,8); 
      (232, 448, Texture.yellow, 40, 8);
      (176,500, Texture.yellow, 44,8);
      (328, 328, Texture.yellow, 56, 8);
      (480, 308, Texture.red, 56, 8);
      (532,252, Texture.yellow, 68,4);
      (636, 200, Texture.yellow, 52, 8);
      (740, 160, Texture.yellow, 60,8);
    ]



(* (736, 96, Texture.red, 64,64)(*portail*)*)