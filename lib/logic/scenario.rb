require 'ruby2d'
require 'forwardable'

require_relative './ground'
require_relative './pipe'

class Logic
  class Scenario
    extend Forwardable

    attr_reader :ground_manager, :pipe_manager

    def_delegators :ground_manager, :grounds
    def_delegators :pipe_manager, :pipes

    def initialize(window:, game:)
      @window = window
      @game = game
      @ground_manager = Logic::GroundManager.new
      @pipe_manager = Logic::PipeManager.new(window: window, game: game)
      @score ||= Square.new(size: 100, x: 94, y: 205, z: -9999, color: 'black')
    end

    def restart!
      @score.z = -9999
      [ground_manager, pipe_manager].map(&:restart!)
    end

    def objects
      [*grounds, *pipes]
    end

    def move!
      ground_manager.move!
      pipe_manager.move! if @game.started?
    end

    def display_score!
      @score.z = 3
    end
  end
end
