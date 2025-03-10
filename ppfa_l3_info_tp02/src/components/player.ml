open Ecs
open Component_defs
open System_defs
open Cst

type tag += Player

let player (name, x, y, txt, width, height, mass) =
  let e = new player name in
  e#texture#set txt;
  e#tag#set Player;
  e#position#set Vector.{x = float x; y = float y};
  e#box#set Rect.{width; height};
  e#velocity#set Vector.zero;
  e#mass#set mass;
  e#on_ground#set false;
  e#index_draw#set 2;
  e#room#set 0;
 (* e#sum_forces#set Vector.zero;*)

  e#resolve#set (fun _ t ->
    match t#tag#get with
    Wall.HWall (w) -> 
      let pos_w = w#position#get in 
      let pos_e = e#position#get in 
    if pos_w.y = 0.0 then begin e#position#set Vector.{x = pos_e.x; y = pos_e.y+.4.0}; e#velocity#set Vector.zero
    end 
    else begin e#position#set Vector.{x = pos_e.x; y = float_of_int(window_height) -.float_of_int(player_height)-. float_of_int(wall_thickness)}; e#on_ground#set true end 
    |Wall.VWall (i,_) -> 
      let pos_e = e#position#get in
      if i=1 (*gauche *) then e#position#set Vector.{x = float_of_int(wall_thickness) ; y = pos_e.y}
      else   (* droite *) e#position#set Vector.{x = float_of_int(window_width) -. float_of_int(wall_thickness)-. float_of_int(player_width) ; y = pos_e.y};
      e#velocity#set Vector.zero;
    |_ -> ()
  );

  Collision_system.(register (e :> t));
  Move_system.(register (e:>t));
  Draw_system.(register (e :> t));
  Force_system.(register (e:>t));

  
  e

let player () =  
  player Cst.("player1", player_x, player_y, player_color, player_width, player_height, player_mass)


let player1 () = 
  let Global.{player1; _ } = Global.get () in
  player1


let stop_player () = 
  let Global.{player1; _ } = Global.get () in
  player1#velocity#set Vector.zero


let move_player player v =
  player#velocity#set (Vector.add (player#velocity#get) v)