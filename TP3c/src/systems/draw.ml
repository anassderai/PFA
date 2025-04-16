open Component_defs

type t = drawable

let init _ = ()

let white = Gfx.color 255 255 255 255

let dt = ref 0.0

let in_move_player = ref 0

let animation () = (* Ordre des images pour animation player [1,2,3,2,1,4,5,4] *)
  match !in_move_player with
  | 0 -> in_move_player := 1; 1
  | 1 -> in_move_player := 2; 2
  | 2 -> in_move_player := 3; 3
  | 3 -> in_move_player := 4; 2
  | 4 -> in_move_player := 5; 1
  | 5 -> in_move_player := 6; 4
  | 6 -> in_move_player := 7; 5
  | 7 -> in_move_player := 0; 4
  | _ -> failwith "Invalid animation state"

let update _dt el =
  let win = Game_state.get_window () in
  let ctx = Gfx.get_context win in
  let win_surf = Gfx.get_surface win in
  let w, h = Gfx.get_context_logical_size ctx in
  let () = Gfx.set_color ctx white in
  let () = Gfx.fill_rect ctx win_surf 0 0 w h in


  Seq.iter (fun (e:t) -> 
    if e#index#get == 0 then 
      let pos = e#pos#get in
      let rect = e#rect#get in
      let txt = e#texture#get in
      Texture.draw ctx win_surf pos rect txt
      ) el;
  Seq.iter (fun (e:t) ->
    if e#index#get != 0 then 
      let txt:Texture.t =
        match e#index#get, e#move#get with
          | 1, 0 -> 
            (match e#texture#get with 
              | Texture.Animation a -> (Image a.(0))
              | _ -> failwith "Invalid texture type")
          | 1, move when move != 0 ->
              if !dt <= _dt -. 10.0 then begin
                dt := _dt;
                let move = animation () in 
                (match e#texture#get with 
                  | Texture.Animation a -> (Image a.(move))
                  | _ -> failwith "Invalid texture type")
              end
              else
                (match e#texture#get with 
                  | Texture.Animation a -> (Image a.(!in_move_player))
                  | _ -> failwith "Invalid texture type")
          | _ -> e#texture#get
      in
      let pos = e#pos#get in
      let rect = e#rect#get in
      Texture.draw ctx win_surf pos rect txt
    ) el;

  (* Seq.iter (fun (e : t) ->
      let Vector.{ x; y } = e # pos # get in
      let x = int_of_float x in
      let y = int_of_float y in
      let Rect.{width; height} = e # rect # get in
      match e # texture # get with
        | Texture.Color color ->
          Gfx.set_color ctx color;
          Gfx.fill_rect ctx win_surf x y width height
        | Texture.Image img ->
          Gfx.blit_scale ctx win_surf img x y width height
    ) el; *)
  Gfx.commit ctx