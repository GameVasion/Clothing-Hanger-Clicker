local timer

function love.load()    
    -- load libriries 
    baton = require "lib.baton"
	Gamestate = require "lib.gamestate"
    lovesize = require "lib.lovesize"
    lume = require "lib.lume"
    Timer = require "lib.timer"

    -- load modules
    graphics = require "modules.graphics"
    input = require "modules.input"
    
    -- load states
    shopMenu = require "states.shop"
    clickerMenu = require "states.clicker"
    startMenu = require "states.startMenu"

    function saveGame()
        d = {}
        d.savefile = {
            saveClicks = clicks,
            saveShop1Owned = shop1Owned,
            saveShop2Owned = shop2Owned,
            saveCHPS = CHPS,
            saveClickUpgrade = clickUpgrade,

            saveVer = saveVer
        }
    
        serialized = lume.serialize(d)
        love.filesystem.write("savedata.chcsave", serialized)
    end

    clothingHanger = graphics.newImage(love.graphics.newImage(graphics.imagePath("clothing_hanger")))
    clothingHanger.x, clothingHanger.y = 335, 350

    timer = 0
    shop1Price = 10
    shop2Price = 50
    if love.filesystem.getInfo("savedata.chcsave") then
        savefile = love.filesystem.read("savedata.chcsave")
        d = lume.deserialize(savefile)

        clicks = d.savefile.saveClicks
        CHPS = d.savefile.saveCHPS
        clickUpgrade = d.savefile.saveClickUpgrade
        shop1Owned = d.savefile.saveShop1Owned
        shop2Owned = d.savefile.saveShop2Owned
        saveVer = d.savefile.saveVer
    end -- removed elseif statement to fix saves
    if not love.filesystem.getInfo("savedata.chcsave") or saveVer ~= 1 then -- if there is no save file or the save file is outdated
        love.window.showMessageBox(
            "Save Error",
            "Old/Unavailable savefile detected.\
            Resetting save...",
            "error"
        )
        clicks = 0
        CHPS = 0
        clickUpgrade = 0
        shop1Owned = 0
        shop2Owned = 0
        saveVer = 1
    end

    love.window.setIcon(love.image.newImageData("icon.png"))

    love.window.setMode(720, 620, {resizable=true, vsync=true}) 
    lovesize.set(720, 620)

    Gamestate.switch(startMenu)
    
end

function love.update(dt)
    input:update()
    graphics.screenBase(lovesize.getWidth(), lovesize.getHeight())
    Gamestate.update(dt)
    Timer.update(dt)

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

function love.resize(width, height)
	lovesize.resize(width, height)
end

function love.mousepressed(x, y, button, istouch, presses)
	Gamestate.mousepressed(x, y, button, istouch, presses)
end

function love.draw()
    graphics.screenBase(lovesize.getWidth(), lovesize.getHeight())
        lovesize.begin()
            Gamestate.draw()
        lovesize.finish()
    graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())
    if Gamestate.current() ~= startMenu then
        love.graphics.print(
            "Clicks: " .. clicks ..
            "\nCHPS: " .. CHPS 
        )
    end
    if not love.filesystem.isFused() then love.graphics.print("\n\n\n\n\n\nDEBUG\nMouse X: " .. mouseX .. "\nMouse Y: " .. mouseY) end
    
end

function love.quit()
    saveGame()
end
