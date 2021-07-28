
Vertice = Class{}

function Vertice:init(n,a)
  if type(n)=="table" then
    self.x=n.x or 0
    self.y=n.y or 0
  else
    self.x=n or 0
    self.y=a or 0
  end
end

function Vertice:add(p)
  return Vertice{self.x+p.x,self.y+p.y}
end

function Vertice:sub(p)
  return Vertice{self.x-p.x,self.y-p.y}
end

function Vertice:toVec()
  return Vector{self.x,self.y}
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
  return "Point "..self:dumpstr(self)
end
