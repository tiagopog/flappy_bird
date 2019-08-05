module Logic
  class BaseLogic
    attr_reader :game
    attr_accessor :width, :height, :x, :y

    def initialize(game:, graphics:)
      @game = game
      @width = graphics.width
      @height = graphics.height
      @x = graphics.x
      @y = graphics.y
    end

    def started?
      @game.started?
    end

    def gravity
      @game.gravity
    end
  end
end
