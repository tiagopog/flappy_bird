require 'ruby2d'

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

class GroundManager
  attr_reader :grounds

  def initialize
    @grounds =[
      Ground.new(x: 0),
      Ground.new(x: 288)
    ]
  end

  def move!
    grounds.each do |ground|
      ground.x -= 1
      if ground.clip_width + ground.x <= 0
        ground.x = ground.clip_width
      end
    end
  end
end
