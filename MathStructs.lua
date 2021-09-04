
Class = require "class"

local parts ={
  "Line",
  "Quads",
  "Range",
  "Segment",
  "Triangle",
  "Vector",
  "Ray",
  "Rectangle",
  "Circle",
  "Polygon",
  "MathUtils"
}

if love~=nil then
  table.insert(parts,"MSLove2D")
end

local mathstructs= {}

for kay,val in pairs(parts)do
  table.insert(mathstructs,require(val))
end

return mathstructs
