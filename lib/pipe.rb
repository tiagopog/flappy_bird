require 'ruby2d'

class Pipe < Sprite
  DEFAULTS = { width: 52, height: 250 }.freeze

  attr_accessor :position

  def initialize(position:, **options)
    @position = position

    super(
      'assets/images/game_sprite.png',
      width: DEFAULTS[:width],
      height: DEFAULTS[:height],
      x: options[:x],
      clip_width: DEFAULTS[:width],
      clip_height: DEFAULTS[:height],
      clip_y: position == :top ? 715 : 646,
      clip_x: position == :top ? 112 : 168
    )
  end
end

class PipeManager
  DEFAULTS = {
    distance: 117,
    throttle: 2,
    top_y: 0,
    bottom_y: 370,
    difficulty: { easy: 20, normal: 30, hard: 60 }
  }.freeze

  attr_accessor :difficulty
  attr_reader :pipes

  def initialize(window:, difficulty:)
    @window = window
    @difficulty = difficulty
    @pipes = [
      Pipe.new(position: :top, x: initial_x(:first)),
      Pipe.new(position: :bottom, x: initial_x(:first)),
      Pipe.new(position: :top, x: initial_x(:last)),
      Pipe.new(position: :bottom, x: initial_x(:last))
    ]

    randomize_pipes!
  end

  def move!
    grouped_pipes do |pipe, new_y|
      pipe.x -= DEFAULTS[:throttle]

      if gone?(pipe)
        pipe.x = initial_x
        pipe.y = new_y
      end
    end
  end

  private

  def vertical_offsets
    offset = DEFAULTS[:difficulty][difficulty]
    (-190..0).step(offset).map(&:itself)
  end

  def randomize_pipes!
    grouped_pipes do |pipe, new_y|
      pipe.y = new_y
    end
  end

  def gone?(pipe)
    pipe.x + pipe.width <= 0
  end

  def grouped_pipes
    pipes.each_slice(2) do |slice|
      offset = vertical_offsets.sample

      slice.each do |pipe|
        new_y = DEFAULTS[:"#{pipe.position}_y"] + offset
        yield(pipe, new_y)
      end
    end
  end

  def initial_x(nth = nil)
    if nth == :last
      @window.get(:width) + Pipe::DEFAULTS[:width] + DEFAULTS[:distance]
    else
      @window.get(:width)
    end
  end
end
