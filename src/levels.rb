module GosuGameJam4
    class Level
        attr_accessor :index, :build
        def initialize(build)
            @build = build
        end
    end

    LEVELS = [
        Level.new(->do
            Player.register_new(x: 500, y: 500)
            Floor.register_new(x: 400, y: 500, width: 800, height: 50)
            Flag.register_new(x: 1000, y: 500)
        end),

        Level.new(->do
            Player.new(position: OZ::Point.new(100, 100)).register(Game::PLAYERS)

            Floor.register_new(x: 50, y: 500, width: 600, height: 50)
            Floor.register_new(x: 150, y: 700, width: 400, height: 50)

            Flag.register_new(x: 550, y: 500)

            Wall.register_new(x: 300, y: 400, width: 20, height: 200)
        end),
    ]

    # Fill in indices
    LEVELS.each.with_index do |level, i|
        level.index = i 
    end
end
