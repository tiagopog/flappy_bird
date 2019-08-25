class Logics
  attr_reader :objects

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
