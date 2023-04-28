module GosuGameJam4
    class Splash < OZ::Group
        LOGO = Gosu::Image.new(File.join(RES_DIR, "logo.png"))

        def initialize
            super

            Save.load

            OZ::Entity.new(
                animations: {
                    normal: OZ::Animation.static(LOGO)
                },
                position: OZ::Point.new((WIDTH - LOGO.width) / 2, 150)
            ).register(self)

            Text.new(
                font: Fonts::CREDITS,
                text: "Music: 'Concentration'\nby JSKNYC on OpenGameArt.org",
                position: OZ::Point.new(20, HEIGHT - 65),
                center: false
            ).register(self)
            Text.new(
                font: Fonts::CREDITS,
                text: "Created by Aaron Christiansen\nFor Gosu Game Jam 4",
                position: OZ::Point.new(20, HEIGHT - 130),
                center: false
            ).register(self)

            # Create a button for each level
            levels_per_row = 4
            rows = LEVELS.length / levels_per_row
            level_button_size = 60
            level_button_spacing = 30
            origin = OZ::Point.new(
                (WIDTH - level_button_size * levels_per_row - level_button_spacing * (levels_per_row - 1)) / 2,
                (HEIGHT - level_button_size * rows - level_button_spacing * (rows - 1)) / 2,
            )
            LEVELS.each.with_index do |_, i|
                col = i % levels_per_row
                row = i / levels_per_row
                Button.new(
                    position: origin + OZ::Point.new(
                        col * (level_button_size + level_button_spacing),
                        row * (level_button_size + level_button_spacing),
                    ),

                    width: level_button_size,
                    height: level_button_size,
                    text: (i + 1).to_s,
                    font: Fonts::LEVEL_SELECT,
                    enabled: Save.level_unlocked?(i),
                    completed: Save.level_beaten?(i),
                    click: ->do
                        Game.go_to_level(i) do
                            Game.close_menu
                        end
                    end,
                ).register(self)
            end

            if LEVELS.each_index.all? { |i| Save.level_beaten?(i) }
                Text.new(
                    font: Fonts::CREDITS,
                    text: "Thank you for playing :)",
                    position: OZ::Point.new(800, HEIGHT - 200),
                ).register(self)
            end

            Settings.new(position: OZ::Point.new(WIDTH - 320, HEIGHT - 180)).register(self)
        end
    end
end
