# frozen_string_literal: true

require 'forwardable'

class Logic
  ##
  # Base logic class for the game's logic elements.
  #
  # @attr_reader [Logic::Game] :game Game's main logic/rules
  #
  # @attr_accessor [Integer] :width Element's width
  # @attr_accessor [Integer] :height Element's height
  # @attr_accessor [Integer] :x Element's current x position
  # @attr_accessor [Integer] :y Element's current y position
  class BaseLogic
    extend Forwardable

    attr_reader :game
    attr_accessor :width, :height, :x, :y

    def_delegators :@game, :started?, :gravity

    # @api public
    # @param [Hash] Optional logic attributes
    # @return [BaseLogic]
    def initialize(**attrs)
      @game = attrs[:game]
      @width = attrs[:width]
      @height = attrs[:height]
      @x = attrs[:x]
      @y = attrs[:y]
    end
  end
end
