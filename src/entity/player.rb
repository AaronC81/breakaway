require_relative 'soul'

module GosuGameJam4
    class Player < OZ::Entity
        attr_accessor :velocity, :soul, :enabled
        alias enabled? enabled

        def initialize(**kw)
            images = Gosu::Image.load_tiles(
                File.join(RES_DIR, "player.png"),
                16 * ASEPRITE_EXPORT_SCALE,
                32 * ASEPRITE_EXPORT_SCALE,
                retro: true,
            )

            super(
                animations: {
                    normal: OZ::Animation.static(images[0]),
                    jump: OZ::Animation.static(images[6]),
                    fall: OZ::Animation.static(images[12]),
                    walk: OZ::Animation.new(images[18...24], 4),
                },
                **kw
            )

            @enabled = true
            @velocity = OZ::Point.new(0, 0)
        end

        def self.register_new(x:, y:)
            # Be helpful and offset Y position by height
            new(position: OZ::Point.new(x, y - 32 * ASEPRITE_EXPORT_SCALE)).register(Game::PLAYERS)
        end

        def update
            super
            return unless enabled?

            unless on_screen?
                # TODO: feedback for this
                Game.reload_level
            end

            if Game.flag
                if Game.flag.bounding_box.overlaps?(self.bounding_box)
                    Game.next_level
                end
            end

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

            # Set animation
            check_mirror_x = true
            if jumping?
                self.animation = :jump
            elsif falling?
                self.animation = :fall
            elsif velocity.x != 0
                self.animation = :walk
            else
                self.animation = :normal
                check_mirror_x = false
            end
            if check_mirror_x
                self.mirror_x = velocity.x < 0
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
                    @soul.register(Game::PLAYERS)
                end
            end
        end

        def draw
            super

            line = can_rejoin?
            if line
                line.each do |point|
                    if rand < 0.02
                        LinkParticle.new(
                            position: OZ::Point.new(point.x - 2 + rand(-5..5), point.y - 2 + rand(-5..5), 1000)
                        )
                            .register(Game::LINK_PARTICLES)
                    end
                end
            else
                Game::LINK_PARTICLES.items.clear
            end
        end

        def can_rejoin?
            # If there's no soul, we can't rejoin to one!
            return unless soul

            # Make sure the soul isn't inside a wall or floor
            return false if Game.solids.any? { |solid| solid.bounding_box.overlaps?(soul.bounding_box) }

            # Check line-of-sight between us and soul
            line = center_position.line_to(soul.center_position)
            line.each do |pt|
                # Passing through floor is fine, walls are not
                return false if Game::WALLS.items.any? { |solid| solid.bounding_box.point_inside?(pt) }
            end

            # The line is truthy, so we can return that for other stuff to use
            line
        end

        def rising?; velocity.y < 0; end
        alias jumping? rising?
        
        def falling?; velocity.y > 0; end

        def on_screen?
            screen = OZ::Box.new(OZ::Point.new(0, 0), WIDTH, HEIGHT)

            screen.point_inside?(center_position) &&
                (soul ? screen.point_inside?(soul.center_position) : true)
        end

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
