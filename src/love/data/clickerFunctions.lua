return {
    enter = function()
        clothingHanger.x = 1000
        clothingHanger.y = 1000
        thingy = 0
        Timer.tween(
            0.8,
            clothingHanger,
            {
                x = 335,
                y = 350
            },
            "out-back"
        )
    end,
    update = function(dt)
        if input:pressed("gameClick") then
            if input:getActiveDevice() ~= "joy" then
                if mouseX >= 156 and mouseX <= 535 and mouseY >= 218 and mouseY <= 446 then
                    clicks = clicks + 1 + __OWNED[#__OWNED]
                end
            else
                clicks = clicks + 1 + __OWNED[#__OWNED]
            end
        end
    end,
    drawUI = function()
        if input:down("weird") then
            thingy = thingy + 0.05 * love.timer.getDelta()
            love.graphics.shear(math.cos(love.timer.getTime()) * thingy, math.cos(love.timer.getTime() * 1.3) * thingy)
        else
            thingy = 0
        end
        clothingHanger:draw()
    end
}