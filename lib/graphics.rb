# frozen_string_literal: true

class Graphics
  attr_accessor :logic
  attr_reader :objects

  def initialize(logic:)
    @objects = {}
    @logic = logic
  end

  def add(key, graphic)
    @objects[key] = graphic
  end

  def update!
    objects.each_pair do |id, object|
      next unless logic[id] && object.respond_to?(:update!)

      object.update!(logic[id])
    end
  end
end
