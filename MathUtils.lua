
FloatThreshold= Range(-0.0001,0.0001)


function dumpstr(struct)
  dump="{ "
  for k,val in pairs(struct) do
    dump=dump..k.." : "..val.." ; "
  end
  return dump.." }"
end

function MSnorm(a,b)
  return math.sqrt(a*a + b*b)
end

function MSdistance(point1,point2)
  return MSnorm(point2.x-point1.x,point2.y-point1.y)
end

function MSoverlapping(min1,max1,min2,max2)
  return min2 <= max1 and min1<= max2
end
