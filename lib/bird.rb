class Bird < Sprite
  attr_reader :acceleration, :speed

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
    @acceleration = -3.5
    @speed = 0
  end

  def move!
    @game.started? ? apply_gravity! : float!
    self.y += @speed
  end

  private

  # Ensure decelerating the bird flight with gravity.
  # If resulting acceleration get to the gravity level
  # ensure not to overflow it.
  def apply_gravity!
    @acceleration += gravity if @acceleration < gravity
    @speed += @acceleration
  end

  def float!
    @init_y ||= self.y
    @speed = 0.4 if @speed.zero?
    @speed *= -1 if (self.y - @init_y).abs >= 5
  end

  def gravity
    @game.gravity
  end
end
