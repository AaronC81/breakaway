require 'gosu'

require 'orange_zest'
OZ = OrangeZest
require_relative 'ext/orange_zest'

require_relative 'entity/player'

module GosuGameJam4
    WIDTH = 1600
    HEIGHT = 900

    class Game < OZ::Window
        def initialize
            super WIDTH, HEIGHT

            # Add a component to clear the screen
            OZ::Component
                .anon(draw: ->{ Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::WHITE) })
                .register

            Player.new(position: OZ::Point.new(100, 100)).register
        end
    end
end

GosuGameJam4::Game.new.show
