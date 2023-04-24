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
                velocity.y += 0.5
            end

            if OZ::TriggerCondition.watch(Gosu.button_down?(Gosu::KB_UP)) == :on
                # TODO: shouldn't be allowed in the air
                self.velocity.y = -7
            end

            self.position += velocity

            if OZ::TriggerCondition.watch(Gosu.button_down?(Gosu::KB_SPACE)) == :on
                if @soul                    
                    self.position = @soul.position
                    self.velocity = @soul.velocity

                    @soul.unregister
                    @soul = nil
                else
                    @soul = Soul.new(position: self.position.clone)
                    @soul.velocity = self.velocity.clone
                    @soul.register
                end
            end
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
            Game::FLOORS.items.any? do |floor|
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
