require 'ruby2d'

class Pipe < Rectangle
  attr_accessor :position

  def initialize(position: nil, **args)
    @position = position
    super(args.merge(color: 'green', width: 90))
  end
end

class PipeManager
  attr_reader :pipes

  def initialize(window:)
    @window = window
    @pipes = [
      Pipe.new(position: :top, height: 200, x: @window.get(:width) + 200),
      Pipe.new(position: :bottom, height: 50, x: @window.get(:width) + 200, y: @window.get(:height) - (80 + 50)),
      # Pipe.new(position: :top, height: 100, x: window.get(:width) + 2 * 200 + 100),
      # Pipe.new(position: :bottom, height: 150, x: window.get(:width) + (2 * 200) + 100, y: window.get(:height) - (80 + 150))
    ]
  end

  def move!
    pipes.each do |pipe|
      pipe.x -= 2
      pipe.x = @window.get(:width) if pipe.x + pipe.width <= 0
    end
  end
end
