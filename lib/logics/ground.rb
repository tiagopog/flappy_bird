require_relative './base_logic'

class Logics
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
    attr_reader :grounds

    def initialize
      @grounds = {
        head: Ground.new(x: 0),
        tails: Ground.new(x: 288)
      }
    end

    def head_ground
      grounds[:head]
    end

    def tail_ground
      grounds[:tail]
    end

    def move!
      grounds.each do |_id, ground|
        ground.x -= 1
        if ground.width + ground.x <= 0
          ground.x = ground.width
        end
      end
    end
  end
end
