
FloatThreshold= Range(-0.0001,0.0001)
function dumpstr(struct)
  dump="{ "
  for k,val in pairs(struct) do
    dump=dump..k.." : "..val.." ; "
  end
  return dump.." }"
end
