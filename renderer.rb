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
        @frame.pixel(rendered_points[p][1], rendered_points[p][2])
      end
    end
    @frame.draw
  end

end
