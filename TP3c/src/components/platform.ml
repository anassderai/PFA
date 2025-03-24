open Component_defs
open System_defs

let platform = ref [||]

let create x y w h  =
  let p = new platform in
  p#pos#set Vector.{ x = float x; y = float y };
  p#rect#set Rect.{width = w; height = h};
  p#texture#set Texture.transparent;
  p#mass#set Float.infinity;
  p#index#set 7;
  Draw_system.register (p :> drawable);
  Collision_system.register (p :> collidable);
  Force_system.register (p :> physics);
  p


let platform_1 () =
  platform := Array.map (fun x y w h -> create x y w h)
    [|
      56; 320;  48; 8;
      64; 272; 40; 8;
      48;372;  52; 8;
      176;400; 44;8;
      172;296; 32;4;
      216; 344;56;8; 
      232; 448;  40; 8;
      176;500;  44;8;
      328; 328; 56; 8;
      480; 308; 56; 8;
      532;252;  68;4;
      636; 200; 52; 8;
      740; 160; 60;8;
    |]



(* (736; 96; Texture.red; 64;64)(*portail*)*)