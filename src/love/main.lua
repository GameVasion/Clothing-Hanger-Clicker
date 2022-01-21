local timer

function love.load()
    timer = 0
    clicks = 0
    CHPS = 0
    love.window.setMode(1280, 720, {resizable=true, vsync=true, minwidth=640, minheight=360})
    -- load libriries 
    baton = require "lib.baton"
    ini = require "lib.ini"
	Gamestate = require "lib.gamestate"
    
    -- load states
    clickerMenu = require "states.clicker"

    -- load modules
    graphics = require "modules.graphics"
    status = require "modules.status"

    -- load settings
    input = require "settings.input"

end

function love.update(dt)
    timer = timer + dt
    if timer >= 1.4 then
        clicks = clicks + CHPS
        timer = 0  
    end  
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
       clicks = clicks + 1
    end
end

function love.keypressed(key)
	if key == "6" then
		love.filesystem.createDirectory("screenshots")

		love.graphics.captureScreenshot("screenshots/" .. os.time() .. ".png")
    end
    if key == "escape" then
        love.event.quit()
    end
    if key == "1" then
        if clicks >= 10 then
            clicks = clicks - 10
            CHPS = CHPS + 1
        end
    end
end

function love.draw()
    love.graphics.print("Clicks: " .. clicks)
end