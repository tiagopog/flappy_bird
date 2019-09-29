require_relative './game_over/title'

class Graphics
  class GameOver
    def initialize
      @title = Title.new
    end

    def update!(game)
      if game.over?
        @title.show!
      else
        @title.hide!
      end
    end
  end
end
