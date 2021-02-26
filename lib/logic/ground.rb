# frozen_string_literal: true

require_relative './base_logic'

class Logic
  class Ground < BaseLogic
    def initialize
      super(width: 288, height: 110, y: 430)
    end
  end

  class GroundManager
    def initialize
      @grounds = { first: Ground.new, last: Ground.new }
      reset!
    end

    def reset!
      grounds(:first).x = 0
      grounds(:last).x = 288
    end

    def grounds(*keys)
      return @grounds.values if keys.empty?

      @grounds.dig(*keys)
    end

    def move!
      grounds.each do |ground|
        ground.x -= 1
        ground.x = ground.width if ground.width + ground.x <= 0
      end
    end
  end
end
