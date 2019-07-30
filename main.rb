require 'ruby2d'

require_relative 'lib/game'
require_relative 'lib/scenario'
require_relative 'lib/bird'

set title: 'Flappy Bird',
  width: 286,
  height: 510,
  resizable: false,
  background: 'blue'

game = Game.new(difficulty: :hard)
scenario = Scenario.new(window: get(:window), difficulty: :normal)
bird = Bird.new(window: get(:window))

on :key_down do |event|
  next if game.over? || game.paused? && event.key != 'p'
  game.started!

  case event.key
  when 'space' then bird.fly!
  when 'p' then game.pause!
  end
end

update do
  if game.paused?
    next
  elsif game.over?
    scenario.display_score!
    next
  elsif Game.collision?(bird, scenario.objects)
    game.over!
  elsif !game.started?
    scenario.move!(skip: :pipes)
  else
    scenario.move!
    bird.move!
  end
end

show
