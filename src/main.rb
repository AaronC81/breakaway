require 'gosu'

require 'orange_zest'
OZ = OrangeZest
require_relative 'ext/orange_zest'

require_relative 'entity/player'
require_relative 'entity/soul'
require_relative 'entity/wall'
require_relative 'entity/floor'
require_relative 'entity/flag'
require_relative 'entity/link_particle'

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
        OBJECTIVES = OZ::Group.new
        LINK_PARTICLES = OZ::Group.new

        class << self
            attr_accessor :current_level
        end

        def self.solids
            Game::FLOORS.items + Game::WALLS.items
        end

        def self.flag
            Game::OBJECTIVES.items.find { |o| o.is_a?(Flag) }
        end

        def self.reload_level
            PLAYERS.items.clear
            FLOORS.items.clear
            WALLS.items.clear
            OBJECTIVES.items.clear
            LINK_PARTICLES.items.clear

            Game.current_level.build.()
        end

        def self.next_level
            # TODO: transition
            # TODO: handle out of levels
            Game.current_level = LEVELS[Game.current_level.index + 1]
            reload_level
        end

        def initialize
            super WIDTH, HEIGHT

            Gosu.enable_undocumented_retrofication

            # Add a component to clear the screen
            OZ::Component
                .anon(draw: ->{ Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::rgb(33, 11, 32)) })
                .register

            PLAYERS.register
            FLOORS.register
            WALLS.register
            OBJECTIVES.register
            LINK_PARTICLES.register

            starting_level_index = ENV['GGJ4_STARTING_LEVEL']&.to_i || 0
            Game.current_level = LEVELS[starting_level_index]
            Game.reload_level
        end
    end
end

GosuGameJam4::Game.new.show
