--[[
Some of the textbelow is a lua adaptation of
========================================
    2D Game Collision Detection
========================================
Author: Thomas Schwarzl (aka hermitC)
Book website: www.collisiondetection2d.net
Author's game development blog: www.blackgolem.com

Some other parts are adaptation from different sources
->Practical Geometry Algorithms. by Daniel Sunday PhD
(parts on segment rays and polygons)

->Graphics Gems I, II, III, IV


Lua adaption by Alexandre Boulay
alexandre.boulay59@gmail.com

]]
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
