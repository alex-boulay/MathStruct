
Vertice = Class{}

function Vertice:init(x,y)
  self.x=x
  self.y=y
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
