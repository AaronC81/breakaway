module GosuGameJam4
    class Barrier < OZ::Entity
        THICKNESS = 20

        REGENERATE_TIME = 8

        IMAGES = Gosu::Image.load_tiles(
            File.join(RES_DIR, "barrier.png"),
            10 * ASEPRITE_EXPORT_SCALE,
            10 * ASEPRITE_EXPORT_SCALE,
            retro: true,
        )

        STRAIGHT = IMAGES[1...-2]
        START_CAP = IMAGES[0]
        END_CAP = IMAGES[-1]

        attr_reader :width, :height, :orientation, :length

        def initialize(orientation:, length:, **kw)
            @orientation = orientation
            @length = length

            if orientation == :horizontal
                @width = length
                @height = THICKNESS
            elsif orientation == :vertical
                @width = THICKNESS
                @height = length
            else
                raise "unknown orientation"
            end

            super(
                animations: {
                    normal: OZ::Animation.placeholder(width, height, Gosu::Color::BLUE)
                },
                **kw
            )

            generate_pieces
            @regenerate_timer = REGENERATE_TIME
        end

        def generate_pieces
            raise "length must be multiple of #{THICKNESS}" unless length % THICKNESS == 0
            @pieces = [START_CAP]
            (0..(length / THICKNESS - 2)).each do
                @pieces << STRAIGHT.sample
            end
            @pieces << END_CAP
        end

        def draw
            @pieces.each.with_index do |piece, i|
                case orientation
                when :horizontal
                    piece.draw(position.x + i * THICKNESS, position.y)
                when :vertical
                    piece.draw_rot(position.x, position.y + i * THICKNESS, position.z, 90, 1, 1)
                else
                    raise 'invalid orientation'
                end
            end
        end

        def update
            super
            @regenerate_timer -= 1
            if @regenerate_timer <= 0
                generate_pieces
                @regenerate_timer = REGENERATE_TIME
            end
        end

        def bounding_box
            OZ::Box.new(position.clone, @width, @height)
        end

        def self.register_new(x:, y:, orientation:, length:)
            new(position: OZ::Point.new(x, y), orientation: orientation, length: length).register(Game::BARRIERS)
        end
    end
end
