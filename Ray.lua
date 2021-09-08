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
      local seghe = seg --enhanced version of the seg for calculus practicality
      if self.d:dotProd(seg:toVect()) < 0 then
        seghe=seg:reverse()
        local temp=s1
        s1=s2
        s2=temp
      end
      if s1:dotProd(self.d)<0 then
        return Segment(self.b,seghe.endp)
      else
        return seghe
      end
    end
    if self:ColP(seg.startp) then
      return seg.startp
    else
      return seg.endp
    end
  else
    if self.d:Perp(s1)*self.d:Perp(s2)>0 then
      return false
    else
      --Perp prop 2 lines (A,a) (B,b) c=A-B t=b:perp(c)/b:perp(a)
      --where t is the coeficient of line direction A + a*t
      local t = seg:toVect():Perp(s1)/seg:toVect():Perp(self.d)
      if t >=0 then
        return self.b:add(self.d:multiply(t))
      else
        return false
      end
    end
  end
end

--[[Testcode
require "MathStructs"
a=Vector(0,0)
b=Vector(1,1)
r=Ray(a,b)
c=Vector(-3,2)
d=Vector(1,-3)
e=Vector(4,-3)
f=Vector(7,2)
g=Vector(3,5)
h=Vector(-2,-2)
i=Vector(-4,-4)
s1=Segment(c,d)
s2=Segment(c,e)
s3=Segment(c,f)
s4=Segment(c,g)
s5=Segment(c,h)
s6=Segment(c,i)
s7=Segment(Vector(-2,-2),Vector(-4,-4))
assert(r:IntS(Segment(a,b)):eq(Segment(a,b)),"Ray to segment intersection function issue")
assert(not r:IntS(s1),"Ray to segment intersection function issue")
assert(not r:IntS(s2),"Ray to segment intersection function issue")
assert(r:IntS(s3):eq(Vector(2,2)),"Ray to segment intersection function issue")
assert(not r:IntS(s4),"Ray to segment intersection function issue")
assert(not r:IntS(s5),"Ray to segment intersection function issue")
assert(not r:IntS(s6),"Ray to segment intersection function issue")
assert(not r:IntS(s7),"Ray to segment intersection function issue")
]]

function Ray:ColR(rectangle)
  local edges=rectangle:Edges()
  for k,v in pairs(edges) do
    if self:ColS(v) then
      return true
    end
  end
  return false
end

--[[ Testcode
require "MathStructs"

]]

function Ray:IntR(rect)
  local edges = rect:Edges()
  local result={}
  local calc
  for k,v in pairs(edges) do
    calc=self:IntS(v)
    if calc~=false then
      table.insert(result,calc)
    end
  end
  if not next(result) then
    return false
  else
    return result
  end
end

function Ray:ColOR(rect)
  return Ray:ColR(rect)
end

function Ray:IntOR(rect)
  return Ray:IntR(rect)
end

function Ray:ColC(circle)

end

function Ray:IntC(cirle)

end
