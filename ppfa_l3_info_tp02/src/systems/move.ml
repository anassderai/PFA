open Ecs
open Component_defs

type t = movable

let init _ = ()

let update _ el = 
  Seq.iter (fun (e:t) ->
    let pos = e#position#get in 
    let velo = e#velocity#get in 
    e#position#set { x = (pos.x +. velo.x); y = (pos.y +. velo.y)}
  
  ) el;
