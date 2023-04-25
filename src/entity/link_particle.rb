module GosuGameJam4
    class LinkParticle < OZ::Entity
        def initialize(**kw)
            super(
                animations: {
                    normal: OZ::Animation.static(Gosu::Image.new(File.join(RES_DIR, "link.png")))
                },
                **kw
            )

            @lifetime = 10
        end

        def update
            unregister if @lifetime == 0
            self.opacity = @lifetime / 10.0
            @lifetime -= 1
        end
    end
end
