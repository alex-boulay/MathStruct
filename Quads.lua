Quad = Class{}

function Quad:init(vertices)
  self.v1=vertices[1]
  self.v2=vertices[2]
  self.v3=vertices[3]

  self.width=self.v2.x-self.v1.x
  self.height=self.v3.y-self.v1.y
  self.v3= Vertice{self.v1.x+self.width,self.v1.y+self.height}
end

function Quad:getVertices()
  return {self.v1,self.v2,self.v3,self.v4}
end


function Quad:collides(Segment)

end

function Quad:intersections(line)
  local norm= line.direction:rotate90()

end
--[[
]]
function Quad:intersect(point,angle)

end

function Quad:Draw(Canvas)


end

Square= Class{}

function Square:init(vertice,size)
  self.v1=vertice
  self.v2=Vertice(self.v1.x+size,self.v1.y)
  self.v3=Vertice(self.v1.x,self.v1.y+size)
  self.v4=Vertice(self.v2.x,self.v3.y)
  self.width=size
  self.height=self.width
end

function Square:getVertices()
  return {self.v1,self.v2,self.v3,self.v4}
end

function Square:toRectangle()
  return Rectangle{self.v1,self.v2,self.v3}
end

function Square:Draw(Canvas)

end
