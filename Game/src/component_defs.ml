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

class index = 
  object 
    val index = Component.def 0
    method index = index
  end
(* values => cf fichier index.txt en dehors du src *)

class on_ground = 
  object 
    val on_ground = Component.def false
    method on_ground = on_ground
  end

class move = 
  object 
    val move = Component.def (0,0)
    method move = move
    method set_fst n = match move#get with
      | (x,y) -> move#set (n,y)
    method set_snd n = match move#get with
      | (x,y) -> move#set (x,n)
  end
(* values :
  * (1,0) : no move right
  * (2,0) : no move left
  * (3,0) : right
  * (4,0) : left
  * (3,1) || (1,1) : jump right
  * (4,1) || (2,1) : jump left
*)

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
    inherit index
    inherit move
  end

class collidable =
  object
    inherit velocity
    inherit position
    inherit rect
    inherit mass
    inherit index
  end

class physics =
  object
    inherit mass
    inherit sum_forces
    inherit velocity
  end

class physics_moon =
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
  end

class player = 
  object 
    inherit drawable
    inherit! collidable
    inherit! physics
    inherit! physics_moon
    inherit on_ground
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

class corde = 
object 
  inherit drawable
  inherit! collidable
  inherit! physics
end

class portal = 
object 
  inherit drawable
  inherit! collidable
  inherit! physics
end

class platform = 
object 
  inherit drawable
  inherit! collidable
  inherit! physics
end



