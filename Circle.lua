Circle = Class{}

function Circle:init(center,radius)
  self.c=center
  self.r=radius
end

--collision with another circle
function Circle:ColC(circle)
  return Segment(self.c,circle.c)<=(self.r+circle.r)
end

function Circle:ColP(point)
  return self.c:sub(point):length()<=self.r
end
--[[ Tests
require "MathStructs"
c = Circle(Vector(6, 4), 3)
p1 = Vector(8, 3)
p2 = Vector(11, 7)
assert(c:ColP(p1),"Circle point collision function issue");
assert(not c:ColP(p2),"Circle point collision function issue");
]]
function Circle:ColL(line)
  return self:ColP(l.base:add(self.c:sub(line.base):project(line.direction)))
end
--[[ Test
require "MathStructs"
c = Circle(Vector(6, 3), 2)
l = Line(Vector(4, 7), Vector(5, -1))
assert(not c:ColL(l),"Circle Line collision function error")
]]

function Circle:ColS(segment)
  if self:ColP(segment.startp)then
    return true
  end
  if self:ColP(segment.endp)then
    return true
  end
  local d= segment.endp:sub(segment.startp)
  local p=self.c:sub(segment.startp):project(d)
  return self:ColP(segment.startp:add(p)) and p:length() <= d:length() and p:dotProd(d)>=0
end

--[[ Test
require "MathStructs"
c = Circle(Vector(4, 4), 3);
s = Segment(Vector(8, 6), Vector(13, 6))
assert(not c:ColS(s),"Circle Segment collision function error")
]]
function Circle:ColRect()
end

Disc = Class{}

function Disc:init(center,rad1,rad2)
  self.c=center
  self.r1=min(rad1,rad2)
  self.r2=max(rad1,rad2)
end
