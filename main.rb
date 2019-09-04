require 'ruby2d'

require_relative 'lib/logic'
require_relative 'lib/logic/game'
require_relative 'lib/logic/bird'
require_relative 'lib/logic/scenario'

require_relative 'lib/graphics'
require_relative 'lib/graphics/bird'
require_relative 'lib/graphics/pipe'
require_relative 'lib/graphics/ground'
require_relative 'lib/graphics/landscape'

set title: 'Flappy Bird',
  width: 288,
  height: 510,
  resizable: false,
  background: 'blue'

##
# Game logic
##

logic = Logic.new
game = Logic::Game.new(difficulty: :easy)
bird = Logic::Bird.new(game: game)
scenario = Logic::Scenario.new(window: get(:window), game: game)

logic.add(:bird, bird)

logic.add(:pft, scenario.pipes(:first, :top))
logic.add(:pfb, scenario.pipes(:first, :bottom))

logic.add(:plt, scenario.pipes(:last, :top))
logic.add(:plb, scenario.pipes(:last, :bottom))

logic.add(:fg, scenario.grounds(:first))
logic.add(:lg, scenario.grounds(:last))

##
# Game graphics
##

graphics = Graphics.new(logic: logic)

graphics.add(:bird, Graphics::Bird.new)

graphics.add(:pft, Graphics::Pipe.new(x: 0, y: 0, position: :top))
graphics.add(:pfb, Graphics::Pipe.new(x: 0, y: 370, position: :bottom))

graphics.add(:plt, Graphics::Pipe.new(x: 288, y: 0, position: :top))
graphics.add(:plb, Graphics::Pipe.new(x: 288, y: 370, position: :bottom))

graphics.add(:fg, Graphics::Ground.new(x: 0))
graphics.add(:lg, Graphics::Ground.new(x: 288))

graphics.add(:landscape, Graphics::Landscape.new(window: get(:window)))

graphics.update!

##
# Events
##

on :key_down do |event|
  if game.over?
    Logic.restart!(game, bird, scenario)
  elsif game.paused? && event.key != 'p'
    next
  else
    game.started!

    case event.key
    when 'space' then bird.fly!
    when 'p' then game.pause!
    end
  end
end

##
# Game loop
##

update do
  if game.paused?
    next
  elsif game.over?
    scenario.display_score!
    next
  elsif Logic.collision?(bird, scenario.objects)
    game.over!
  else
    scenario.move!
    bird.move!
    game.check_score!(bird, scenario.pipes)
    graphics.update!
  end
end

show
