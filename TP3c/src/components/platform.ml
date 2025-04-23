open Component_defs
open System_defs

let platform = ref [||]

let create x y w h  =
  let p = new platform in
  p#pos#set Vector.{ x = float x; y = float y };
  p#rect#set Rect.{width = w; height = h};
  p#texture#set Texture.black;
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
      create 64 272 40 8;
      create 48 372 52 8;
      create 216 300 52 6; 
      create 232 412 40 8;
      create 176 500 44 8;
      create 328 328 56 8;
      create 480 308 56 8;
      create 532 252 68 4;
      create 636 200 52 8;
      create 740 160 60 8;
      create 280 292 46 60;
    |]

    let platform_2 () =
      Gfx.debug "Platform 1\n %!";
      platform := 
        [|
          create 708 72 40 4;
          create 24 100 116 4;
          create 408 136 92 4;
          create 184 184 64 4;
          create 516 220 120 4;
          create 300 224 76 4;
          create 688 292 80 4;
          create 128 336 56 4;
          create 508 368 100 4;
          create 300 392 88 4;
          create 28 420 92 4;
          create 176 512 104 4;
        |]
    


let unregister () = 
  Array.iter (fun p -> 
    Draw_system.unregister (p :> drawable);
    Collision_system.unregister (p :> collidable);
    Force_system.unregister (p :> physics);
  ) !platform;
  platform := [||]
