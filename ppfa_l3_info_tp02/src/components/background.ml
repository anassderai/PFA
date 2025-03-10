open Component_defs
open System_defs

type tag += Background

let background (x, y, txt, width, height) = 
  let e = new background () in 
  e#tag#set Background;
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#box#set Rect.{width; height};
  e#index_draw#set 0;

  Draw_system.(register(e:>t));
  e


let background (img_background) = 
  background Cst.(background_x, background_y, img_background, window_width, window_height)