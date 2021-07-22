--[[
All the textbelow is a lua adaptation of
========================================
    2D Game Collision Detection
========================================

  Author: Thomas Schwarzl (aka hermitC)

  Book website: www.collisiondetection2d.net

  Author's game development blog: www.blackgolem.com


Lua adaption by Alexandre Boulay
alexandre.boulay59@gmail.com

]]
require "class"

local parts ={
  "Line",
  "MathUtils",
  "Quads",
  "Range",
  "Segment",
  "Triangle",
  "Vector",
  "Vertice"
}

local mathstructs= {}

for a in pairs(parts)do
  table.insert(mathstructs,require(a))
end
