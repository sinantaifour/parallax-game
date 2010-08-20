load 'matr.rb'
load 'camera.rb'
load 'frame.rb'
load 'obj.rb'
load 'renderer.rb'

dim = 200
frame = Frame.new(2 * dim, 2 * dim)

o = Obj.new(<<-BOX)
  (-1,1,-1)(1,1,-1)(1,1,1)(-1,1,1)
  (-1,-1,-1)(1,-1,-1)(1,-1,1)(-1,-1,1)
  (-1,1,-1)(-1,-1,-1)
  (1,1,-1)(1,-1,-1)
  (1,1,1)(1,-1,1)
  (-1,1,1)(-1,-1,1)
BOX

r = Renderer.new(nil, frame)
r.add_obj(o)

t = 0

while true

  povx = 5 * Math.cos(t)
  povy = 5 * Math.sin(t)

  pov = Point.new(povx, povy, 3, 1)
  poi = Point.new(0, 0, 0, 1)
  up = Point.new(0, 0, 1, 1)
  alpha = 30 / 180.0 * Math::PI
  c = Camera.new(pov, poi, up, alpha, 1)

  r.update_camera(c)
  r.draw

  t += 0.01

end
