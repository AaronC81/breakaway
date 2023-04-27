require 'gosu'

require 'orange_zest'
OZ = OrangeZest
require_relative 'ext/orange_zest'

module GosuGameJam4
    WIDTH = 1600
    HEIGHT = 900

    # Some other classes need these constants to load
    ASEPRITE_EXPORT_SCALE = 2
    RES_DIR = File.join(__dir__, "..", "res")
end

require_relative 'entity/player'
require_relative 'entity/soul'
require_relative 'entity/wall'
require_relative 'entity/floor'
require_relative 'entity/flag'
require_relative 'entity/link_particle'
require_relative 'entity/text'
require_relative 'entity/button'
require_relative 'entity/barrier'
require_relative 'entity/hurt_marker'

require_relative 'component/transition'

require_relative 'levels'
require_relative 'save'
require_relative 'splash'
require_relative 'settings'

require_relative 'res'

module GosuGameJam4
    class Game < OZ::Window
        GAMEPLAY = OZ::Group.new
        MENU = OZ::Group.new

        PLAYERS = OZ::Group.new
        FLOORS = OZ::Group.new
        WALLS = OZ::Group.new
        BARRIERS = OZ::Group.new
        OBJECTIVES = OZ::Group.new
        LINK_PARTICLES = OZ::Group.new
        DECORATIONS = OZ::Group.new

        TRANSITION = Transition.new

        class << self
            attr_accessor :current_level
        end

        def self.solids
            Game::FLOORS.items + Game::WALLS.items
        end

        def self.flag
            Game::OBJECTIVES.items.find { |o| o.is_a?(Flag) }
        end

        def self.player
            Game::PLAYERS.items.find { |o| o.is_a?(Player) }
        end

        def self.window
            @@window
        end

        def self.reload_level(&block)
            player&.enabled = false
            TRANSITION.fade_out(20) do
                block.() if block

                PLAYERS.items.clear
                FLOORS.items.clear
                WALLS.items.clear
                OBJECTIVES.items.clear
                LINK_PARTICLES.items.clear
                DECORATIONS.items.clear

                Game.current_level.build.()

                TRANSITION.fade_in(20)
            end
        end

        def self.next_level(&block)
            Save.mark_level_beaten(Game.current_level.index)
            Save.save

            next_index = Game.current_level.index + 1
            if LEVELS[next_index].nil?
                show_splash_screen
            else
                go_to_level(Game.current_level.index + 1, &block)
            end
        end

        def self.go_to_level(index, &block)
            Game.current_level = LEVELS[index]
            reload_level(&block)
        end

        def initialize
            super WIDTH, HEIGHT
            @@window = self

            Gosu.enable_undocumented_retrofication

            # Add a component to clear the screen
            OZ::Component
                .anon(draw: ->{ Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::rgb(33, 11, 32)) })
                .register

            PLAYERS.register(GAMEPLAY)
            FLOORS.register(GAMEPLAY)
            WALLS.register(GAMEPLAY)
            BARRIERS.register(GAMEPLAY)
            OBJECTIVES.register(GAMEPLAY)
            LINK_PARTICLES.register(GAMEPLAY)
            DECORATIONS.register(GAMEPLAY)

            TRANSITION.register

            MENU.register
            GAMEPLAY.register

            Save.load

            Game.show_splash_screen(fade: false)
        end

        def update
            super

            # TODO: OZ should do this!
            OZ::Input.clear_click
        end

        def self.show_splash_screen(fade: true)
            show = ->do
                Splash.new.register(MENU)
                GAMEPLAY.enabled = false
                MENU.enabled = true
            end

            player&.enabled = false
            if fade
                TRANSITION.fade_out(20) do
                    show.()
                    TRANSITION.fade_in(20)
                end
            else
                show.()
            end
        end

        def self.close_menu
            MENU.items.clear
            GAMEPLAY.enabled = true
            MENU.enabled = false
        end
    end
end

GosuGameJam4::Game.new.show
