class Bird < Sprite
  DEFAULTS = {
    displacement: 40,
    throttle: { fly: 5, gravity:  2 }
  }.freeze

  attr_reader :throttle, :flying

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

  def move!
    flying? ? fly! : fall!
  end

  def fly!
    unless flying?
      @flying = true
      @displacement = DEFAULTS[:displacement]
    end

    @displacement -= DEFAULTS[:throttle][:fly]
    self.y -= DEFAULTS[:throttle][:fly]

    fall! if @displacement <= 0
  end

  def fall!
    @flying = false
    self.y += DEFAULTS[:throttle][:gravity]
  end

  alias flying? flying
end

