open Ecs

(* Some basic components *)
class position =
  object
    val pos = Component.def Vector.zero
    method pos = pos
  end

class rect =
  object
    val rect = Component.def Rect.{width = 0; height = 0}
    method rect = rect
  end

class velocity =
  object
    val velocity = Component.def Vector.zero
    method velocity = velocity
  end

class texture =
  object
    val texture = Component.def (Texture.Color (Gfx.color 0 0 0 0))
    method texture = texture
  end

class id =
  object
    val id = Component.def ("")
    method id = id
  end

class mass =
  object
    val mass = Component.def 0.0
    method mass = mass
  end

class sum_forces =
  object
    val sum_forces = Component.def Vector.zero
    method sum_forces = sum_forces
  end

class index_draw = 
  object 
    val index_draw = Component.def 0
    method index_draw = index_draw
  end

class room = 
  object 
    val room = Component.def 0
    method room = room
  end

  class on_ground = 
  object 
    val on_ground = Component.def false
    method on_ground = on_ground
  end

(* Some complex components *)

class movable =
  object
    inherit position
    inherit velocity
  end

class drawable =
  object
    inherit position
    inherit rect
    inherit texture
    inherit index_draw
  end

class collidable =
  object
    inherit velocity
    inherit position
    inherit rect
    inherit mass
  end

class physics =
  object
    inherit mass
    inherit sum_forces
    inherit velocity
  end


(* Entity *)

class box = 
  object
    inherit drawable
    inherit! collidable
    inherit! physics
    inherit id
  end

class player = 
  object 
    inherit drawable
    inherit! collidable
    inherit! physics
    inherit on_ground
    inherit room
  end

class wall = 
object 
  inherit drawable
  inherit! collidable
  inherit! physics
end

class background = 
object 
  inherit drawable
end
