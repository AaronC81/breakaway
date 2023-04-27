module GosuGameJam4
    class Text < OZ::Entity
        attr_accessor :font, :text, :color, :center

        def initialize(font:, text:, color: Gosu::Color::WHITE, center: true, **kw)
            super(animations: {}, **kw)

            @font = font
            @text = text
            @color = color
            @center = center
        end

        def draw
            if center
                width = font.text_width(text)
                x = position.x - width / 2
            else
                x = position.x
            end
            font.draw_text(text, x, position.y, position.z, 1, 1, color)
        end

        def self.register_new(x:, y:, font:, text:)
            new(position: OZ::Point.new(x, y), font: font, text: text).register(Game::DECORATIONS)
        end
    end
end
