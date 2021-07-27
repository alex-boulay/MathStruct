
Segment = Class{}

function Segment:init(startp,endp)
  self.startp=startp
  self.endp=endp
end

function Segment:length()
  return Vector(self.endp.y-self.startp.y,self.endp.x-self.startp.x):length()
end
function Segment:toLine()
  return Line{self.startp,self.endp:sub(self.startp):toVec()}
end

function Segment:project(vector)
  ontoU=vector:unit()
  return Range{ontoU:dotProd(self.startp),ontoU:dotProd(self.endp)}
end

function Segment:intersect(segment)

end

function Segment:collides(segment)
  local LineA, LineB
  LineA = self:toLine()
  if LineA:OnOneSide(segment) then
    return false
  end
  LineB = segment:toLine()
  if  LineB:OnOneSide(self) then
    return false
  end

end
function Segment:OnOneSide(axis)
  local d1 =axis.base:sub(self.startp)
  local d2 = axis.base:sub(self.endp)
  local n = axis.direction:rotate(90)
  return n:dotProd(d1)*n:dotProd(d2)>0
end

function Segment:project(vector)
  local onto=vector:unit()
end

function Segment:print()
  return "P1 : "+self.startp:print()+" | P2 : "+self.endp:print()+" ;\n"
end
