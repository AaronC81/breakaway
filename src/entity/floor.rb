module GosuGameJam4
    class Floor < OZ::Entity
        def initialize(width:, height:, **kw)
            super(
                animations: {
                    normal: OZ::Animation.placeholder(width, height, Gosu::Color::BLUE)
                },
                **kw
            )
        end
    end
end
