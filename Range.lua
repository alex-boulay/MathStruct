-- Definition of a range
Range = Class{}

function Range:init(a,b)
  self.min = math.min(a,b)
  self.max = math.max(a,b)
end

function Range:inside(x)
  return x=>self.min and x<=self.max
end

function Range:strictin(x)
  return x>self.min and x<self.max
end

function Range:overlapping(range)
  return range.min <= self.max and self.min <= range.max
end
