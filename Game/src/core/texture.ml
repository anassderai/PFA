type t =
  | Image of Gfx.surface
  | Color of Gfx.color
  | Animation of Gfx.surface array

let black = Color (Gfx.color 0 0 0 255)
let white = Color (Gfx.color 255 255 255 255)
let red = Color (Gfx.color 255 0 0 255)
let green = Color (Gfx.color 0 255 0 255)
let blue = Color (Gfx.color 0 0 255 255)
let orange = Color (Gfx.color 255 128 0 128)

let yellow = Color (Gfx.color 255 255 0 255)
let transparent = Color (Gfx.color 0 0 0 0)
let white_transparent = Color (Gfx.color 255 255 255 128)

let draw ctx dst pos box src =
  let x = int_of_float pos.Vector.x in
  let y = int_of_float pos.Vector.y in
  let Rect.{width;height} = box in
  match src with
    | Image img -> Gfx.blit_scale ctx dst img x y width height
    | Color c ->
      Gfx.set_color ctx c;
      Gfx.fill_rect ctx dst x y width height
    | Animation img -> Gfx.blit_scale ctx dst img.(0) x y width height