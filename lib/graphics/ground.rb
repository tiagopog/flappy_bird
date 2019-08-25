require 'ruby2d'

class Graphics
  class Ground < Sprite
    def initialize(x:)
      super(
        'assets/images/game_sprite.png',
        width: 288,
        height: 110,
        x: x,
        y: 430,
        z: 3,
        clip_width: 288,
        clip_height: 110,
        clip_x: 584,
      )
    end
  end
end
