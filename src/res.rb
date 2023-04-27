module GosuGameJam4
    module Sounds
        SPLIT = Gosu::Sample.new(File.join(RES_DIR, "sample", "split.wav"))
        JOIN = Gosu::Sample.new(File.join(RES_DIR, "sample", "join.wav"))
        JUMP = Gosu::Sample.new(File.join(RES_DIR, "sample", "jump.wav"))
        WIN = Gosu::Sample.new(File.join(RES_DIR, "sample", "win.wav"))
        DIE = Gosu::Sample.new(File.join(RES_DIR, "sample", "die.wav"))
    end

    module Fonts
        TUTORIAL = Gosu::Font.new(30, name: File.join(RES_DIR, "Silkscreen.ttf"))
        CREDITS = Gosu::Font.new(25, name: File.join(RES_DIR, "Silkscreen.ttf"))
        CALL_TO_ACTION = Gosu::Font.new(40, name: File.join(RES_DIR, "Silkscreen.ttf"))
        BUTTON = Gosu::Font.new(30, name: File.join(RES_DIR, "Silkscreen.ttf"))
        LEVEL_SELECT = Gosu::Font.new(50, name: File.join(RES_DIR, "Silkscreen.ttf"))
        SETTINGS = Gosu::Font.new(25, name: File.join(RES_DIR, "Silkscreen.ttf"))
    end
end
