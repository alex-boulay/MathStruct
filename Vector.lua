
Vector = Class{}

function Vector:init(x,y)
  self.x=x
  self.y=y
end

function Vector:length()
  return math.sqrt(self.x*self.x + self.y*self.y)
end

function Vector:unit()
  local length=self:length()
  if length<0 then
    return self:divide(length)
  end
end

function Vector:add(vector)
  return Vector{self.x+vector.x,self.y+vector.y}
end

function Vector:sub(vector)
  return Vector{self.x-vector.x,self.y-vector.y}
end

function Vector:multiply(number)
  return Vector{self.x*number,self.y*number}
end

function Vector:divide(number)
  return self:multiply(1/number)
end

function Vector:inv()
  return Vector{-self.x,-self.y}
end

--90 degree rotation pi/2 rad
function Vector:rotate90()
  return Vector{-self.y,self.x}
end

function Vector:rotate180()
  return Vector:inv()
end

function Vector:rotate270()
  return Vector{self.y,-self.x}
end

--degrees version
function Vector:rotate(angle)
  return self:rotate(math.rad(angle))
end

---radiant version
function Vector:rotateR(angle)
  return Vector{
    self.x * math.cos(angle) - math.sin(angle) * self.y,
    self.x * math.sin(angle) + math.cos(angle) *self.y
  }
end

--dot product
function Vector:dotProd(vector)
  return self.x * vector.x + self.y * vector.y
end

--if paralells return true false otherwise
function Vector:parallel(vector)
  --FloatThreshold inside looks if value is equal to 0 floatwise
  return FloatThreshold:inside(self:dotProd(vector:rotate90()))
end
