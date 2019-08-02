class Bird < Sprite
  DEFAULTS = {
    displacement: { float: 10, flight: 40 },
    throttle: { float: 0.5, fly: 5, gravity: 2 }
  }.freeze

  attr_reader :throttle

  def initialize(window:)
    initial_floating!

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

  def move!
    case @status
    when :floating then float!
    when :flying   then fly!
    when :falling  then fall!
    end
  end

  def float!
    if @float.zero?
      @float = DEFAULTS[:displacement][:float]
      @float_direction *= -1
    end

    @float -= DEFAULTS[:throttle][:float]
    self.y += @float_direction * DEFAULTS[:throttle][:float]
  end

  def fly!
    unless flying?
      @status = :flying
      @flight = DEFAULTS[:displacement][:flight]
    end

    @flight -= DEFAULTS[:throttle][:fly]
    self.y -= DEFAULTS[:throttle][:fly]

    fall! if @flight <= 0
  end

  def fall!
    @status = :falling
    self.y += DEFAULTS[:throttle][:gravity]
  end

  def flying?
    @status == :flying
  end

  private

  def initial_floating!
    @status = :floating
    @float = 0
    @float_direction = -1
  end
end

