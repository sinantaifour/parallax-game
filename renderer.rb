# Built for parameters of a camera, maps points from the scene to their place on the frame.
class Renderer

  def initialize(pov, poi, up, alpha, r)
    @pov, @poi, @up = pov, poi, up
    @coefx = 1 / Math.tan(alpha)
    @coefy = r / Math.tan(alpha)
    # Find t1
    pov = @pov
    t1 = Matr.new(4, 4, [[1, 0, 0, -pov[1]],
                         [0, 1, 0, -pov[2]],
                         [0, 0, 1, -pov[3]],
                         [0, 0, 0, 1      ]])
    # Find t2a
    poi = t1 * @poi
    r1 = (poi[1] * poi[1] + poi[3] * poi[3]) ** 0.5
    t2a = Matr.new(4, 4, [[poi[1]/r1,  0, poi[3]/r1, 0],
                          [0,          1, 0,         0],
                          [-poi[3]/r1, 0, poi[1]/r1, 0],
                          [0,          0, 0,         1]])
    # Find t2b
    poi = t2a * (t1 * @poi)
    r = (poi[1] * poi[1] + poi[2] * poi[2]) ** 0.5
    t2b = Matr.new(4, 4, [[poi[1]/r,  poi[2]/r, 0, 0],
                          [-poi[2]/r, poi[1]/r, 0, 0],
                          [0,         0,        1, 0],
                          [0,         0,        0, 1]])
    # Find t3
    up = t2b * (t2a * (t1 * @up))
    r = (up[2] * up[2] + up[3] * up[3]) ** 0.5
    t3 = Matr.new(4, 4, [[1, 0,       0,        0],
                         [0, up[3]/r, -up[2]/r, 0],
                         [0, up[2]/r, up[3]/r,  0],
                         [0, 0,       0,        1]])
    # Multiply into one big transformation matrix
    @t = t3 * (t2b * (t2a * t1))
  end

  def transform(p)
    temp = @t * p
    Point.new(@coefx * temp[2] / temp[1], @coefy * temp[3] / temp[1], 1)
  end

end
