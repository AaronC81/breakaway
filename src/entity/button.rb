module GosuGameJam4
    class Button < OZ::Entity
        attr_accessor :width, :height, :text, :click, :font

        def initialize(width:, height:, text:, font: nil, click: nil, **kw)
            super(animations: {}, **kw)

            @width = width
            @height = height
            @text = text
            @click = click || ->{}
            @font = font || Fonts::BUTTON
        end

        def draw
            c = hover? ? Gosu::Color.rgb(215, 123, 186) : Gosu::Color::WHITE
            Gosu.draw_rect(position.x, position.y, width, height, c, position.z)

            text_width = font.text_width(text)
            x = position.x + (width - text_width) / 2
            y = position.y + (height - font.height) / 2
            font.draw_text(text, x, y, position.z, 1, 1, Gosu::Color::BLACK)
        end

        def update
            if hover? && OZ::Input.click?
                OZ::Input.clear_click
                click.()
            end
        end

        def hover?
            bounding_box.point_inside?(OZ::Input.cursor)
        end

        def bounding_box
            OZ::Box.new(position.clone, width, height)
        end
    end
end
