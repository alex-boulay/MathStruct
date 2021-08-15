
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
function Segment:toLine()
  return Line(self.startp,self.endp:sub(self.startp))
end

function Segment:project(vector)
  local ontoU=vector:unit()
  return Range{ontoU:dotProd(self.startp),ontoU:dotProd(self.endp)}
end


function Segment:OnOneSide(axis)
  local d1 =axis.base:sub(self.startp)
  local d2 = axis.base:sub(self.endp)
  local n = axis.direction:rotate90()
  return n:dotProd(d1)*n:dotProd(d2)>0
end

function Segment:project(vector)
  local onto=vector:unit()
  return Range(onto:dotProd(self.startp),onto:dotProd(self.endp))
end

--segment collision
function Segment:Scol(segment)
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
assert(not s1:Scol(s2),"Segment collision function error")
assert(s1:Scol(s3),"Segment collision function error")
assert(s2:Scol(s3),"Segment collision function error")
]]

function Segment:intersect(segment)

end
function Segment:print()
  return "P1 : "+self.startp:print()+" | P2 : "+self.endp:print()+" ;\n"
end

function Segment:ColP(point)
  local d=self.endp:sub(self.startp)
  local lp=point:sub(self.startp)
  local pr= lp:project(d)
  return lp:eq(pr) and pr.length()<=d:length()and 0<= pr:dotProd(d)
end

--[[Testcode
require "MathStructs"
p = Vector(1, 4)
s = Segment(Vector(6, 6),Vector(13, 4))
assert(not s:ColP(p),"Segment to point collision function issue");
]]
