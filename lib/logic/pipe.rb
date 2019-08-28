require 'ruby2d'

class Logic
  class Pipe < BaseLogic
    DEFAULTS = { width: 52, height: 250 }.freeze

    attr_accessor :position

    def initialize(**attrs)
      super(width: 52, height: 250, x: attrs[:x], y: attrs[:y])
      @position = attrs[:position]
      @scored = false
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

    def initialize(window:, game:)
      @window = window
      @game = game
      @pipes = {
        first: {
          top: Pipe.new(position: :top, x: initial_x(:first)),
          bottom: Pipe.new(position: :bottom, x: initial_x(:first))
        },
        last: {
          top: Pipe.new(position: :top, x: initial_x(:last)),
          bottom: Pipe.new(position: :bottom, x: initial_x(:last))
        }
      }

      randomize_pipes!
    end

    def pipes(*keys)
      if keys.empty?
        @pipes.values.flat_map(&:values)
      else
        @pipes.dig(*keys)
      end
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
      @pipes.values.each do |group|
        offset = vertical_offsets.sample

        group.values.each do |pipe|
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
end
