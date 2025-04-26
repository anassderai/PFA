let () = Printexc.record_backtrace true

open System_defs
open Cst 

(* On crée une fenêtre *)
let init =
  let win = Gfx.create (Format.sprintf "game_canvas:%dx%d:r=presentvsync" 800 600) in
  Game_state.set_window win;
  ignore (Wall.create top_wall_x top_wall_y hwall_width top_wall_height hwall_color);
  ignore (Wall.create bot_wall_x bot_wall_y hwall_width bot_wall_height hwall_color);
  ignore (Wall.create vwall1_x vwall1_y vwall_width vwall_height hwall_color);
  ignore (Wall.create vwall2_x vwall2_y vwall_width vwall_height hwall_color)

(*a supprimer
(* Question 10 *)
let init_squares =
  let () = Random.self_init () in
  for i = 0 to 9 do
    let x = 40 + Random.int  720 in
    let y = 40 + Random.int 500 in
    let mass = 1.0 +. Random.float 19.0 in
    let texture = Texture.Color (Gfx.color 255 0 0 255) in
    let s = Box.create x y 50 50 texture mass in
    s#sum_forces#set Vector.{ x = Random.float 0.25; y = Random.float 0.25 }
  done
*)

(*
 let keys = Hashtbl.create 16
let white = Gfx.color 255 255 255 2555
*)
let update dt =
  Input.handle_input ();
  if Transition.is_ok () then
    begin
      Transition.reset ();
      Level.next_level ()
    end;
  Collision_system.update dt;
  Force_system.update dt;
  Force_moon_system.update dt;
  Move_system.update dt;
  Draw_system.update dt;
  None

let (let@) a b = Gfx.main_loop a b

let run () =

  Gfx.debug "Game start \n %!";

  init;

  (* init_squares; *)

  (* Load images : *)
  let win = Game_state.get_window () in
  let ctx = Gfx.get_context win in

  (* Init images perso gojo *)

  let file_perso = Gfx.load_file "resources/files/images_perso.txt" in
  let@ txt_perso = fun _ -> Gfx.get_resource_opt file_perso in 
  let images_r_perso = 
    txt_perso
    |> String.split_on_char '\n'
    |> List.filter (fun s -> s <> "") (* retire les lignes vides *)
    |> List.map (fun s -> Gfx.load_image ctx ("resources/images/player/gojo/" ^ s))
  in
  let@ images_perso = fun _ ->
    if List.for_all Gfx.resource_ready images_r_perso then
    Some (List.map Gfx.get_resource images_r_perso)
    else None
  in 
  let textures_perso = images_perso
    |> List.map (fun img -> img)
    |> Array.of_list
  in
  Gfx.debug "textures perso loaded \n%!";
  let textures_player = [|(Array.sub textures_perso 0 14)|] in 
  let file = Gfx.load_file "resources/files/images.txt" in
  let@ txt = fun _ -> Gfx.get_resource_opt file in 
  let images_r = 
    txt
    |> String.split_on_char '\n'
    |> List.filter (fun s -> s <> "") (* retire les lignes vides *)
    |> List.map (fun s -> Gfx.load_image ctx ("resources/images/" ^ s))
  in
  let@ images = fun _ ->
    if List.for_all Gfx.resource_ready images_r then
    Some (List.map Gfx.get_resource images_r)
    else None
  in 
  let textures = images
    |> List.map (fun img -> Texture.Image img)
    |> Array.of_list
  in
  Gfx.debug "Textures loaded \n %!";
  Level.level_0 textures textures_player;
  Gfx.debug "Level loaded \n %!";

  Gfx.main_loop update (fun () -> ())


(* 

  - faire collision par rapport a l'index des entités 

  - level : 
    - load level 0 
    - next_level : 
                  - suivant une ref 0 -> 1 2 3 4 5 
                  - load level suivant suivant la ref 

  - unregister entity suivant les niveaux et l'index de l'entité
    - comment on fait pour recupérer les entités ?
    - comment on fait pour bien les supprimer ?
    


  - animation : 
    faire un nouveau composant texture de draw 
    rajouter animation dans texture 
    regarder dans draw suivant le dt 
    modifier le fill rect de texture avec un match animation et afficher
    faire un petit tableau spécial pour chaque animation du perso 
*)