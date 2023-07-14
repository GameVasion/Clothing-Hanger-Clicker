return {
    enter = function()
        shopFunc:enter()
    end,

    update = function(dt)
        shopFunc:update(dt)
        if input:pressed("shopButton") then
            Gamestate.switch(clickerMenu)
        end
    end,

    draw = function()
        shopFunc:drawUI()
    end
}
