open Component_defs
open System_defs
open Cst

let background = ref None

let create img = 
  let bg = new background in 
  bg#pos#set Vector.{x = 0.0; y = 0.0 };
  bg#rect#set Rect.{width = window_width; height = window_height};
  bg#texture#set img;
  bg#index#set 0;

  Draw_system.register (bg :> drawable);
  background := Some bg;
  bg

let background = 
  match !background with
  | Some b -> b
  | None -> failwith "Background not initialized"

let set img = 
  let b = background in
  b#texture#set img
  