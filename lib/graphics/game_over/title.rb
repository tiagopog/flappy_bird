require 'ruby2d'
class Graphics
  class GameOver
    class Title < Sprite
      def initialize
        super(
          'assets/images/game_sprite.png',
          width: 202,
          height: 52,
          y: 111,
          x: 48,
          z: -9999,
          clip_width: 202,
          clip_height: 52,
          clip_x: 786,
          clip_y: 118
        )
      end

      def hide!
        self.z = -9999
      end

      def show!
        self.z = 3
      end
    end
  end
end
