module GosuGameJam4
    class Floor < OZ::Entity
        PIECE_WIDTH = 10 * ASEPRITE_EXPORT_SCALE

        IMAGES = Gosu::Image.load_tiles(
            File.join(RES_DIR, "platform.png"),
            10 * ASEPRITE_EXPORT_SCALE,
            10 * ASEPRITE_EXPORT_SCALE,
            retro: true,
        )

        STRAIGHT = IMAGES[0...20]
        LEFT = IMAGES[20]
        RIGHT = IMAGES[40]

        def initialize(width:, height:, **kw)
            super(animations: {}, **kw)

            @width = width
            @height = height

            # Generate pieces to fill in the width of the platform
            raise "platform length must be multiple of #{PIECE_WIDTH}" unless width % PIECE_WIDTH == 0
            @pieces = [LEFT]
            (0..(width / PIECE_WIDTH - 2)).each do
                @pieces << STRAIGHT.sample
            end
            @pieces << RIGHT
        end

        def draw
            @pieces.each.with_index do |piece, i|
                piece.draw(position.x + i * PIECE_WIDTH, position.y)
            end
        end

        def bounding_box
            OZ::Box.new(position.clone, @width, @height)
        end

        def self.register_new(x:, y:, width:, height:)
            new(position: OZ::Point.new(x, y), width: width, height: height).register(Game::FLOORS)
        end
    end
end
