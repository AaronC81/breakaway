module GosuGameJam4
    class Soul < OZ::Entity
        attr_accessor :velocity

        def initialize(**kw)
            super(
                animations: {
                    normal: OZ::Animation.placeholder(50, 50, Gosu::Color::GREEN)
                },
                **kw
            )

            @velocity = OZ::Point.new(0, 0)
        end

        def update
            super
            
            self.position += @velocity
        end
    end
end
