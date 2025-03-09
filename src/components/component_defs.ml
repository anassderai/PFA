open Ecs
class position () =
  let r = Component.init Vector.zero in
  object
    method position = r
  end

class box () =
  let r = Component.init Rect.{width = 0; height = 0} in
  object
    method box = r
  end

class texture () =
  let r = Component.init (Texture.Color (Gfx.color 0 0 0 255)) in
  object
    method texture = r
  end

type tag = ..
type tag += No_tag

class tagged () =
  let r = Component.init No_tag in
  object
    method tag = r
  end

class resolver () =
  let r = Component.init (fun (_ : Vector.t) (_ : tagged) -> ()) in
  object
    method resolve = r
  end

(* add *)

class velocity () = 
  let r = Component.init Vector.zero in 
  object 
    method velocity = r
  end 

class mass () =
  let m = Component.init 0.0 in 
  object 
    method mass = m 
  end

class sum_forces () =
  let s = Component.init Vector.zero in 
  object 
    method sum_forces = s 
  end

class index_draw () = 
  let id = Component.init 0 in 
  object 
    method index_draw = id
  end

class room () = 
  let r = Component.init 0 in 
  object 
    method room = r 
  end


(** Interfaces : ici on liste simplement les types des classes dont on hérite
    si deux classes définissent les mêmes méthodes, celles de la classe écrite
    après sont utilisées (héritage multiple).
*)

class type collidable =
  object
    inherit Entity.t
    inherit position
    inherit box
    inherit tagged
    inherit resolver
  end

class type drawable =
  object
    inherit Entity.t
    inherit position
    inherit box
    inherit texture
    inherit index_draw
  end

class type movable = 
  object
    inherit Entity.t
    inherit position 
    inherit velocity
  end

class type forcable = 
  object 
    inherit Entity.t
    inherit velocity
    inherit mass 
    inherit sum_forces 
  end

(** Entités :
    Ici, dans inherit, on appelle les constructeurs pour qu'ils initialisent
    leur partie de l'objet, d'où la présence de l'argument ()
*)
class player name =
  object
    inherit Entity.t ~name ()
    inherit position ()
    inherit box ()
    inherit tagged ()
    inherit texture ()
    inherit resolver ()
    inherit velocity () 
    inherit mass () 
    inherit sum_forces () 
    inherit index_draw () 
    inherit room () 
  end

class wall () =
  object
    inherit Entity.t ()
    inherit position ()
    inherit box ()
    inherit tagged ()
    inherit texture ()
    inherit resolver ()
    inherit mass () 
    inherit sum_forces ()
    inherit velocity ()
    inherit index_draw () 

  end

class background () = 
  object 
    inherit Entity.t ()
    inherit tagged () 
    inherit texture ()
    inherit position () 
    inherit box ()
    inherit index_draw () 
  end


