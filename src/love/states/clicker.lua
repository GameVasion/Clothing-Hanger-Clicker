return {
    enter = function()
        clickerFunc:enter()
    end,

    update = function(dt)
        clickerFunc:update(dt)
        
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
        clickerFunc:drawUI()
    end
}
