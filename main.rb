load 'matr.rb'
load 'camera.rb'
load 'frame.rb'
load 'obj.rb'
load 'renderer.rb'

dim = 200
frame = Frame.new(2 * dim, 2 * dim)

povx = 0
povy = 0

while true

  pov = Point.new(-15, povy, povx, 1)
  poi = Point.new(0, 0, 0, 1)
  up = Point.new(0, 0, 1, 1)
  alpha = 30 / 180.0 * Math::PI
  c = Camera.new(pov, poi, up, alpha, 1)
  o = Obj.new(<<-BOX)
    (-1,1,-1)(1,1,-1)(1,1,1)(-1,1,1)
    (-1,-1,-1)(1,-1,-1)(1,-1,1)(-1,-1,1)
    (-1,1,-1)(-1,-1,-1)
    (1,1,-1)(1,-1,-1)
    (1,1,1)(1,-1,1)
    (-1,1,1)(-1,-1,1)
  BOX

  r = Renderer.new(c, frame)
  r.add_obj(o)
  r.draw



  povx += 0.05

end
