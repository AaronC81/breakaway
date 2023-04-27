module GosuGameJam4
    class Barrier < OZ::Entity
        THICKNESS = 20

        attr_reader :width, :height

        def initialize(orientation:, length:, **kw)
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
        end

        def self.register_new(x:, y:, orientation:, length:)
            new(position: OZ::Point.new(x, y), orientation: orientation, length: length).register(Game::BARRIERS)
        end
    end
end
