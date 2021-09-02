Ray = Class{}

function Ray:init(p,v)
  self.b=p --base
  self.d=v --direction
end

function Ray:type()
  return "Ray"
end



--point collision
function Ray:ColP(p)
  local vec= p:sub(self.b)
  return self.d:Perp(vec)==0 and self.d:dotProd(vec)>=0
end
--[[Testcode
require "MathStructs"
r = Ray(Vector(0,0),Vector(1,1))
a= Vector(3,3)
b= Vector(2,4)
c=Vector(-1,4)
d=Vector(1,-4)
e=Vector(-4,-4)
f=Vector(0,0)
assert(r:ColP(a),"Ray Point collision funcion issue")
assert(not r:ColP(b),"Ray Point collision funcion issue")
assert(not r:ColP(c),"Ray Point collision funcion issue")
assert(not r:ColP(d),"Ray Point collision funcion issue")
assert(not r:ColP(e),"Ray Point collision funcion issue")
assert(r:ColP(f),"Ray Point collision funcion issue")
]]

function Ray:ColS(seg)
  if self:ColP(seg:startp) or self:ColP(seg:endp) then
    return true
  end
  local s1= seg.startp:sub(self.base)
  local s2= seg.endp:sub(self.base)
  if self.d:perp(s1)*self.d:perp(s2)>0 then
    return false
  end
  -- intersection equasion inside todo
end

function Ray:intersect(segment)

end
