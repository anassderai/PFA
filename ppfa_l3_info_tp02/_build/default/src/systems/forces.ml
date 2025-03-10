open Ecs
open Component_defs

type t = forcable

let init _ = ()

let dt = 1000.0 /. 60.0
let gravity = Vector.{x = 0.0; y = 0.5 }

let update _dt el = 
  Seq.iter ( fun (e:t) -> 
    let mass_e = e#mass#get in 
    if Float.is_finite mass_e then begin
      let f = Vector.add gravity e#sum_forces#get in
      let v = Vector.mult (1.0/.mass_e) f in 
      let m = Vector.mult dt v in 
      let k = e#velocity#get in
      let drag = Vector.{ x = v.x *. -0.01; y = 0.0 } in
      e#velocity#set (Vector.add k (Vector.add drag m))
      end)
    el;

  