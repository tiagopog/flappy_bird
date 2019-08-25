require 'forwardable'

class Logics
  class BaseLogic
    extend Forwardable

    attr_reader :game
    attr_accessor :width, :height, :x, :y

    def_delegators :@game, :started?, :gravity

    def initialize(**attrs)
      @game = attrs[:game]
      @width = attrs[:width]
      @height = attrs[:height]
      @x = attrs[:x]
      @y = attrs[:y]
    end
  end
end
