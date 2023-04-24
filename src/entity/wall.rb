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
    end
end
