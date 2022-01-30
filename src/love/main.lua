local timer

function love.load()
    love.window.setMode(1280, 720, {resizable=true, vsync=true, minwidth=640, minheight=360})
    
    -- load libriries 
    baton = require "lib.baton"
    ini = require "lib.ini"
	Gamestate = require "lib.gamestate"
    lume = require "lib.lume"
    
    -- load states
    shopMenu = require "states.shop"
    clickerMenu = require "states.clicker"
    startMenu = require "states.startMenu"

    -- load modules
    graphics = require "modules.graphics"
    status = require "modules.status"
    input = require "modules.input"

    function saveGame()
        data = {}
        data.saveGameMoment = {
            saveClicks = clicks,
            saveShop1Owned = shop1Owned,
            saveShop2Owned = shop2Owned,
            saveCHPS = CHPS,
            saveClickUpgrade = clickUpgrade
        }
    
        serialized = lume.serialize(data)
        love.filesystem.write("savedata.chcsave", serialized)
    end

    clothingHanger = graphics.newImage(love.graphics.newImage(graphics.imagePath("clothing_hanger")))
    clothingHanger.x, clothingHanger.y = 660, 350

    timer = 0
    shop1Price = 10
    shop2Price = 50
    if love.filesystem.getInfo("savedata.chcsave") then
        file = love.filesystem.read("savedata.chcsave")
        data = lume.deserialize(file)
        clicks = data.saveGameMoment.saveClicks
        CHPS = data.saveGameMoment.saveCHPS
        clickUpgrade = data.saveGameMoment.saveClickUpgrade
        shop1Owned = data.saveGameMoment.saveShop1Owned
        shop2Owned = data.saveGameMoment.saveShop2Owned
    else
        clicks = 0
        CHPS = 0
        clickUpgrade = 0
        shop1Owned = 0
        shop2Owned = 0
    end

    Gamestate.switch(startMenu)
    
end

function love.update(dt)
    input:update()
    Gamestate.update(dt)

    timer = timer + dt
    if timer >= 1.4 then
        clicks = clicks + CHPS
        timer = 0  
    end
    
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()
end

function love.keypressed(key)
	if key == "6" then
		love.filesystem.createDirectory("screenshots")

		love.graphics.captureScreenshot("screenshots/" .. os.time() .. ".png")
    elseif key == "escape" then
        saveGame()
        love.event.quit()
    else
        Gamestate.keypressed(key)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
	Gamestate.mousepressed(x, y, button, istouch, presses)
end

function love.draw()
    Gamestate.draw()
    if Gamestate.current() ~= startMenu then
        love.graphics.print("Clicks: " .. clicks)
    end
    
    love.graphics.print("\n\n\n\n\n\nDEBUG\nMouse X: " .. mouseX .. "\nMouse Y: " .. mouseY)
    
end

function love.quit()
    saveGame()
end