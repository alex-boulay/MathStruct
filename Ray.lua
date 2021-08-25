Ray = Class{}

function Ray:init(point,vec)
  self.base=point
  self.direction=vec
end

function Ray:type()
  return "Ray"
end
