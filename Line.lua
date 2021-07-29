
Line = Class{}

function Line:init(point,vec)
  self.base=point
  self.direction=vec
end

function Line:toSegment(size)
  local vec= self.direction:unit():multiply(size)
  return Segment(self.base.x+vec.x,self.base.y+vec.y)
end

function Line:equal(line)
  return self.base:eq(line.base) and self.direction:eq(line.direction)
end

function Line:equivalent(line)
  if not self.direction:parallel(line.direction) then
    return false
  end
  return self.direction:parallel(self.base:sub(line.base))
end

function Line:Lcol(line)
  if(self.direction:parallel(line.direction))then
    return self:equivalent(line)
  else
    return true
  end
end

--[[ Testcode
 require "MathStructs"
 a= Vector(3,5)
 b=Vector(3,2)
 c=Vector(8,4)
 down=Vector(5,-1)
 up=Vector(5,2)
 l1 = Line(a,down)
 l2 = Line(a,up)
 l3= Line(b,up)
 l4=Line(c,down)
 assert(l1:Lcol(l2), "Line collision failed")
 assert(l1:Lcol(l3), "Line collision failed")
 assert(not l2:Lcol(l3), "Line collision failed")
 assert(l1:Lcol(l4), "Line collision failed")
]]

function Line:toString()
  return "Line : { base "..self.base:toString().." , direction : "..self.direction:toString().." }\n"
end
