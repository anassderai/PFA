open Component_defs
open System_defs

type tag += HWall of wall| VWall of int * wall

let wall (x, y, txt, width, height, horiz) =
  let e = new wall () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#tag#set (if horiz then
               HWall e else VWall((if x < 100 then 1 else 2), e));
  e#box#set Rect.{width; height};
  e#mass#set infinity; 
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  e

let walls () = 
  List.map wall
    Cst.[ 
      (hwall1_x, hwall1_y, hwall_color, hwall_width, hwall_height, true);
      (trou1_x, trou1_y, hwall_color, trou1_taille, hwall_height, true);
      (trou2_x, trou2_y, hwall_color, trou2_taille, hwall_height, true);
      (caisse_x,caisse_y,caisse_color,caisse_dim,caisse_dim,false);
      (corde_x,corde_y,corde_color,corde_width,corde_height,false);
      (vwall1_x, vwall1_y, vwall_color, vwall_width, vwall_height, false);
      (vwall2_x, vwall2_y, vwall_color, vwall_width, vwall_height, false);
    ]
