--[[
This File is to facilitate Love2D calls like Drawings

]]
function Rectangle:Draw(mode)
  love.graphics.rectangle(mode or "fill",self.c.x,self.c.y,self.s.x,self.s.y)
end


function Circle:Draw()
  love.graphics.circle("line",self.c.x,self.c.y,self.r)
end

function Vector:Draw()
  love.graphics.points(self.x,self.y)
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

function Polygon:Draw()
  local n={}
  if self.size >= 3 then
    for k,val in pairs(self.vs) do
      table.insert(n,val.x)
      table.insert(n,val.y)
    end
    love.graphics.polygon("fill",n)
  end
end

function Ray:Draw()
  Segment(self.b,self.b:add(self.d)):Draw()
end
