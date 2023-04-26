module GosuGameJam4
    class Soul < OZ::Entity
        attr_accessor :velocity

        IMAGES = Gosu::Image.load_tiles(
            File.join(RES_DIR, "player.png"),
            16 * ASEPRITE_EXPORT_SCALE,
            32 * ASEPRITE_EXPORT_SCALE,
            retro: true,
        )

        def initialize(**kw)
            super(
                animations: {
                    normal: OZ::Animation.new(IMAGES[24..32], 2)
                },
                **kw
            )

            @velocity = OZ::Point.new(0, 0)
        end

        def update
            super

            self.mirror_x = velocity.x < 0
            self.position += velocity
        end
    end
end
