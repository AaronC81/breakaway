module GosuGameJam4
    class Player < OZ::Entity
        def initialize(**kw)
            super(
                animations: {
                    normal: OZ::Animation.placeholder(50, 50, Gosu::Color::RED)
                },
                **kw
            )
        end

        def update
            super

            if Gosu.button_down?(Gosu::KB_LEFT)
                self.position.x -= movement_speed
            end
            if Gosu.button_down?(Gosu::KB_RIGHT)
                self.position.x += movement_speed
            end
        end

        def movement_speed
            10
        end
    end
end
