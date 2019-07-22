require 'ruby2d'

class Pipe < Sprite
  DEFAULTS = { width: 52, height: 250 }.freeze

  attr_accessor :position

  def initialize(position:, x:, y:)
    @position = position

    super(
      'assets/images/game_sprite.png',
      width: DEFAULTS[:width],
      height: DEFAULTS[:height],
      x: x,
      y: y,
      clip_width: DEFAULTS[:width],
      clip_height: DEFAULTS[:height],
      clip_y: position == :top ? 715 : 646,
      clip_x: position == :top ? 112 : 168
    )
  end
end

class PipeManager
  DEFAULTS = { distance: 182, throttle: 2 }.freeze

  attr_reader :pipes

  def initialize(window:)
    @window = window
    @pipes = [
      Pipe.new(
        position: :top,
        x: @window.get(:width),
        y: 0
      ),
      Pipe.new(
        position: :bottom,
        x: @window.get(:width),
        y: 370
      ),
      Pipe.new(
        position: :top,
        x: @window.get(:width) + Pipe::DEFAULTS[:width] + DEFAULTS[:distance],
        y: 0
      ),
      Pipe.new(
        position: :bottom,
        x: @window.get(:width) + Pipe::DEFAULTS[:width] + DEFAULTS[:distance],
        y: 370
      )
    ]
  end

  def move!
    pipes.each do |pipe|
      pipe.x -= DEFAULTS[:throttle]
      if pipe.x + pipe.width <= 0
        pipe.x = @window.get(:width) + DEFAULTS[:distance] - Pipe::DEFAULTS[:width]
      end
    end
  end
end
