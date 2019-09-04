class Logic
  attr_reader :objects

  def self.restart!(*objects)
    objects.map(&:restart!)
  end

  def self.collision?(char, objects)
    Array(objects).any? do |object|
      horizontal =
        char.x + char.width > object.x &&
          char.x < object.x + object.width

      vertical =
        object.y + object.height > char.y &&
          object.y < char.y + char.height

      if horizontal && vertical
      end
      horizontal && vertical
    end
  end

  def initialize
    @objects = {}
  end

  def add(key, logic)
    @objects[key] =logic
  end

  def [](key)
    @objects[key]
  end
end
