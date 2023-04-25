module GosuGameJam4
    module Sounds
        SPLIT = Gosu::Sample.new(File.join(RES_DIR, "sample", "split.wav"))
        JOIN = Gosu::Sample.new(File.join(RES_DIR, "sample", "join.wav"))
        JUMP = Gosu::Sample.new(File.join(RES_DIR, "sample", "jump.wav"))
    end
end
