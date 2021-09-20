Polygon = Class{}

--Symple non crossand continuous polygon implementation
function Polygon:init(points)
  self.vs={}
  self:length()
  for key, val in pairs(points) do
    if val.x~=nil and val.y~=nil then
      self.vs[self.size]=val
      self.size=self.size+1
    end
  end
end

function Polygon:toString()
  local str="Polygon :\n"
  for k,v in ipairs(self.vs) do
    str=str..'\t'..v:toString()
  end
  return str
end

function Polygon:toCircle()
  local dist = 0
  local p1
  local p2
  local tmp
  for k1,v1 in pairs(self.vs) do
    for k2,v2 in pairs(self.vs) do
      tmp=v1:distperf(v2)
      if tmp > dist then
        dist=tmp
        p1=v1
        p2=v2
      end
    end
  end
  tmp=p2:sub(p1):divide(2)
  return Circle(p1:add(tmp),math.sqrt(dist))
end

function Polygon:toRectangle()
  local max=Vector(self.vs[0].x,self.vs[0].y)
  local min=Vector(self.vs[0].x,self.vs[0].y)
  for key,val in ipairs(self.vs) do
    if val.x>max.x then
      max.x=val.x
    end
    if val.y>max.y then
      max.y=val.y
    end
    if val.x<min.x then
      min.x=val.x
    end
    if val.y<min.y then
      min.y=val.y
    end
  end
  return Rectangle(min,max:sub(min))
end

function Polygon:type()
  return "Polygon"
end

function Polygon:add(point)
  if point.x~=nil and point.y~=nil then
    table.insert(self.vs,point)
    self.size=self.size+1
  end
end

function Polygon:length()
  self.size = 0
  for key,val in pairs(self.vs) do
    self.size=self.size+1
  end
end


function Polygon:Wn(point)
  local wn=0
  for i=0,self.size-1 do
    local elem=self.vs[i]
    local nexte=self.vs[(i+1)%self.size]
    if elem.y <= point.y then
      if nexte.y > point.y then
        if nexte:sub(elem):Perp(point:sub(nexte))> 0 then
          wn=wn+1
        end
      end
    else
      if nexte.y<=point.y then
        if nexte:sub(elem):Perp(point:sub(nexte))<0 then
          wn=wn-1
        end
      end
    end
  end
  return wn
end


function Polygon:ColP(point)
  if not self:toRectangle():ColP(point) then
    return false
  end
  return self:Wn(point) ~= 0
end

--[[ Tests ColP
require "MathStructs"
pa = Vector(-9,5)
pb = Vector(-5,6)
pc = Vector(-5,2)
pd = Vector(-1,2)
pe = Vector(1,5)
pf = Vector(4,5)
pg = Vector(-4,-7)
ph = Vector(-4,-2)
pi = Vector(-3,3)
pol = Polygon{pa,pb,pc,pd,pe,pf,pg}
assert(pol:ColP(ph),"Collision function polygon point issue")
assert(not pol:ColP(pi),"Collision function polygon point issue")
]]

function Polygon:offset(x,y)
  for k,val in pairs(self.vs)do
    self.vs[k]= Vector(val.x+x,val.y+y)
  end
end
