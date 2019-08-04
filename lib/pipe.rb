require 'ruby2d'

class Pipe < Sprite
  DEFAULTS = { width: 52, height: 250 }.freeze

  attr_accessor :position

  def initialize(position:, **options)
    @position = position
    @scored = false

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

  def top?
    position == :top
  end

  def score!
    @scored = true
  end

  def unscore!
    @scored = false
  end

  def unscored?
    @scored == false
  end
end

class PipeManager
  DEFAULTS = {
    top_y: 0,
    bottom_y: 370,
    distance: 117,
    acceleration: { easy: 2, normal: 2, hard: 3 },
    offset_step: { easy: 20, normal: 30, hard: 60 }
  }.freeze

  attr_reader :pipes

  def initialize(window:, game:)
    @window = window
    @game = game
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
      pipe.x -= DEFAULTS[:acceleration][difficulty]

      if gone?(pipe)
        pipe.x = initial_x
        pipe.y = new_y
        pipe.unscore!
      end
    end
  end

  private

  def difficulty
    @game.difficulty
  end

  def vertical_offsets
    step = DEFAULTS[:offset_step][difficulty]
    (-190..0).step(step).map(&:itself)
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
