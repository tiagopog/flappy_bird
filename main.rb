require 'ruby2d'

require_relative 'lib/scenario'

require_relative 'lib/logics'
require_relative 'lib/logics/game'
require_relative 'lib/logics/bird'

require_relative 'lib/graphics'
require_relative 'lib/graphics/bird'
require_relative 'lib/graphics/landscape'

set title: 'Flappy Bird',
  width: 286,
  height: 510,
  resizable: false,
  background: 'blue'

##
# Game logics
##

logics = Logics.new
game = Logics::Game.new(difficulty: :easy)

scenario = Scenario.new(window: get(:window), game: game)

bird = Logics::Bird.new(game: game)
logics.add(:bird, bird)

##
# Game graphics
##

graphics = Graphics.new

graphics.add(:bird, Graphics::Bird.new)
graphics.add(:landscape, Graphics::Landscape.new(window: get(:window)))

graphics.update!(logics)

##
# Events
##

on :key_down do |event|
  next if game.over? || game.paused? && event.key != 'p'
  game.started!

  case event.key
  when 'space' then bird.fly!
  when 'p' then game.pause!
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
  elsif Logics::Game.collision?(bird, scenario.objects)
    game.over!
  else
    scenario.move!
    bird.move!
    game.check_score!(bird, scenario.pipes)
    graphics.update!(logics)
  end
end

show
