require 'ruby2d'

class Graphics
  class ScorePlaceholder < Sprite
    NUMBER = {
      '0' => { x: 992, y: 120 },
      '1' => { x: 271, y: 910 },
      '2' => { x: 584, y: 320 },
      '3' => { x: 612, y: 320 },
      '4' => { x: 640, y: 320 },
      '5' => { x: 668, y: 320 },
      '6' => { x: 584, y: 368 },
      '7' => { x: 612, y: 368 },
      '8' => { x: 640, y: 368 },
      '9' => { x: 668, y: 368 }
    }.freeze

    def initialize
      super(
        'assets/images/game_sprite.png',
        width: 24,
        height: 36,
        y: 40,
        x: 132,
        z: -9999,
        clip_width: 24,
        clip_height: 36,
        clip_x: NUMBER['0'][:x],
        clip_y: NUMBER['0'][:y]
      )
    end

    def update!(number)
      key = number.to_s
      self.clip_x = NUMBER[key][:x]
      self.clip_y = NUMBER[key][:y]
    end
  end

  class Score
    def initialize
      @placeholders = 3.times.map { ScorePlaceholder.new }
    end

    def update!(game)
      reset!
      score = game.score
      display_placeholders!(score)
      apply_score_digits!(score)
    end

    private

    def reset!
      @placeholders.each do |p|
        p.x = 132
        p.z = -9999
      end
    end

    def display_placeholders!(score)
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
      d1, d2, d3 = score.to_s.split("")

      p1.update!(d1) if d1
      p2.update!(d2) if d2
      p3.update!(d3) if d3
    end
  end
end
