require_relative 'soul'

module GosuGameJam4
    class Player < OZ::Entity
        attr_accessor :velocity, :soul

        def initialize(**kw)
            super(
                animations: {
                    normal: OZ::Animation.placeholder(50, 50, Gosu::Color::RED)
                },
                **kw
            )

            @velocity = OZ::Point.new(0, 0)
        end

        def update
            super

            left = Gosu.button_down?(Gosu::KB_LEFT)
            right = Gosu.button_down?(Gosu::KB_RIGHT)
            self.velocity.x = 
                if !(left ^ right)
                    0
                elsif left
                    -movement_speed
                elsif right
                    movement_speed
                end

            if on_floor?
                velocity.y = 0
            else
                velocity.y += 0.3
            end

            if OZ::TriggerCondition.watch(Gosu.button_down?(Gosu::KB_UP)) == :on
                self.velocity.y = -7 unless jumping? || falling?
            end
            
            # Check if we're going to hit a wall by moving in our velocity
            # TODO: assumes there'll never be a case where you can hit your head on a wall
            # (If we put a floor at the top of every one, maybe there isn't?)
            projected_box = bounding_box.clone
            projected_box.origin += velocity
            Game::WALLS.items.each do |wall|
                if projected_box.overlaps?(wall.bounding_box)
                    # Yep - set X velocity to 0
                    velocity.x = 0
                    break
                end
            end

            self.position += velocity

            if OZ::TriggerCondition.watch(Gosu.button_down?(Gosu::KB_SPACE)) == :on
                if @soul && can_rejoin?
                    self.position = @soul.position
                    self.velocity = @soul.velocity

                    @soul.unregister
                    @soul = nil
                elsif !@soul
                    @soul = Soul.new(position: self.position.clone)
                    @soul.velocity = self.velocity.clone
                    @soul.register
                end
            end
        end

        def can_rejoin?
            # If there's no soul, we can't rejoin to one!
            return unless soul

            # Make sure the soul isn't inside a wall or floor
            return false if Game.solids.any? { |solid| solid.bounding_box.overlaps?(soul.bounding_box) }

            # TODO: line-of-sight
            true
        end

        def rising?; velocity.y < 0; end
        alias jumping? rising?
        
        def falling?; velocity.y > 0; end

        def movement_speed
            5
        end

        # Modified from Pet Peeve's `GravityEntity`: https://github.com/AaronC81/pet-peeve/blob/main/src/engine/gravity_entity.rb
        FLOOR_CLIP_THRESHOLD = 30
        def left_floor_collision_scaling; 1 end
        def right_floor_collision_scaling; 1 end      
        def on_floor?
            Game.solids.any? do |floor|
                v_dist = (position.y + bounding_box.height) - floor.position.y
                if v_dist >= 0 && v_dist < FLOOR_CLIP_THRESHOLD \
                    && !rising? \
                    && position.x + (bounding_box.width * left_floor_collision_scaling) > floor.position.x \
                    && position.x + (bounding_box.width * right_floor_collision_scaling) < (floor.position.x + floor.bounding_box.width + bounding_box.width)
                    
                    self.position.y = floor.position.y - bounding_box.height
                    true
                else
                    false
                end
            end
        end        
    end
end
