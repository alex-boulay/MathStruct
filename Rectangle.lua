
Rectangle = Class{}

-- rectangle parallel to x and y axis oriented by an angle
function Rectangle:init(origin,size)
  self.c=origin --origin is the botom left point
  self.s=size
  --self:findVertices()
end

function Rectangle:findVertices()
  self.a=Vertice(self.c.x,self.c.y+self.s.x) --top left vertice
  self.b=Vertice(self.c.x+self.s.x,self.a.y) --top right vertice
  self.d=Vertice(self.c.x,self.b.y)
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
end
