Polygon = Class{}

--Symple non crossand continuous polygon implementation
function Polygon:init(points)
  --vertice table must be indexed in 0
  self.vs=points
  self:length()
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

function Polygon:add(point,place)
  table.insert(self.points,point,place)
end

function Polygon:ColP(point)
  if not self:toCircle():ColP(point) then
    return false
  end
end

function Polygon:length()
  self.size = 0
  for key,val in self.vs do
    self.size=self.size+1
  end
end

--[[
function Polygon:Wn(point)
  local wn=0
  for i=0,self.size do
    local elem=self.vs[i]
    local nexte=self.vs[(i+1)%self.size]
    if elem.y <= point.y then
      if nexte.y > point.y then
        if(nexte:sub(elem):dotProd(point:sub(nexte)>0) then


end
]]
