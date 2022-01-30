local gameClick
return baton.new {
    controls = {
        gameClick = {"mouse:1", "button:a"},
        shopButton = {"key:s", "button:back"},
        shop1Buy = {"key:1"},
        confirm = {"key:return", "button:start"},
        gameRight = {"button:dpright"},
        gameLeft = {"button:dpleft"}
    },
    joystick = love.joystick.getJoysticks()[1]
}