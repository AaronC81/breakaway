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

    class Entity
        def center_position
            position + Point.new(bounding_box.width / 2, bounding_box.height / 2)
        end
    end

    class Point
        # Return all points in a line from one point to another.
        def line_to(other)
            # `supercover_line` from: https://www.redblobgames.com/grids/line-drawing.html
            dx = other.x - self.x
            dy = other.y - self.y
            nx = dx.abs
            ny = dy.abs
            sign_x = dx <=> 0
            sign_y = dy <=> 0

            p = self.clone
            points = [p.clone]
            
            ix = 0
            iy = 0
            while ix < nx || iy < ny
                decision = (1 + 2*ix) * ny - (1 + 2*iy) * nx
                if decision == 0
                    p.x += sign_x
                    p.y += sign_y
                    ix += 1
                    iy += 1
                elsif decision < 0
                    p.x += sign_x
                    ix += 1
                else
                    p.y += sign_y
                    iy += 1
                end
                points << p.clone
            end

            points
        end
    end
end
