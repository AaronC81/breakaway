module GosuGameJam4
    class Flag < OZ::Entity
        def initialize(**kw)
            images = Gosu::Image.load_tiles(
                File.join(RES_DIR, "flag.png"),
                32 * ASEPRITE_EXPORT_SCALE,
                32 * ASEPRITE_EXPORT_SCALE,
                retro: true,
            )

            super(
                animations: {
                    normal: OZ::Animation.new(images, 8)
                },
                **kw
            )
        end

        def self.register_new(x:, y:)
            # Be helpful and offset Y position by height
            new(position: OZ::Point.new(x, y - 32 * ASEPRITE_EXPORT_SCALE)).register(Game::OBJECTIVES)
        end
    end
end
