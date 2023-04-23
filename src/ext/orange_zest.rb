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
end
