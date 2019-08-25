require 'ruby2d'
require 'forwardable'

require_relative './logics/ground'
require_relative './pipe'

class Scenario
  extend Forwardable

  attr_reader :ground_manager, :pipe_manager

  def_delegators :ground_manager, :head_ground, :tail_ground
  def_delegators :pipe_manager, :pipes

  def initialize(window:, game:)
    @window = window
    @game = game
    @ground_manager = Logics::GroundManager.new
    @pipe_manager = PipeManager.new(window: window, game: game)
  end

  def objects
    [*grounds, *pipes]
  end

  def grounds
    ground_manager.grounds.values
  end

  def move!
    ground_manager.move!
    pipe_manager.move! if @game.started?
  end

  def display_score!
    @score ||= Square.new(size: 100, x: 94, y: 205, z: 3, color: 'black')
  end
end
