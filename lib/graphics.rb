class Graphics
  attr_reader :objects

  def initialize
    @objects = {}
  end

  def add(key, graphic)
    @objects[key] = graphic
  end

  def update!(logics)
    objects.keys.each do |id|
      next unless logics[id]
      objects[id].x = logics[id].x
      objects[id].y = logics[id].y
    end
  end
end
