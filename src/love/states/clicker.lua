return {
    enter = function()
        clothingHanger.x = 1000
        clothingHanger.y = 1000
        timesPressed = 0
        thingy = 0
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
        if input:pressed("speen") then
            timesPressed = timesPressed + 1
            Timer.tween(
                3,
                clothingHanger,
                {
                    orientation = 6.27 * timesPressed
                },
                "out-elastic"
            )
        end
    end,

    draw = function()
        if input:down("weird") then
            thingy = thingy + 0.05 * love.timer.getDelta()
            love.graphics.shear(math.cos(love.timer.getTime()) * thingy, math.cos(love.timer.getTime() * 1.3) * thingy)
        else
            thingy = 0
        end
        clothingHanger:draw()
    end
}
