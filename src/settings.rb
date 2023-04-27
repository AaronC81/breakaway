module GosuGameJam4
    class Settings < OZ::Group
        class << self
            attr_accessor :sfx_volume_percentage
        end
        Settings.sfx_volume_percentage = 50

        def self.sfx_volume
            sfx_volume_percentage.to_f / 100
        end

        def initialize(position:)
            super()

            Button.new(
                position: position.clone,
                width: 300, height: 40,
                text: "Toggle fullscreen",
                click: ->do
                    Game.window.fullscreen = !Game.window.fullscreen?
                end,
                font: Fonts::SETTINGS,
            ).register(self)

            Text.new(
                position: position + OZ::Point.new(0, 70),
                text: "SFX:",
                center: false,
                font: Fonts::SETTINGS,
            ).register(self)

            Button.new(
                position: position + OZ::Point.new(120, 60),
                width: 40, height: 40,
                text: "-",
                click: ->{ Settings.sfx_volume_percentage -= 10 if Settings.sfx_volume_percentage > 0 },
                font: Fonts::SETTINGS,
            ).register(self)
            @sfx_volume_text = Text.new(
                position: position + OZ::Point.new(210, 70),
                text: "50%",
                font: Fonts::SETTINGS,
            )
            @sfx_volume_text.register(self)
            Button.new(
                position: position + OZ::Point.new(260, 60),
                width: 40, height: 40,
                text: "+",
                click: ->{ Settings.sfx_volume_percentage += 10 if Settings.sfx_volume_percentage < 100 },
                font: Fonts::SETTINGS,
            ).register(self)
        end

        def update
            super
            @sfx_volume_text.text = "#{Settings.sfx_volume_percentage}%"
        end
    end
end
