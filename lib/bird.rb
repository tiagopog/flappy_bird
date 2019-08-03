class Bird < Sprite
  attr_accessor :acceleration, :speed

  def initialize(window:, game:)
    @game = game
    @speed = 0
    @flight= 0
    @acceleration = 0

    super(
      'assets/images/game_sprite.png',
      width: 34,
      height: 24,
      x: 106,
      y: window.get(:height) / 2 - 25,
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

  def fly!
    self.acceleration = -3.5
    self.speed = 0
  end

  def move!
    if @game.started?
      self.acceleration += gravity if acceleration < gravity
      self.speed += acceleration
      self.y += speed
    end
  end

  private

  def gravity
    @game.gravity
  end
end

