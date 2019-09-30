require_relative './score/placeholder'

class Graphics
  class Score
    def initialize
      @placeholders = 3.times.map { Placeholder.new }
    end

    def update!(game)
      reset!
      score = game.score
      show_placeholders!(score)
      apply_score_digits!(score)
    end

    private

    def reset!
      @placeholders.each do |p|
        p.x = 132
        p.z = -9999
      end
    end

    def show_placeholders!(score)
      p1, p2, p3 = @placeholders

      if score < 10
        p1.z = 3
      elsif score < 100
        p1.x = 106

        p1.z = 3
        p2.z = 3
      else
        p1.x = 87
        p2.x = 106

        p1.z = 3
        p2.z = 3
        p3.z = 3
      end
    end

    def apply_score_digits!(score)
      p1, p2, p3 = @placeholders
      d1, d2, d3 = score.to_s.split('')

      p1.update!(d1) if d1
      p2.update!(d2) if d2
      p3.update!(d3) if d3
    end
  end
end
