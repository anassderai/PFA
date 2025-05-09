(* Question 5 *)
open Component_defs

type t = physics

let init _ = ()
let dt = 1000.0 /. 60.0
let gravity = Vector.{x = 0.0; y = 0.001 }
let update _dt el =
  Seq.iter
    (fun (e : t) ->
      let m = e#mass#get in
      if Float.is_finite m then begin
        let f = Vector.add gravity e#sum_forces#get in
        e#sum_forces#set Vector.zero;
        let a = Vector.mult (1. /. m) f in
        let dv = Vector.mult dt a in
        let v = e#velocity#get in
        let drag = Vector.{ x = v.x *. -0.01; y = 0.0 } in
        e#velocity#set (Vector.add v (Vector.add drag dv))
      end)
    el
