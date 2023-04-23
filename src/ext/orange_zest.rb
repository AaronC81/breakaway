# Things that should probably be in OrangeZest, and I'll probably add them later

module OrangeZest
    class Component
        # A quick way to create a new `Component` without defining a subclass.
        def self.anon(update: nil, draw: nil)
            _update = update || ->{}
            _draw = draw || ->{}

            Class.new(Component) do
                @@update = _update
                @@draw = _draw

                def update
                    @@update.()
                end

                def draw
                    @@draw.()
                end
            end.new
        end
    end

    class Animation
        # Create a placeholder `Animation`, with a single frame of static colour in a chosen size.
        def self.placeholder(w, h, c)
            image = Gosu.render(w, h) do
                Gosu.draw_rect(0, 0, w, h, c)
            end
            Animation.static(image)
        end
    end
end
