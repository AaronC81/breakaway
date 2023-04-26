module GosuGameJam4
    class Wall < OZ::Entity
        PIECE_SIZE = 10 * ASEPRITE_EXPORT_SCALE

        IMAGES = Gosu::Image.load_tiles(
            File.join(RES_DIR, "wall.png"),
            PIECE_SIZE, PIECE_SIZE,
            retro: true,
        )

        CORNER_TOP_LEFT = IMAGES[0]
        CORNER_BOTTOM_RIGHT = IMAGES[1]
        CORNER_TOP_RIGHT = IMAGES[2]
        CORNER_BOTTOM_LEFT = IMAGES[3]
        TOP_EDGE = IMAGES[5...10]
        LEFT_EDGE = IMAGES[10...15]
        RIGHT_EDGE = IMAGES[15...20]
        BOTTOM_EDGE = IMAGES[20...25]
        CENTRE = IMAGES[25..-1]

        def initialize(width:, height:, **kw)
            super(animations: {}, **kw)

            raise "width must be multiple of #{PIECE_SIZE}" unless width % PIECE_SIZE == 0
            raise "height must be multiple of #{PIECE_SIZE}" unless height % PIECE_SIZE == 0

            @width = width
            @height = height

            @centre_piece_width = width / PIECE_SIZE - 2
            @centre_piece_height = height / PIECE_SIZE - 2

            @pieces = []

            # Generate top row
            @pieces << CORNER_TOP_LEFT
            @centre_piece_width.times { @pieces << TOP_EDGE.sample }
            @pieces << CORNER_TOP_RIGHT

            # Generate middle rows
            @centre_piece_height.times do
                @pieces << LEFT_EDGE.sample
                @centre_piece_width.times { @pieces << CENTRE.sample }
                @pieces << RIGHT_EDGE.sample
            end

            # Generate bottom row
            @pieces << CORNER_BOTTOM_LEFT
            @centre_piece_width.times { @pieces << BOTTOM_EDGE.sample }
            @pieces << CORNER_BOTTOM_RIGHT
        end

        def draw
            i = 0
            (@centre_piece_height + 2).times do |dy|
                (@centre_piece_width + 2).times do |dx|
                    piece = @pieces[i]
                    i += 1

                    piece.draw(position.x + dx * PIECE_SIZE, position.y + dy * PIECE_SIZE)
                end
            end
        end

        def bounding_box
            OZ::Box.new(position.clone, @width, @height)
        end

        def self.register_new(x:, y:, width:, height:)
            new(position: OZ::Point.new(x, y), width: width, height: height).register(Game::WALLS)
        end
    end
end
