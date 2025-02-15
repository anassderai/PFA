open Ecs
open Component_defs
open System_defs

let ball ctx font =
  let e = new ball () in
  let y_orig = float Cst.ball_v_offset in
  e#texture#set Cst.ball_color;
  e#position#set Vector.{x = float Cst.ball_left_x; y = y_orig};
  e#box#set Rect.{width = Cst.ball_size; height = Cst.ball_size};
  
  (* Question 7.6 rajouter velocity *)
  e#velocity#set Vector.zero;
    (* Question 8.2 : *)
    e#resolve#set (fun n t ->
      match t#tag#get with
      Wall.HWall _ | Player.Player ->  
        let velo = e#velocity#get in 
        e#velocity#set {x = velo.x *. n.x; y = velo.y *. n.y}
      |Wall.VWall (i,_) -> 
        if i=1 (*gauche *) then e#position#set Vector.{x = float Cst.ball_left_x; y = float Cst.paddle1_y}
        else   (* droite *) e#position#set Vector.{x = float Cst.ball_right_x; y = float Cst.paddle1_y};
        e#velocity#set Vector.zero;
        let g= Global.get() in
        g.waiting <- i; 
      | _ -> () 
    );
  Draw_system.(register (e :>t));
  Collision_system.(register (e :> t));
  (* Question 7.6 enregistrer auprès du Move_system *)
  Move_system.(register (e:>t));
  e

let random_v b =
  let a = Random.float (Float.pi/.2.0) -. (Float.pi /. 4.0) in
  let v = Vector.{x = cos a; y = sin a} in
  let v = Vector.mult 5.0 (Vector.normalize v) in
  if b then v else Vector.{ v with x = -. v.x }

let restart () =
  let global = Global.get () in
  if global.waiting <> 0 then begin
    let v = random_v (global.waiting = 1) in
    global.waiting <- 0;
    (* à remplacer question 7.6 la vitesse de global.ball à v *)
    global.ball#velocity#set v;
  end