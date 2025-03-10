open Component_defs

type t = {
  window : Gfx.window;
  ctx : Gfx.context;
  bground : background;
  player1 : player;
}

let state = ref None

let get () : t =
  match !state with
    None -> failwith "Uninitialized global state"
  | Some s -> s

let set s = state := Some s
