(*
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
V                               V
V  1                         2  V
V  1 B                       2  V
V  1                         2  V
V  1                         2  V
V                               V
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
*)

let wall_thickness = 32

let window_width = 800
let window_height = 600

let paddle_width = 24
let paddle_height = 80

let paddle1_x = wall_thickness 
let paddle1_y = window_height/2 (*- wall_thickness - paddle_height*)

(*let paddle2_x = window_width - paddle1_x - paddle_width
let paddle2_y = paddle1_y*)
let paddle_color = Texture.blue

(*let paddle_v_up =
  if paddle_height= 128/2 then paddle_height <- 128; paddle1_y = paddle1_y-(128/2) 
let paddle_v_down = 
  if paddle_height= 128 then paddle_height <- 128/2; paddle1_y = paddle1_y+(128/2) *)
let paddle_v_right = Vector.{ x = 5.0; y = 0.0 }
let paddle_v_left = Vector.sub Vector.zero paddle_v_right

let ball_size = 24
let ball_color = Texture.transparent

let ball_v_offset = window_height / 2 - ball_size / 2
let ball_left_x = 128 + ball_size / 2
let ball_right_x = window_width - ball_left_x - ball_size



let hwall_width = window_width
let hwall_height = wall_thickness
let hwall1_x = 0
let hwall1_y = 0
let hwall2_x = 0
let hwall2_y = window_height -  wall_thickness
let hwall_color = Texture.marron

let vwall_width = wall_thickness
let vwall_height = window_height - 2 * wall_thickness
let vwall1_x = 0
let vwall1_y = wall_thickness
let vwall2_x = window_width - wall_thickness
let vwall2_y = vwall1_y
let vwall_color = Texture.yellow


(*pour faire un sol avec un trou ou de l'eau qu'il faudrait depasser sans tomber dedans*)
(*la premiere partie*)
let trou1_x = 0
let trou1_y = window_height -  wall_thickness
let trou1_taille =400

(*on peut rajouter le code pour le trou ici*)

(*le reste du sol*)
let trou2_x = 550
let trou2_y = window_height -  wall_thickness
let trou2_taille =window_width-550
(*---------------------------------------------------*)


(*la caisse sur quoi il faudrait sauter*)
let caisse_dim = 60
let caisse_x = 300
let caisse_y = window_height-hwall_height-caisse_dim
let caisse_color = Texture.red
(*-----------------------------------------------------------*)


(*pour la jungle on fait une sorte de cordon à la tarzan sur quoi le personnage pourrait s'aggriper et sauter*)

let corde_x = 475
let corde_y = wall_thickness 
let corde_width = 20 
let corde_height = window_height/2 
let corde_color = Texture.marron

(*--------------------------------------------------------------------*)

let font_name = if Gfx.backend = "js" then "monospace" else "resources/images/monospace.ttf"
let font_color = Gfx.color 0 0 0 255
