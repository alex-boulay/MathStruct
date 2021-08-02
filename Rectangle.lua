
Rectangle = Class{}

-- rectangle parallel to x and y axis oriented by an angle
function Rectangle:init(origin,size)
  self.c=origin --origin is the botom left point
  self.s=size
end

function Rectangle:findVertices()
  self.a=Vector(self.c.x,self.c.y+self.s.x) --top left vertice
  self.b=Vector(self.c.x+self.s.x,self.a.y) --top right vertice
  self.d=Vector(self.c.x,self.b.y)
end

-- return true if this rectangle collides the rectangle in parameter
function Rectangle:RectCol(rect)
  return MSoverlapping(self.c.x,self.c.x+self.s.x,rect.c.x,rect.c.x+rect.s.x) and MSoverlapping(self.c.y,self.c.y+self.s.y,rect.c.y,rect.c.y+rect.s.y)

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
  return { [0]= self.c:sub(self.na),
   [1]=self.c:add(self.he),
   [2]=self.c:add(self.na),
   [3]=self.c:sub(self.he)}
end
--nr is the number of the edge wanted
function ORectangle:Edge(nr)
  local v=self:findVertices()
  local n = nr % 4
  local n1= (nr+ 1) %4
  return Segment(v[n],v[n1])
end

-- separating axis for oriented rectangle
function ORectangle:SepAxis(axis)
  local n=axis.startp:sub(axis.endp)
  local axisRange=axis:project(n)
  local Proj= self:Edge(0):project(n):hull(self:Edge(2):project(n))
  return not axisRange:overlapping(axisRange)
end

--Oriented rectange to oriented rectangle collision
function ORectangle:ORectCol(orec)
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
  assert(not a:ORectCol(b),"Oriented rectangle collision issue");
]]

function ORectangle:ColC(circle)
