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
    objects.keys.each do |id|
      next unless logic[id]
      objects[id].x = logic[id].x
      objects[id].y = logic[id].y
    end
  end
end
