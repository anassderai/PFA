open Component_defs

type t = drawable

let init _ = ()

let white = Gfx.color 255 255 255 255
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
      let pos = e#pos#get in
      let rect = e#rect#get in
      let txt = e#texture#get in
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