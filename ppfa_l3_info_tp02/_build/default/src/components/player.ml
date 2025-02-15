open Ecs
open Component_defs
open System_defs

type tag += Player

let player (name, x, y, txt, width, height) =
  let e = new player name in
  e#texture#set txt;
  e#tag#set Player;
  e#position#set Vector.{x = float x; y = float y};
  e#box#set Rect.{width; height};
  (* Rajouter velocity question 7.5 *)
  e#velocity#set Vector.zero;
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));

    (* Question 8.1 : *)
    e#resolve#set (fun _ t ->
      match t#tag#get with
      |Wall.HWall (w) -> 
        let pos_w = w#position#get in 
        let pos_e = e#position#get in 
      if pos_w.y = 0.0 then e#position#set Vector.{x = pos_e.x; y = pos_e.y+.3.0}
      else e#position#set Vector.{x = pos_e.x; y = pos_e.y-.3.0};
      e#velocity#set Vector.zero 
      |Wall.VWall (i,_) -> 
        let pos_e = e#position#get in
        if i=1 (*gauche *) then e#position#set Vector.{x =pos_e.x+.3.0; y = pos_e.y}
        else   (* droite *) e#position#set Vector.{x =pos_e.x-.3.0; y =pos_e.y};
        e#velocity#set Vector.zero;
      |_ -> ()
    );
  
  (* Question 7.5 enregistrer auprès du Move_system *)
  Move_system.(register (e:>t));
  e

let players () =  
  player  Cst.("player1", paddle1_x, paddle1_y, paddle_color, paddle_width, paddle_height)


let player1 () = 
  let Global.{player1; _ } = Global.get () in
  player1



let stop_players () = 
  let Global.{player1; _ } = Global.get () in
  (* À remplacer en question 7.5, mettre la vitesse à 0 *)
  player1#velocity#set Vector.zero


let move_player player v =
  (* À remplacer en question 7.5, mettre la vitesse du joueur à v *)
  player#velocity#set v