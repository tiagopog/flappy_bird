require 'ruby2d'

class Pipe < Sprite
  attr_accessor :position

  def initialize(position:, x:, y:)
    @position = position

    super(
      'assets/images/game_sprite.png',
      width: 52,
      height: 250,
      x: x,
      y: y,
      clip_width: 52,
      clip_height: 250,
      clip_y: position == :top ? 715 : 646,
      clip_x: position == :top ? 112 : 168
    )
  end
end

class PipeManager
  attr_reader :pipes

  def initialize(window:)
    @window = window
    @pipes = [
      Pipe.new(
        position: :top,
        x: @window.get(:width) + 200,
        y: 0
      ),
      Pipe.new(
        position: :bottom,
        x: @window.get(:width) + 200,
        y: 370
      )
    ]
  end

  def move!
    pipes.each do |pipe|
      pipe.x -= 2
      pipe.x = @window.get(:width) if pipe.x + pipe.width <= 0
    end
  end
end
