require 'ruby2d'
require 'byebug'


set title: 'Flappy Bird',
  width: 480,
  height: 640,
  resizable: false,
  background: 'blue'

class Game
  def self.collision?(char, objects)
    Array(objects).any? do |object|
      horizontal = char.x + char.width > object.x && char.x < object.x + object.width
      vertical = object.y + object.height > char.y && object.y < char.y + char.height
      horizontal && vertical
    end
  end

  def initialize
    @over = false
  end

  def over!
    @over = true
  end

  def over?
    @over
  end
end

class Bird < Rectangle
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
    args.merge!(color: 'green', width: 90)
    super(args)
    @position = position
  end
end

class Ground < Rectangle
  def initialize(**args)
    super(args)
  end
end

class PipeManager
  attr_reader :pipes, :window

  def initialize(window:)
    @window = window
    @pipes = [
      Pipe.new(position: :top, height: 200, x: window.get(:width) + 200),
      Pipe.new(position: :bottom, height: 50, x: window.get(:width) + 200, y: window.get(:height) - (80 + 50)),
      Pipe.new(position: :top, height: 100, x: window.get(:width) + 2 * 200 + 100),
      Pipe.new(position: :bottom, height: 150, x: window.get(:width) + (2 * 200) + 100, y: window.get(:height) - (80 + 150))
    ]
  end

  def move_pipes!
    pipes.each do |pipe|
      pipe.x -= 2
      pipe.x = window.get(:width) if pipe.x + pipe.width <= 0
    end
  end
end

game = Game.new

ground = Ground.new(
  color: 'brown',
  width: 480,
  height: 80,
  y: 640 - 80
)

bird = Bird.new(
  width: 58,
  height: 42,
  color: 'yellow',
  x: 30,
  y: get(:height) / 2 - 25,
)

pipe_manager = PipeManager.new(window: get(:window))

on :key_down do |event|
  if !bird.flying? && event.key == 'space'
    bird.flying!
    puts "fly!"
    bird.color = 'black'
    bird.y -= 45
  end
end

on :key_up do
  bird.color = 'yellow'
  bird.falling!
end

update do
  next if game.over?
  game.over! if Game.collision?(bird, [*pipe_manager.pipes, ground])
  bird.y += 2
  pipe_manager.move_pipes!
end

show
