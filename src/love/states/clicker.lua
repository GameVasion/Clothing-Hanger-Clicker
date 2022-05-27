return {
    enter = function()
        clothingHanger.x = 1000
        clothingHanger.y = 1000
        Timer.tween(
            0.8,
            clothingHanger,
            {
                x = 335,
                y = 350
            },
            "out-elastic"
        )
    end,

    update = function(dt)
        if input:pressed("gameClick") then
            if input:getActiveDevice() ~= "joy" then
                if mouseX >= 75 and mouseX <= 600 and mouseY >= 211 and mouseY <= 485 then
                    clicks = clicks + 1 + clickUpgrade
                end
            else
                clicks = clicks + 1 + clickUpgrade
            end
        end
        
        if input:pressed("shopButton") then
            Gamestate.switch(shopMenu)
        end
    end,

    draw = function()
        clothingHanger:draw()
    end
}
