module Graphics
  module_function

  def update(graphics, logic)
    graphics.keys.each do |element|
      graphics[element].x = logic[element].x
      graphics[element].y = logic[element].y
    end
  end
end
