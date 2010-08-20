# Interface to drawing surface

require 'sdl'

SDL.init(SDL::INIT_VIDEO)

class Frame

  def initialize(width, height)
    @width, @height = width, height
    @screen = SDL::Screen.open(@width, @height, 0, SDL::SWSURFACE)
    @white = @screen.format.map_rgb(255,255,255)
    @black = @screen.format.map_rgb(0, 0, 0)
  end

  def pixel(x ,y)
    @screen.put_pixel(x, y, @white)
  end

  def clear
    @screen.fill_rect(0, 0, @width, @height, @black)
  end

  def draw
    @screen.flip
  end

end
