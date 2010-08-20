load 'matr.rb'
load 'camera.rb'

require 'sdl'

SDL.init(SDL::INIT_VIDEO)
dim = 200
screen = SDL::Screen.open(2 * dim, 2 * dim,0,SDL::SWSURFACE)
color = screen.format.map_rgb(255,255,255)
black = screen.format.map_rgb(0, 0, 0)

povx = 0
povy = 0

while true
  while event = SDL::Event.poll
    case event
    when SDL::Event::Quit
      exit
    when SDL::Event::KeyDown
      exit if event.sym == SDL::Key::ESCAPE
    end
  end

  SDL::Key.scan
  povx -= 0.1 if SDL::Key.press?(SDL::Key::DOWN)
  povx += 0.1 if SDL::Key.press?(SDL::Key::UP)
  povy -= 0.1 if SDL::Key.press?(SDL::Key::LEFT)
  povy += 0.1 if SDL::Key.press?(SDL::Key::RIGHT)


  pov = Point.new(-15, povy, povx, 1)
  poi = Point.new(0, 0, 0, 1)
  up = Point.new(0, 0, 1, 1)
  alpha = 30 / 180.0 * Math::PI
  r = Camera.new(pov, poi, up, alpha, 1)
  ps = []
  ps << Point.new(1,1,1,1)
  ps << Point.new(1,1,-1,1)
  ps << Point.new(1,-1,1,1)
  ps << Point.new(1,-1,-1,1)
  ps << Point.new(-1,1,1,1)
  ps << Point.new(-1,1,-1,1)
  ps << Point.new(-1,-1,1,1)
  ps << Point.new(-1,-1,-1,1)

  screen.fill_rect(0, 0, 2 * dim, 2 * dim, black)

  ps.each_with_index do |po, i|
    temp = r.transform(po)
    screen.put_pixel(dim + temp[1] * dim, dim + temp[2] * dim, color)
  end


  screen.flip
end
