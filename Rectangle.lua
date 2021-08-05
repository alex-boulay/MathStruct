
Rectangle = Class{}

-- rectangle parallel to x and y axis oriented by an angle
function Rectangle:init(origin,size)
  self.c=origin --origin is the botom left point
  self.s=size
end

function Rectangle:findVertices()
  if not self.a then
    self.a=Vector(self.c.x,self.c.y+self.s.x) --top left vertice
    self.b=Vector(self.c.x+self.s.x,self.a.y) --top right vertice
    self.d=Vector(self.c.x,self.b.y)
  end
  return {[0]=self.a,[1]=self.b,[2]=self.c,[3]=self.d}
end

-- return true if this rectangle collides the rectangle in parameter
function Rectangle:ColR(rect)
  return MSoverlapping(self.c.x,self.c.x+self.s.x,rect.c.x,rect.c.x+rect.s.x) and MSoverlapping(self.c.y,self.c.y+self.s.y,rect.c.y,rect.c.y+rect.s.y)

end

function Rectangle:ColL(line)
  local n =line.direction:rotate90()
  self:findVertices()
  local dp1=n:dotProd(self.a:sub(l.base))
  local dp2=n:dotProd(self.b:sub(l.base))
  local dp3=n:dotProd(self.c:sub(l.base))
  local dp4=n:dotProd(self.d:sub(l.base))
  return dp1*dp2<=0 or dp2*dp3<=0 or dp3*dp4<=0
end


--[[Testcode
  require "MathStructs"
  l = Line(Vector(6, 8), Vector(2, -3))
  r = Rectangle(Vector(3, 2),Vector(6, 4))
  assert(r:ColL(l),"Rectangle Line Collision function error")
]]

function Rectangle:ColS(segment)
  if not Line(segment.startp,segment.endp:sub(segment.startp))then
    return false
  end
  if not Range(self.c.x,self.c.x+self.s.x):overlapping(Range(segment.startp.x,segment.endp.x))then
    return false
  end
  return Range(self.c.y,self.c.y+self.s.y):overlapping(Range(segment.startp.y,segment.endp.y))
end


--[[Testcode
  require "MathStructs"

  r = Rectangle(Vector(3, 2), Vector(6, 4))
  s = Segment(Vector(6, 8), Vector(10, 2))
  assert(r:ColS(s),"Segment Rectangle collision function issue")
  ]]

function Rectangle:Corner(num)
 return self:findVertices()[num%4]
end

function Rectangle:SepAxis(seg)
  local n= seg.startp:sub(seg.endp)
  local rA=Segment(self:Corner(0),self:Corner(1))
  local rB=Segment(self:Corner(2),self:Corner(3))
  local rea=rA:project(n)
  local reb=rB:project(n)
  local rProj=rea:hull(reb)
  arange=seg:project(n)
  return not rProj:hull(arange)
end



ORectangle = Class{}

-- center is a point or vector halfExtend is the vector between center and top right corner
function ORectangle:init(center,halfExtend,rotation)
  self.c=center
  self.he=halfExtend
  self.r=rotation
  --na serve for finding the points 1 and 3 as 2is center + he and 4 is center-he
end


function ORectangle:findVertices()
  --na serve for finding the points 1 and 3 as 2is center + he and 4 is center-he
  --here if na is already loaded in memory don't redo the heavy calculus
  if not self.na then
    self.na=self.he:rotate(-2*self.r)
  end
  if not self.v1 then
    self.v1=self.c:sub(self.na)
    self.v2=self.c:add(self.he)
    self.v3=self.c:add(self.na)
    self.v4=self.c:sub(self.he)
  end
  return { [0]=self.v1,[1]=self.v2,[2]=self.v3,[3]=self.v4}
end
--nr is the number of the edge wanted
function ORectangle:Edge(nr)
  local v=self:findVertices()
  return Segment(v[nr % 4],v[(nr+ 1) %4])
end

-- separating axis for oriented rectangle
function ORectangle:SepAxis(axis)
  local n=axis.startp:sub(axis.endp)
  local axisRange=axis:project(n)
  local Proj= self:Edge(0):project(n):hull(self:Edge(2):project(n))
  return not axisRange:overlapping(Proj)
end

--Oriented rectange to oriented rectangle collision
function ORectangle:ColOR(orec)
  local edge=self:Edge(0)
  if orec:SepAxis(edge) then
    return false
  end
  edge=self:Edge(1)
  if orec:SepAxis(edge) then
    return false
  end
end
--[[Testcode
  require "MathStructs"
  v1= Vector(3, 5)
  v2= Vector(1, 3)
  v3= Vector(10, 5)
  v4= Vector(2, 2)
  a = ORectangle(v1,v2,15)
  b = ORectangle(v3,v4, -15)
  assert(not a:ColOR(b),"Oriented rectangle collision issue");
]]

function ORectangle:ColC(cir)
  return Circle(cir.c:sub(self.c):add(self.he),cir.r):ColR(Rectangle(Vector(0,0),self.he:multiply(2)))
end

--[[Testcode
  require "MathStructs"
  r = ORectangle(Vector(5, 4),Vector(3, 2), 30)
  c = Circle(Vector(5, 7), 2)
  assert(r:ColC(c),"Oriented rectangle circle collision issue")
  ]]
