module Graphics
  class Bird < Sprite
    def initialize(window:)
      super(
        'assets/images/game_sprite.png',
        width: 34,
        height: 24,
        x: 106,
        y: window.get(:height) / 2 - 12,
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
