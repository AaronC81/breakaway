module GosuGameJam4
    class HurtMarker < OZ::Entity
        IMAGE = Gosu::Image.new(File.join(RES_DIR, "hurt.png"))

        def initialize(**kw)
            super(
                animations: {
                    normal: OZ::Animation.static(IMAGE)
                },
                **kw
            )
        end

        def update
            super
            self.rotation += 4
        end

        def draw
            image.draw_rot(position.x, position.y, position.y, self.rotation, 0.5, 0.5)
        end
    end
end
