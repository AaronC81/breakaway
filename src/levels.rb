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
            Text.register_new(x: 800, y: 200, font: Fonts::TUTORIAL, text: "Use left/right arrows to walk")

            Player.register_new(x: 500, y: 500)
            Floor.register_new(x: 400, y: 500, width: 800)
            Flag.register_new(x: 1100, y: 500)
        end),

        #           __|_
        #      ____
        # _.__
        Level.new(->do
            Text.register_new(x: 800, y: 200, font: Fonts::TUTORIAL, text: "Use up arrow to jump")

            Player.register_new(x: 500, y: 550)
            Floor.register_new(x: 400, y: 550, width: 200)
            Floor.register_new(x: 700, y: 500, width: 200)
            Floor.register_new(x: 1000, y: 450, width: 200)
            Flag.register_new(x: 1100, y: 450)
        end),

        # _._          _|_
        Level.new(->do
            Text.register_new(x: 800, y: 140, font: Fonts::TUTORIAL, text: "Press space to break your soul from your body")
            Text.register_new(x: 800, y: 210, font: Fonts::TUTORIAL, text: "Your soul travels in the direction you were moving")
            Text.register_new(x: 800, y: 280, font: Fonts::TUTORIAL, text: "Press space again to rejoin with your soul")

            Player.register_new(x: 300, y: 500)
            Floor.register_new(x: 200, y: 500, width: 300)
            Floor.register_new(x: 1100, y: 500, width: 300)
            Flag.register_new(x: 1300, y: 500)
        end),

        #              _|_
        #
        #
        # _._          ___
        Level.new(->do
            Player.register_new(x: 300, y: 700)
            Floor.register_new(x: 200, y: 700, width: 300)
            Floor.register_new(x: 1100, y: 700, width: 300)
            Floor.register_new(x: 1100, y: 300, width: 300)
            Flag.register_new(x: 1300, y: 300)
        end),

        # _____._____
        # 
        # 
        #     _|_
        Level.new(->do
            Player.register_new(x: 400, y: 300)
            Floor.register_new(x: 300, y: 300, width: 1000)
            Floor.register_new(x: 700, y: 800, width: 200)
            Flag.register_new(x: 800, y: 800)
        end),

        #       O
        # _.____O____|_
        #
        #    ______
        Level.new(->do
            Text.register_new(x: 800, y: 200, font: Fonts::TUTORIAL, text: "Walls block you from rejoining with your soul")

            Player.register_new(x: 500, y: 500)
            Floor.register_new(x: 200, y: 500, width: 1200)
            Floor.register_new(x: 600, y: 700, width: 400)
            Wall.register_new(x: 750, y: 300, width: 100, height: 200)
            Flag.register_new(x: 1300, y: 500)
        end),

        #       O
        # _.____O____|_
        Level.new(->do
            Player.register_new(x: 500, y: 500)
            Floor.register_new(x: 400, y: 500, width: 800)
            Wall.register_new(x: 750, y: 300, width: 100, height: 200)
            Flag.register_new(x: 1100, y: 500)
        end),

        #       ^
        # _.__  O____|_
        Level.new(->do
            Player.register_new(x: 500, y: 400)
            Floor.register_new(x: 200, y: 400, width: 400)
            Floor.register_new(x: 800, y: 400, width: 600)
            Wall.register_new(x: 700, y: -10, width: 100, height: 460)
            Flag.register_new(x: 1250, y: 400)
        end),

        #              _|_
        #
        #            =====
        # _.______________
        Level.new(->do
            Text.register_new(x: 800, y: 200, font: Fonts::TUTORIAL, text: "Barriers will kill you and your soul")

            Player.register_new(x: 300, y: 700)
            Floor.register_new(x: 200, y: 800, width: 1200)
            Barrier.register_new(x: 900, y: 600, length: 600, orientation: :horizontal)
            Floor.register_new(x: 1100, y: 400, width: 300)
            Flag.register_new(x: 1300, y: 400)
        end),

        # __.________
        # ========
        #          __
        #       =====
        # _________|_  
        Level.new(->do
            Player.register_new(x: 400, y: 200)
            Floor.register_new(x: 300, y: 200, width: 1000)
            Barrier.register_new(x: 0, y: 300, length: 1150, orientation: :horizontal)
            Barrier.register_new(x: 1300, y: 0, length: 200, orientation: :vertical)

            Floor.register_new(x: 1000, y: 500, width: 500)
            Barrier.register_new(x: 900, y: 600, length: 700, orientation: :horizontal)

            Floor.register_new(x: 300, y: 800, width: 1000)
            Flag.register_new(x: 1250, y: 800)
        end),
    ]

    # Fill in indices
    LEVELS.each.with_index do |level, i|
        level.index = i 
    end
end
