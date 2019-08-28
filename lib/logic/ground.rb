require_relative './base_logic'

class Logic
  class Ground < BaseLogic
    def initialize(x:)
      super(
        width: 288,
        height: 110,
        x: x,
        y: 430
      )
    end
  end

  class GroundManager
    def initialize
      @grounds = {
        first: Ground.new(x: 0),
        last: Ground.new(x: 288)
      }
    end

    def grounds(*keys)
      return @grounds.values if keys.empty?
      @grounds.dig(*keys)
    end

    def move!
      grounds.each do |ground|
        ground.x -= 1
        if ground.width + ground.x <= 0
          ground.x = ground.width
        end
      end
    end
  end
end
