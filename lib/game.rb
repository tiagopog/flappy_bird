class Game
  attr_reader :over, :paused

  def self.collision?(char, objects)
    Array(objects).any? do |object|
      horizontal = char.x + char.width > object.x && char.x < object.x + object.width
      vertical = object.y + object.height > char.y && object.y < char.y + char.height
      horizontal && vertical
    end
  end

  def initialize
    @over = false
    @paused = false
  end

  def over!
    @over = true
  end

  alias over? over

  def pause!
    @paused = !paused?
  end

  alias paused? paused
end
