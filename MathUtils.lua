
FloatThreshold= Range(-0.0001,0.0001)


function dumpstr(struct)
  dump="{ "
  for k,val in pairs(struct) do
    local str=""
    if type(val)=="table" then
      str=dumpstr(val)
    else
      str=val
    end
    dump=dump..k.." : "..str.." ; "
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

function MSclamp(x,min,max)
  if x<min then
    return min
  elseif x>max then
    return max
  else
    return x
  end
end
