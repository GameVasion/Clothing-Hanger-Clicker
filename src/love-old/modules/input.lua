local gameClick
return baton.new {
    controls = {
        gameClick = {"mouse:1", "button:a", "key:return"},
        shopButton = {"key:s", "button:back"},
        confirm = {"key:return", "button:start"},
        gameRight = {"button:dpright"},
        gameLeft = {"button:dpleft"},
        speen = {"key:space", "button:y"},
        weird = {"key:w", "button:x"}
    },
    joystick = love.joystick.getJoysticks()[1]
}