clicker = {}

function clicker.load()

end

function clicker.update(dt)
    if input:pressed("gameClick") then
        if mouseX >= 424 and mouseX <= 893 then
            if mouseY >= 236 and mouseY <= 466 then
                clicks = clicks + 1 + clickUpgrade
            end
        end
    end
end
