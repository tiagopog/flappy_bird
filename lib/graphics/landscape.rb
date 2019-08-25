require 'ruby2d'

class Graphics
  class Landscape < Sprite
    def initialize(window:)
      super(
        'assets/images/game_sprite.png',
        z: 0,
        clip_width: window.get(:width),
        clip_height: window.get(:height)
      )
    end
  end
end
