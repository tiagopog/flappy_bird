require 'ruby2d'

class Graphics
  class Pipe < Sprite
    def initialize(**attrs)
      super(
        'assets/images/game_sprite.png',
        width: 52,
        height: 250,
        x: attrs[:x],
        z: 1,
        clip_width: 52,
        clip_height: 250,
        clip_y: attrs[:position] == :top ? 715 : 646,
        clip_x: attrs[:position] == :top ? 112 : 168
      )
    end
  end
end
