require 'gosu'

require 'orange_zest'
OZ = OrangeZest
require_relative 'ext/orange_zest'

require_relative 'entity/player'
require_relative 'entity/soul'
require_relative 'entity/wall'
require_relative 'entity/floor'

module GosuGameJam4
    WIDTH = 1600
    HEIGHT = 900

    class Game < OZ::Window
        FLOORS = OZ::Group.new
        WALLS = OZ::Group.new

        def initialize
            super WIDTH, HEIGHT

            # Add a component to clear the screen
            OZ::Component
                .anon(draw: ->{ Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::WHITE) })
                .register

            Player.new(position: OZ::Point.new(100, 100)).register

            FLOORS.register
            Floor.new(position: OZ::Point.new(50, 500), width: 600, height: 50).register(FLOORS)

            WALLS.register
            Wall.new(position: OZ::Point.new(300, 400), width: 20, height: 200).register(WALLS)
        end
    end
end

GosuGameJam4::Game.new.show
