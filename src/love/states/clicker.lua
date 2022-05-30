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
            Timer.tween(
                3,
                clothingHanger,
                {
                    orientation = 6.27
                },
                "out-elastic",
                function()
                    clothingHanger.orientation = 0
                end
            )
        end
    end,

    draw = function()
        clickerFunc:drawUI()
    end
}
