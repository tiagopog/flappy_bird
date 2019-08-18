module Logic
  class BaseLogic
    attr_reader :game
    attr_accessor :width, :height, :x, :y

    def initialize(**attrs)
      @game = attrs[:game]
      @width = attrs[:width]
      @height = attrs[:height]
      @x = attrs[:x]
      @y = attrs[:y]
    end

    def started?
      @game.started?
    end

    def gravity
      @game.gravity
    end
  end
end
