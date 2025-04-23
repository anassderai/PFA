let ok = ref 0 

let set w = ok := w

let get () = !ok

let is_ok () = if !ok = 1 then true else false

let next () = ok := 1

let reset () = ok := 0