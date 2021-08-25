Polygon = Class{}

--Symple non crossand continuous polygon implementation
function Polygon:init(points)
  --vertice table
  self.vs=points
end

function Polygon:toCircle()
  local dist = 0
  local p1
  local p2
  local tmp
  for k1,v1 in pairs(self.vs) do
    for k2,v2 in pairs(self.cs) do
      tmp=v1:distperf(v2)
      if temp> dist then
        dist=tmp
        p1=v1
        p2=v2
      end
    end
    return Circle(Vector(v1:add(v1:sub(v2):divide(2))),math.sqrt(dist))
  end

end

function Polygon:type()
  return "Polygon"
end

function Polygon:ColP(point)
  if not self:toCircle():ColP(point) then
    return false
  end

end
