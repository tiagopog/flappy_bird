class Bird < Sprite
  attr_accessor :flying

  def initialize(window:)
    @flying = false

    super(
      'assets/images/game_sprite.png',
      width: 34,
      height: 24,
      x: 30,
      y: window.get(:height) / 2 - 25,
      clip_width: 34,
      clip_height: 24,
      clip_x: 6,
      clip_y: 982
    )
  end

  def fly!
    return if flying?
    self.flying = true
    self.y -= 50
  end

  def fall!
    self.y += 2
    self.flying = false
  end

  alias flying? flying
end

