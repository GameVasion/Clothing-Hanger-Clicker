local gameClick
return baton.new {
    controls = {
        gameClick = {"mouse:1", "button:a"},
        shopButton = {"key:s", "button:back"},
    },
    joystick = love.joystick.getJoysticks()[1]
}