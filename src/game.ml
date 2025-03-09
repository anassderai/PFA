open System_defs
open Component_defs
open Ecs

let update dt =
  let () = Player.stop_players () in
  let () = Input.handle_input () in
  Collision_system.update dt;
  Force_system.update dt;
  Draw_system.update dt;
  Move_system.update dt;
  None

(* sucre synthaxique 
let@ x = a in b
Gfx.main_loop a (fun x -> b)
*)

let (let@) a b = Gfx.main_loop a b

let run () =
  let window_spec = 
    Format.sprintf "game_canvas:%dx%d:"
      Cst.window_width Cst.window_height
  in
  let window = Gfx.create window_spec in
  let ctx = Gfx.get_context window in
  (*let font = Gfx.load_font Cst.font_name "" 128 in
  *)
  let file = Gfx.load_file "resources/files/background.txt" in
  Gfx.main_loop
    (fun _dt -> Gfx.get_resource_opt file)
    (fun txt ->
       let images_r =
         txt
         |> String.split_on_char '\n'
         |> List.filter (fun s -> s <> "") (* retire les lignes vides *)
         |> List.map (fun s -> Gfx.load_image ctx ("resources/images/" ^ s))
       in
       Gfx.main_loop (fun _dt ->
           if List.for_all Gfx.resource_ready images_r then
             Some (List.map Gfx.get_resource images_r)
           else None
         )
         (fun images ->
            let textures = images
                           |> List.map (fun img -> Texture.Image img)
                           |> Array.of_list
            in
  
            let _walls = Wall.walls () in
            let player1 = Player.player () in
            let bground = Background.background (Array.get textures 0) in 
            let global = Global.{ window; ctx; bground; player1;} in
            Global.set global;
            Gfx.main_loop update (fun () -> ())
  ))
            

