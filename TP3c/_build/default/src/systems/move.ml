(* Question 3 *)
open Component_defs

type t = movable

let init _ = ()
let dt = 1000. /. 30.

let update _dt el =
  Seq.iter
    (fun (e : t) ->
      let v = e#velocity#get in
      let p = e#pos#get in
      let np = Vector.add p (Vector.mult dt v) in
      e#pos#set np)
    el
