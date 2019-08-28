class Logic
  class Game
    attr_reader :started, :over, :paused, :difficulty, :gravity, :score

    def initialize(attrs = {})
      @started = false
      @over = false
      @paused = false
      @difficulty = attrs[:difficulty] || :normal
      @gravity = attrs[:gravity] || 0.7
      @score = 0
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

    def score!
      @score += 1
    end

    def check_score!(bird, pipes)
      result = pipes
        .lazy
        .select(&:top?)
        .select(&:unscored?)
        .select { |pipe| bird.x >= pipe.x && bird.x <= pipe.x + pipe.width }
        .first

      result && score! && result.score!
    end
  end
end
