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
  if self:ColP(seg.startp) or self:ColP(seg.endp) then
    return true
  end
  local s1= seg.startp:sub(self.b)
  local s2= seg.endp:sub(self.b)
  if self.d:Perp(s1)*self.d:Perp(s2)>0 then
    return false
  end
  --Perp prop 2 lines (A,a) (B,b) c=A-B t=b:perp(c)/b:perp(a)
  --where t is the coeficient of line direction A + a*t
  --so if t is negative it means that it intersect behind the ray
  return seg:toVect():Perp(s1)/seg:toVect():Perp(self.d) >= 0
end

--[[Testcode
require "MathStructs"
r=Ray(Vector(0,0),Vector(1,1))
a=Vector(-3,1)
b=Vector(1,-3)
c=Vector(4,-3)
d=Vector(7,2)
e=Vector(3,5)
s1=Segment(a,b)
s2=Segment(a,c)
s3=Segment(a,d)
s4=Segment(a,e)
s5=Segment(c,d)
s6=Segment(e,d)
s7=Segment(Vector(-2,-2),Vector(-4,-4))
assert(not r:ColS(s1),"Ray Segment collision funcion issue")
assert(not r:ColS(s2),"Ray Segment collision funcion issue")
assert(r:ColS(s3),"Ray Segment collision funcion issue")
assert(not r:ColS(s4),"Ray Segment collision funcion issue")
assert(not r:ColS(s5),"Ray Segment collision funcion issue")
assert(r:ColS(s6),"Ray Segment collision funcion issue")
assert(not r:ColS(s7),"Ray Segment collision funcion issue")
]]


-- return false or a Vector or a Segment
function Ray:IntS(seg)
  local s1= seg.startp:sub(self.b)
  local s2= seg.endp:sub(self.b)
  if self:ColP(seg.startp) or self:ColP(seg.endp) then
    if self.d:Perp(seg:toVect()) == 0 then
      local seghe =seg --enhanced version of the seg for calculus practicality
      if self.d:DotProd(seg:toVect()) < 0 then
        seghe=seg:reverse()
        local temp=s1
        s1=s2
        s2=temp
      end
      if s1:DotProd(self.d)<0 then
        return Segment(self.b,seghe.endp)
      else
        return seghe
      end
    end
    else if self:ColP(seg.startp) then
      return seg.startp
    else
      return seg.endp
    end
  end
  if self.d:Perp(s1)*self.d:Perp(s2)>0 then
    return false
  end
  --Perp prop 2 lines (A,a) (B,b) c=A-B t=b:perp(c)/b:perp(a)
  --where t is the coeficient of line direction A + a*t
  return self.b:add(self.d:multiply(seg:toVect():Perp(s1)/seg:toVect():Perp(self.d)))
end

--[[Testcode
require "MathStructs"
r=Ray(Vector(0,0),Vector(1,1))
a=Vector(-3,1)
b=Vector(1,-3)
c=Vector(4,-3)
d=Vector(7,2)
e=Vector(3,5)
s1=Segment(a,b)
s2=Segment(a,c)
s3=Segment(a,d)
s4=Segment(a,e)
s5=Segment(c,d)
s6=Segment(e,d)
s7=Segment(Vector(-2,-2),Vector(-4,-4))
print(r:IntS())
