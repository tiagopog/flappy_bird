require 'ruby2d'

require_relative 'lib/game'
require_relative 'lib/scenario'

require_relative 'lib/graphics'
require_relative 'lib/graphics/bird'

require_relative 'lib/logic/bird'

set title: 'Flappy Bird',
  width: 286,
  height: 510,
  resizable: false,
  background: 'blue'

##
# Game graphics
##

graphics = {
  bird: Graphics::Bird.new(window: get(:window))
}

##
# Game logic
##

game = Game.new(difficulty: :easy)
scenario = Scenario.new(window: get(:window), game: game)
bird = Logic::Bird.new(game: game, graphics: graphics[:bird])

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
  elsif Game.collision?(bird, scenario.objects)
    game.over!
  else
    scenario.move!
    bird.move!
    game.check_score!(bird, scenario.pipes)
    Graphics.update(graphics[:bird], bird)
  end
end

show
