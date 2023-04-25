module GosuGameJam4
    Level = Struct.new("Level", :build)
    LEVELS = [
        Level.new(->do
            Player.new(position: OZ::Point.new(100, 100)).register(Game::PLAYERS)

            Floor.register_new(x: 50, y: 500, width: 600, height: 50)
            Floor.register_new(x: 150, y: 700, width: 400, height: 50)

            Wall.register_new(x: 300, y: 400, width: 20, height: 200)
        end)
    ]
end
