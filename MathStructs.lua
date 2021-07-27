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
Class = require "class"

local parts ={
  "Line",
  "Quads",
  "Range",
  "Segment",
  "Triangle",
  "Vector",
  "MathUtils",
  "Vertice"
}

local mathstructs= {}

for kay,val in pairs(parts)do
  table.insert(mathstructs,require(val))
end
