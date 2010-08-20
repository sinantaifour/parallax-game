load 'matr.rb'
load 'camera.rb'
load 'frame.rb'
load 'obj.rb'

dim = 200
frame = Frame.new(2 * dim, 2 * dim)

povx = 0
povy = 0

while true

  pov = Point.new(-15, povy, povx, 1)
  poi = Point.new(0, 0, 0, 1)
  up = Point.new(0, 0, 1, 1)
  alpha = 30 / 180.0 * Math::PI
  r = Camera.new(pov, poi, up, alpha, 1)
  o = Obj.new(<<-BOX)
    (-1,1,-1)(1,1,-1)(1,1,1)(-1,1,1)
    (-1,-1,-1)(1,-1,-1)(1,-1,1)(-1,-1,1)
    (-1,1,-1)(-1,-1,-1)
    (1,1,-1)(1,-1,-1)
    (1,1,1)(1,-1,1)
    (-1,1,1)(-1,-1,1)
  BOX

  ps = o.instance_eval { @points }.values

  frame.clear

  ps.each_with_index do |po, i|
    temp = r.transform(po)
    frame.pixel(dim + temp[1] * dim, dim + temp[2] * dim)
  end

  frame.draw

  povx += 0.05

end
