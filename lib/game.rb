class Game
  attr_reader :started, :over, :paused, :difficulty, :gravity

  def self.collision?(char, objects)
    Array(objects).any? do |object|
      horizontal =
        char.x + char.width > object.x &&
          char.x < object.x + object.width

      vertical =
        object.y + object.height > char.y &&
          object.y < char.y + char.height

      horizontal && vertical
    end
  end

  def initialize(attrs = {})
    @started = false
    @over = false
    @paused = false
    @difficulty = attrs[:difficulty] || :normal
    @gravity = attrs[:gravity] || 0.7
  end

  def started!
    @started ||= true
  end

  alias started? started

  def over!
    @over = true
  end

  alias over? over

  def pause!
    @paused = !paused?
  end

  alias paused? paused
end
