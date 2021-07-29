
Vertice = Vector

function Vertice:init(x,y)
  self.x=x
  self.y=y
end

function Vertice:toVec()
  return Vector(self.x,self.y)
end

function Vertice:distance(vert)
  return Segment(self,vert):length()
end

function Vertice:toString()
  return "Vertice "..dumpstr(self)
end


function Vertice:__eq(vertice)
  return self.x==vertice.x and vertice.y==self.y
end

Point = Vertice

function Point:toString()
  return "Point "..dumpstr(self)
end
