require 'fileutils'
require 'json'

module GosuGameJam4
    module Save
        # Save format is a JSON object:
        # { version: 1, levels: { 0: { beaten: true }, ... } }

        def self.load
            if File.exist?(save_file_path)
                @@data = JSON.parse(File.read(save_file_path))
            else
                @@data = { "version" => 1, "levels" => {} }
                save
            end
        end

        def self.save
            FileUtils.mkdir_p(save_directory)
            File.write(save_file_path, @@data.to_json)
        end

        def self.level_beaten?(index)
            level_data = @@data["levels"][index.to_s]
            return false unless level_data
            level_data["beaten"]
        end

        def self.level_unlocked?(index)
            return true if index == 0

            level_beaten?(index - 1)
        end

        def self.mark_level_beaten(index)
            @@data["levels"][index.to_s] = { beaten: true }
        end

        private

        def self.save_directory
            if OS.windows?
                File.join(Dir.home, "AppData", "Roaming", "OrangeFlashBreakaway")
            elsif OS.linux?
                File.join(Dir.home, ".local", "share", "OrangeFlashBreakaway")
            elsif OS.mac?
                File.join(Dir.home, "Library", "OrangeFlashBreakaway")
            else
                # Uhh... cwd is better than nothing?
                # (What are you playing on!?)
                File.join(Dir.pwd,  "OrangeFlashBreakaway")
            end
        end

        def self.save_file_path
            File.join(save_directory, "save.json")
        end
    end

    # https://stackoverflow.com/a/171011/2626000
    module OS
        def self.windows?
            (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
        end
    
        def self.mac?
            (/darwin/ =~ RUBY_PLATFORM) != nil
        end
    
        def self.unix?
            !OS.windows?
        end
    
        def self.linux?
            OS.unix? and not OS.mac?
        end
    
        def self.jruby?
            RUBY_ENGINE == 'jruby'
        end
    end
end
