
Segment = Class{}

function Segment:init(startp,endp)
  self.startp=startp
  self.endp=endp
end

function Segment:type()
  return "Segment"
end

function Segment:length()
  return MSnorm(self.endp.y-self.startp.y,self.endp.x-self.startp.x)
end

function Segment:Direction()
  self.endp:sub(self.startp)
end
function Segment:toLine()
  return Line(self.startp,self:Direction())
end

function Segment:toVect()
  return self.endp:sub(self.startp)
end

function Segment:project(vector)
  local ontoU=vector:unit()
  return Range{ontoU:dotProd(self.startp),ontoU:dotProd(self.endp)}
end

function Segment:eq(segment)
  return (segment.startp:eq(self.startp) and segment.endp:eq(self.endp))
  or (segment.startp:eq(self.endp) and segment.endp:eq(self.startp))
end

--[[
require "MathStructs"
a= Vector(0,2)
b= Vector(1,3)
c=Vector(1,4)
s1=Segment(a,b)
s2=s1:reverse()
s3=Segment(b,a)
s4=Segment(a,c)
assert(s1:eq(s2),"segment equality function error")
assert(s1:eq(s3),"segment equality function error")
assert(not s1:eq(s4),"segment equality function error")
]]
function Segment:OnOneSide(axis)
  local d1 =axis.base:sub(self.startp)
  local d2 = axis.base:sub(self.endp)
  local n = axis.direction:rotate90()
  return n:dotProd(d1)*n:dotProd(d2)>0
end

function Segment:reverse()
  return Segment(self.endp,self.startp)
end
--segment collision
function Segment:ColS(segment)
  local LineA, LineB
  LineA = self:toLine()
  if segment:OnOneSide(LineA) then
    return false
  end
  LineB = segment:toLine()
  if  self:OnOneSide(LineB) then
    return false
  end
  if LineA.direction:parallel(LineB.direction) then
    local RangeA= self:project(LineA.direction)
    local RangeB= segment:project(LineB.direction)
    return RangeA:overlapping(RangeB)
  else
    return true
  end
end

--[[Testcode
require "MathStructs"
a = Vector(3,4)
b = Vector(11,1)
c = Vector(8,4)
d = Vector(11,7)
e = Vector(9,8)
s1= Segment(a,b)
s2= Segment(c,d)
s3= Segment(b,e)
assert(not s1:ColS(s2),"Segment collision function error")
assert(s1:ColS(s3),"Segment collision function error")
assert(s2:ColS(s3),"Segment collision function error")
]]


function Segment:toString()
  return "P1 : "..self.startp:toString().." | P2 : "..self.endp:toString().." ;\n"
end

function Segment:ColP(point)
  local d = self.endp:sub(self.startp)
  local lp = point:sub(self.startp)
  local pr = lp:project(d)
  return lp:eq(pr) and pr:length()<=d:length() and 0<= pr:dotProd(d)
end

--[[Testcode
require "MathStructs"
a = Vector(-3,-1)
b = Vector(5,3)
seg1 = Segment(a,b)
c = Vector(-5,2)
d = Vector(7,4)
e = Vector(3,2)
f = Vector(-1,0)
g = Vector(-1,2)
h = Vector(1,-1)
assert(seg1:ColP(a),"Segment to point collision function issue")
assert(seg1:ColP(b),"Segment to point collision function issue")
assert(not seg1:ColP(c),"Segment to point collision function issue")
assert(not seg1:ColP(d),"Segment to point collision function issue")
assert(seg1:ColP(e),"Segment to point collision function issue")
assert(seg1:ColP(f),"Segment to point collision function issue")
assert(not seg1:ColP(g),"Segment to point collision function issue")
assert(not seg1:ColP(h),"Segment to point collision function issue")
]]

function Segment:ColC(circle)
  return circle:ColS(self)
end

function Segment:ColL(line)
  return line:ColS(self)
end

function Segment:ColR(rect)
  return rect:ColS(self)
end

function Segment:ColOR(orect)
  return orect:ColS(self)
end


-- Other point segment collision funcion to Test
function Segment:inside(point)
  if self.startp.x ~= self.endp.x then
    if self.startp.x <= point.x and point.x <= self.endp.x then
      return true
    end
    if self.startp.x >= point.x and point.x >= self.endp.x then
      return true
    end
  else
    if self.startp.y <= point.y and point.y<=self.endp.y then
      return true
    end
    if self.startp.y >= point.y and point.y >= self.endp.y then
      return true
    end
  end
  return false
end



function Segment:intS(seg)
 local u = self:toVect()
 local v = seg:toVect()
 local w= self.startp:sub(seg.startp)
 if u:Perp(v) == 0 then
   if u:Perp(w) ~= 0 or v:Perp(w) ~=0 then
     return false
   end
   local du = u:dotProd(u)
   local dv = V:dotProd(v)
   if (du == 0 and dv == 0) then
     if self.startp ~= seg.startp then
       return false
     end
     return self.startp
   end
   if du==0 then
     if not seg:ColP(self.startp) then
       return false
     end
     return self.startp
   end
   if dv == 0 then
     if not self:ColP(seg.startp) then
       return false
     end
     return seg.startp
   end
   local t0
   local t1
   local w2 = self.endp:sub(seg.startp)
   if v.x ~=0 then
     t0 = w.x /v.x
     t1 = w2.x /v.x
   else
     t0 = w.y /v.y
     t1 = w2.y / v.y
   end
   if t0>t1 then
     local t = t0
     t0=t1
     t1=t
   end
   if t1 >1 or t1 <0 then
     return false
   end
   t0 = max(0, t0)
   t1 = min(1, t1)
   if t0 == t1 then
     return seg.startp:add(v:multiply(t0))
   end
   return Segment(seg.startp:add(v:multiply(t0)),seg.startp:add(v:multiply(t1)))
 end
 local sI = v:Perp(w)/u:Perp(v)
 if sI <0 or sI > 1 then
   return false
 end
 local tI = u:Perp(w)/u:Perp(v)
 if tI< 0 or tI > 1 then
   return false
 end
 return self.startp:add(u:multiply(sI))
end


--[[Testcode
require "MathStructs"
a = Vector(-4,-1)
b = Vector(4,1)
seg1 = Segment(a,b)
c = Vector(-2,6)
d = Vector(1,-3)
seg2 = Segment(c,d)
e = Vector(0,-3.39)
f = Vector(-11.24,3.95)
seg3 = Segment(e,f)
assert(seg1:IntersectS(seg2):eq(NullVec),"Segment to segment intersection error")
assert(not seg2:IntersectS(seg3),"Segment to segment intersection error")
]]
