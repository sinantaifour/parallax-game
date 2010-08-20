# Takes a camera, objects, and a frame, and allows drawing to the frame.
class Renderer

  def initialize(camera, frame)
    @camera = camera
    @frame = frame
    @objs = []
  end

  def add_obj(o)
    @objs << o
  end

  def update_camera(cam)
    @camera = cam
  end

  def draw
    @frame.clear
    @objs.each do |o|
      rendered_points = {}
      o.get_points.each do |p|
        rendered_points[p] = @camera.transform(p)
      end
      o.get_edges.each do |(p1, p2)|
        @frame.line(rendered_points[p1][1], rendered_points[p1][2], rendered_points[p2][1], rendered_points[p2][2])
      end
    end
    @frame.draw
  end

end
