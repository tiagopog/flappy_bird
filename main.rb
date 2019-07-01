require 'ruby2d'
require 'byebug'


set title: 'Flappy Bird',
  width: 640,
  height: 480,
  resizable: false,
  background: 'blue'

class Bird < Square
  attr_accessor :flying

  def initialize(flying: false, **args)
    super(args)
    @flying = flying
  end

  def flying!
    self.flying = true
  end

  def falling!
    self.flying = false
  end

  alias flying? flying
end

class Pipe < Rectangle
  attr_accessor :position

  def initialize(position: nil, **args)
    super(args.merge(width: 100))
    @position = position
  end
end

class PipeManager
  attr_reader :pipes

  def initialize(window:)
    @pipes = [
      [
        Pipe.new(position: :top, height: 200, x: 400),
        Pipe.new(position: :bottom, height: 50, x: 400, y: window.get(:height) - 50)
      ]
    ]
  end

  def move!
    pipes.each do |tuple|
      tuple.each do |pipe|
        pipe.x -= 1
      end
    end
  end
end

bird = Bird.new(
  size: 50,
  color: 'yellow',
  x: 30,
  y: get(:height) / 2 - 25,
)

pipe_manager = PipeManager.new(window: get(:window))

update do
  bird.y += 2
  pipe_manager.move!

  on :key_down do |event|
    if !bird.flying? && event.key == 'space'
      bird.flying!
      puts "fly!"
      bird.color = 'black'
      bird.y -= 50
    end
  end

  on :key_up do
    bird.color = 'yellow'
    bird.falling!
  end
end

show
