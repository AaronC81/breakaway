module GosuGameJam4
    class Text < OZ::Entity
        attr_accessor :font, :text, :color

        def initialize(font:, text:, color: Gosu::Color::WHITE, **kw)
            super(animations: {}, **kw)

            @font = font
            @text = text
            @color = color
        end

        def draw
            # Draw text vertically centred on the given point

            width = font.text_width(text)
            font.draw_text(text, position.x - width / 2, position.y, position.z, 1, 1, color)
        end

        def self.register_new(x:, y:, font:, text:)
            new(position: OZ::Point.new(x, y), font: font, text: text).register(Game::DECORATIONS)
        end
    end
end
