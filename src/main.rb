require 'gosu'

require 'orange_zest'
OZ = OrangeZest
require_relative 'ext/orange_zest'

require_relative 'entity/player'
require_relative 'entity/soul'
require_relative 'entity/wall'
require_relative 'entity/floor'

require_relative 'levels'

module GosuGameJam4
    WIDTH = 1600
    HEIGHT = 900

    ASEPRITE_EXPORT_SCALE = 2
    RES_DIR = File.join(__dir__, "..", "res")

    class Game < OZ::Window
        PLAYERS = OZ::Group.new
        FLOORS = OZ::Group.new
        WALLS = OZ::Group.new

        class << self
            attr_accessor :current_level
        end

        def self.solids
            Game::FLOORS.items + Game::WALLS.items
        end

        def self.reload_level
            PLAYERS.items.clear
            FLOORS.items.clear
            WALLS.items.clear

            Game.current_level.build.()
        end

        def initialize
            super WIDTH, HEIGHT

            Gosu.enable_undocumented_retrofication

            # Add a component to clear the screen
            OZ::Component
                .anon(draw: ->{ Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::WHITE) })
                .register

            PLAYERS.register
            FLOORS.register
            WALLS.register

            Game.current_level = LEVELS[0]
            Game.reload_level
        end
    end
end

GosuGameJam4::Game.new.show
