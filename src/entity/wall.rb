module GosuGameJam4
    class Wall < OZ::Entity
        def initialize(width:, height:, **kw)
            super(
                animations: {
                    normal: OZ::Animation.placeholder(width, height, Gosu::Color::BLACK)
                },
                **kw
            )
        end

        def self.register_new(x:, y:, width:, height:)
            new(position: OZ::Point.new(x, y), width: width, height: height).register(Game::WALLS)
        end
    end
end
