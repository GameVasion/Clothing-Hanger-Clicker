local timer

function love.load()
    timer = 0
    clicks = 0
    CHPS = 0
    clickUpgrade = 0
    shop1Price = 10
    shop1Owned = 0
    shop2Price = 50
    shop2Owned = 0
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
       clicks = clicks + 1 + clickUpgrade
    end
end

function love.keypressed(key)
	if key == "6" then
		love.filesystem.createDirectory("screenshots")

		love.graphics.captureScreenshot("screenshots/" .. os.time() .. ".png")
    end

    if key == "escape" then
        love.event.quit()
    elseif key == "1" then
        if shop1Owned >= 1 then
            if clicks >= shop1Price * (shop1Owned * 1.1) then
                price = shop1Price * (shop1Owned * 1.1)
                shop1Owned = shop1Owned + 1
                clicks = clicks - price
                CHPS = CHPS + 1
            end
        else
            if clicks >= shop1Price then
                shop1Owned = shop1Owned + 1
                clicks = clicks - shop1Owned
                CHPS = CHPS + 1
            end
        end
    elseif key == "2" then
        if shop2Owned >= 1 then
            if clicks >= shop2Price * (shop2Owned * 1.1) then
                price = shop2Price * (shop2Owned * 1.1)
                shop2Owned = shop2Owned + 1
                clicks = clicks - price
                clickUpgrade = clickUpgrade + 1
            end
        else
            if clicks >= shop2Price then
                shop2Owned = shop2Owned + 1
                clicks = clicks - shop2Price
                clickUpgrade = clickUpgrade + 1
            end
        end
    end
end

function love.draw()
    love.graphics.print("Clicks: " .. clicks)
    if shop1Owned >= 1 then
        love.graphics.print("\nShop1 price: " .. shop1Price * (shop1Owned * 1.1)) -- I hate math
    else
        love.graphics.print("\nShop1 price: " .. shop1Price)
    end

    if shop2Owned >= 1 then
        love.graphics.print("\n\nShop2 price (Clicker power): " .. shop2Price * (shop2Owned * 1.1)) 
    else
        love.graphics.print("\n\nShop2 price (Clicker power): " .. shop2Price) 
    end
end
