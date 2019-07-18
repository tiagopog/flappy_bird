class Bird < Rectangle
  attr_accessor :flying

  def initialize(window:)
    @flying = false

    super(
      width: 58,
      height: 42,
      x: 30,
      y: window.get(:height) / 2 - 25,
      color: 'yellow'
    )
  end

  def fly!
    return if flying?
    self.flying = true
    self.y -= 45
  end

  def fall!
    self.y += 2
    self.flying = false
  end

  alias flying? flying
end

