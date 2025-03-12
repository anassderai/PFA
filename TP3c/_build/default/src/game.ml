open System_defs
open Cst 

(* On crée une fenêtre *)
let init () =
  let win = Gfx.create (Format.sprintf "game_canvas:%dx%d:r=presentvsync" 800 600) in
  Game_state.set_window win

(* Question 1 *)
let init_walls () =
  ignore (Wall.create top_wall_x top_wall_y hwall_width top_wall_height hwall_color);
  ignore (Wall.create bot_wall_x bot_wall_y hwall_width bot_wall_height hwall_color);
  ignore (Wall.create vwall1_x vwall1_y vwall_width vwall_height hwall_color);
  ignore (Wall.create vwall2_x vwall2_y vwall_width vwall_height hwall_color)


(* Question 10 *)
let init_squares () =
  let () = Random.self_init () in
  for i = 0 to 9 do
    let x = 40 + Random.int  720 in
    let y = 40 + Random.int 500 in
    let mass = 1.0 +. Random.float 19.0 in
    let texture = Texture.Color (Gfx.color 255 0 0 255) in
    let s = Box.create (Printf.sprintf "square_%d" i ) x y 50 50 texture mass in
    s#sum_forces#set Vector.{ x = Random.float 0.25; y = Random.float 0.25 }
  done

let init_player = ignore (Player.create player_x player_y player_width player_height player_texture player_mass)

(*
 let keys = Hashtbl.create 16
let white = Gfx.color 255 255 255 2555
*)
let update dt =
  Input.handle_input ();
  Collision_system.update dt;
  Force_system.update dt;
  Move_system.update dt;
  Draw_system.update dt;
  true

let run () =
  init ();
  init_walls ();
  (* init_squares (); *)
  init_player;
  Gfx.main_loop update
