module GosuGameJam4
    class Level
        attr_accessor :index, :build
        def initialize(build)
            @build = build
        end
    end

    LEVELS = [
        # _.__________|_
        Level.new(->do
            Player.register_new(x: 500, y: 500)
            Floor.register_new(x: 400, y: 500, width: 800, height: 50)
            Flag.register_new(x: 1100, y: 500)
        end),

        #           __|_
        #      ____
        # _.__
        Level.new(->do
            Player.register_new(x: 500, y: 550)
            Floor.register_new(x: 400, y: 550, width: 200, height: 50)
            Floor.register_new(x: 700, y: 500, width: 200, height: 50)
            Floor.register_new(x: 1000, y: 450, width: 200, height: 50)
            Flag.register_new(x: 1100, y: 450)
        end),

        # _._          _|_
        Level.new(->do
            Player.register_new(x: 300, y: 500)
            Floor.register_new(x: 200, y: 500, width: 300, height: 50)
            Floor.register_new(x: 1100, y: 500, width: 300, height: 50)
            Flag.register_new(x: 1300, y: 500)
        end),

        #              _|_
        #
        #
        # _._          ___
        Level.new(->do
            Player.register_new(x: 300, y: 700)
            Floor.register_new(x: 200, y: 700, width: 300, height: 50)
            Floor.register_new(x: 1100, y: 700, width: 300, height: 50)
            Floor.register_new(x: 1100, y: 300, width: 300, height: 50)
            Flag.register_new(x: 1300, y: 300)
        end),

        # _____._____
        # 
        # 
        #     _|_
        Level.new(->do
            Player.register_new(x: 400, y: 300)
            Floor.register_new(x: 300, y: 300, width: 1000, height: 50)
            Floor.register_new(x: 700, y: 800, width: 200, height: 50)
            Flag.register_new(x: 800, y: 800)
        end),

        #       O
        # _.____O____|_
        Level.new(->do
            Player.register_new(x: 500, y: 500)
            Floor.register_new(x: 400, y: 500, width: 800, height: 50)
            Wall.register_new(x: 750, y: 300, width: 100, height: 200)
            Flag.register_new(x: 1100, y: 500)
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
