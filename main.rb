require 'ruby2d'

require_relative 'lib/game'
require_relative 'lib/scenario'
require_relative 'lib/bird'

set title: 'Flappy Bird',
  width: 286,
  height: 510,
  resizable: false,
  background: 'blue'


game = Game.new
scenario = Scenario.new(window: get(:window))
bird = Bird.new(window: get(:window))

on :key_down do |event|
  next if game.over?
  bird.fly! if event.key == 'space'
end

on :key_up do
  next if game.over?
  bird.fall!
end

update do
  if game.over?
    scenario.display_score!
    next
  end

  game.over! if Game.collision?(bird, scenario.objects)
  scenario.move!
  bird.fall!
end

show
