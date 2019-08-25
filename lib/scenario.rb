require 'ruby2d'

require_relative './ground'
require_relative './pipe'

class Scenario
  attr_reader :ground_manager, :pipe_manager

  def initialize(window:, game:)
    @window = window
    @game = game
    @ground_manager = GroundManager.new
    @pipe_manager = PipeManager.new(window: window, game: game)
  end

  def move!
    ground_manager.move!
    pipe_manager.move! if @game.started?
  end

  def display_score!
    @score ||= Square.new(size: 100, x: 94, y: 205, z: 3, color: 'black')
  end

  def objects
    [*grounds, *pipes]
  end

  def grounds
    ground_manager.grounds
  end

  def pipes
    pipe_manager.pipes
  end
end
