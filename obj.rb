# Represents an object in the scene to be rendered.
class Obj

  def initialize(txt = nil)
    @points = {}
    @point_ids = {}
    @edges = {}
    txt.split("\n").reject { |l| l.gsub(" ", "").empty?  }.each do |l|
      load_edge_from_string(l)
    end if txt
  end

  def add_edge(p1, p2)
    p1 = (@points[p1.hash] ||= p1)
    p2 = (@points[p2.hash] ||= p2)
    @point_ids[p1id = p1.object_id] = p1
    @point_ids[p2id = p1.object_id] = p2
    @edges[[p1id, p2id]] = true unless @edges[[p2id, p1id]] # For some reason hashes don't accept arrays of points as keys.
  end

  def load_edge_from_string(txt)
    points = []
    txt.gsub(/\((-?\d+\.?\d*),(-?\d+\.?\d*),(-?\d+\.?\d*)\)/) do |p|
      points << Point.new(*p.match(/\((-?\d+\.?\d*),(-?\d+\.?\d*),(-?\d+\.?\d*)\)/)[1..-1].map { |v| v.to_f }.push(1))
    end
    points.length.times { |i| add_edge(points[i], points[(i + 1) % points.length]) }
  end

end

