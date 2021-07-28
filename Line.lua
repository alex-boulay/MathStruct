
Line = Class{}

function Line:init(point,vec)
  self.base=point
  self.direction=vec
end

function Line:toSegment(size)
  local vec= self.direction:unit():multiply(size)
  return Segment(self.base.x+vec.x,self.base.y+vec.y)
end

function Line:__eq()
end
