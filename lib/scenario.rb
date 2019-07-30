require 'ruby2d'

require_relative './ground'
require_relative './pipe'

class Scenario
  attr_reader :ground_manager, :pipe_manager

  def initialize(window:, difficulty:)
    @window = window
    @landspace = build_landscape
    @ground_manager = GroundManager.new
    @pipe_manager = PipeManager.new(
      window: window,
      difficulty: difficulty
    )
  end

  def move!(**options)
    ground_manager.move!
    pipe_manager.move! unless options[:skip] == :pipes
  end

  def display_score!
    @score ||= Square.new(size: 100, x: 94, y: 205, color: 'black')
  end

  def objects
    [*ground_manager.grounds, *pipe_manager.pipes]
  end

  private

  def build_landscape
    Sprite.new(
      'assets/images/game_sprite.png',
      clip_width: @window.get(:width),
      clip_height: @window.get(:height)
    )
  end
end
