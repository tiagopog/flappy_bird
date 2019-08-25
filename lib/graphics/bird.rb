require 'ruby2d'

class Graphics
  class Bird < Sprite
    def initialize
      super(
        'assets/images/game_sprite.png',
        width: 34,
        height: 24,
        z: 2,
        clip_width: 34,
        clip_height: 24,
        animations: {
          floating: [
            { x: 6, y: 982, width: 34, height: 24, time: 300 },
            { x: 62, y: 982, width: 34, height: 24, time: 300 },
            { x: 118, y: 982, width: 34, height: 24, time: 300 }
          ]
        }
      )

      play(animation: :floating, loop: true)
    end
  end
end
