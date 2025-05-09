
(*
# # # # # # # #
#             #
#             #
#             #
# 1           #
# # # # # # # #

*)
let window_width = 800
let window_height = 600

let wall_thickness = 1
let ground_thickness = 40

let hwall_width = window_width
let top_wall_height = wall_thickness
let bot_wall_height = ground_thickness
let top_wall_x = 0
let top_wall_y = 0
let bot_wall_x = 0
let bot_wall_y = window_height - ground_thickness
let hwall_color = Texture.transparent

let vwall_width = wall_thickness
let vwall_height = window_height - 2 * wall_thickness
let vwall1_x = 0
let vwall1_y = wall_thickness
let vwall2_x = window_width - wall_thickness
let vwall2_y = vwall1_y
let vwall_color = Texture.transparent


let player_width = 36     (* 36/4 = 9*)
let player_height = 64    (* 64/4 = 16*)

let player_x = 100.0
let player_y = float (window_height - ground_thickness - player_height)

let player_mass = 5.0

let player_texture = Texture.blue

let player_up = Vector.{ x = 0.0; y = -5.0 }
let player_down = Vector.{ x = 0.0; y = 5.0 }
let player_right = Vector.{ x = 5.0; y = 0.0 } 
let player_left = Vector.{ x = -5.0; y = 0.0 }
let player_jump = Vector.{ x = 0.0; y = -50.0 }

let font_name = if Gfx.backend = "js" then "monospace" else "resources/images/monospace.ttf"
let font_color = Gfx.color 0 0 0 255


let background_x = 0
let background_y = 0


let portal_x = 500
let portal_y = 500
let portal_width = 64

