
--we will use 2vectors and they will represent points and vertice in 2dsapce too
Vector = Class{}

function Vector:init(x,y)
  self.x=x or 0
  self.y=y or 0
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

function Vector:toString()
  return "Vector "..dumpstr(self)
end

function Vector:add(vector)
  return Vector(self.x+vector.x,self.y+vector.y)
end

function Vector:sub(vector)
  return Vector(self.x-vector.x,self.y-vector.y)
end

function Vector:multiply(number)
  return Vector(self.x*number,self.y*number)
end

function Vector:divide(number)
  return self:multiply(1/number)
end

function Vector:inv()
  return Vector(-self.x,-self.y)
end

--90 degree rotation pi/2 rad
function Vector:rotate90()
  return Vector(-self.y,self.x)
end

function Vector:rotate180()
  return Vector:inv()
end

function Vector:rotate270()
  return Vector(self.y,-self.x)
end

--degrees version
function Vector:rotate(angle)
  return self:rotateR(math.rad(angle))
end

---radiant version
function Vector:rotateR(angle)
  return Vector(self.x * math.cos(angle) - math.sin(angle) * self.y,
    self.x * math.sin(angle) + math.cos(angle) *self.y)
end

--dot product
function Vector:dotProd(vec)
  return self.x * vec.x + self.y * vec.y
end

function Vector:toRange()
  return Range(self.x,self.y)
end
--if paralells return true false otherwise
function Vector:parallel(vector)
  --FloatThreshold inside looks if value is equal to 0 floatwise
  return self:dotProd(vector:rotate90())==0
end

function Vector:enclosed_angle(vect)
  return math.deg(math.acos(self:unit():dotProd(vect:unit())))
end

NullVec = Vector(0,0)
