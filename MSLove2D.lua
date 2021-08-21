--[[
This File is to facilitate Love2D calls like Drawings

]]
function Rectangle:Draw()
  for i =0,4 do
    self:Edge(i):Draw()
  end
end


function Circle:Draw()
  love.graphics.circle("line",self.c.x,self.c.y,self.r)
end

function Vector:Draw()
  love.graphics.point(self.x,self.y)
end

--[[Collision to border has to be done to print a line
which is a segment going one side to the other
function Line:Draw()

end]]

function Segment:Draw()
  love.graphics.line(self.startp.x,self.startp.y,self.endp.x,self.endp.y)
end

function ORectangle:Draw()
  for i =0,4 do
    self:Edge(i):Draw()
  end
end
