# frozen_string_literal: true

class Logic
  attr_reader :objects

  class << self
    def reset!(*objects)
      objects.map(&:reset!)
    end

    def collision?(char, objects)
      Array(objects).any? do |object|
        horizontal_overlap(char, object) &&
          vertical_overlap(char, object)
      end
    end

    private

    def horizontal_overlap(char, object)
      char.x + char.width > object.x &&
        char.x < object.x + object.width
    end

    def vertical_overlap(char, object)
      object.y + object.height > char.y &&
        object.y < char.y + char.height
    end
  end

  def initialize
    @objects = {}
  end

  def add(key, logic)
    @objects[key] = logic
  end

  def [](key)
    @objects[key]
  end
end
