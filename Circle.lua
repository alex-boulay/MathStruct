Circle = Class{}

function Circle:init(center,radius)
  self.c=center
  self.r=radius
end

--collision with another circle
function Circle:CollideC(circle)
  return Segment(self.c,circle.c)<=(self.r+circle.r)
end

Disc = Class{}

function Disc:init(center,rad1,rad2)
  self.c=center
  self.r1=min(rad1,rad2)
  self.r2=max(rad1,rad2)
end
