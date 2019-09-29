require 'ruby2d'

class Graphics
  class Score
    class Placeholder < Sprite
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
          x: 132, z: -9999,
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
  end
end
