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

    shopFunc = require "data.shopFunctions"-- Shop data
    clickerFunc = require "data.clickerFunctions"-- Clicker data

    function saveGame()
        d = {}
        d.savefile = {
            saveClicks = clicks,
            saveminiHangerOwn = miniHangerOwn,
            saveclickerPowerOwn = clickerPowerOwn,
            saveCHPS = CHPS,
            saveClickUpgrade = clickUpgrade,
            saveplasticHangerOwn = plasticHangerOwn,
            savecopperHangerOwn = copperHangerOwn,
            savesteelHangerOwn = steelHangerOwn,

            saveVer = saveVer
        }
    
        serialized = lume.serialize(d)
        love.filesystem.write("savedata.chcsave", serialized)
    end

    function autoHanger()
        Timer.after(
            1,
            function()
                clicks = clicks + CHPS
                autoHanger()
            end
        )
    end
    autoHanger()

    clothingHanger = graphics.newImage(love.graphics.newImage(graphics.imagePath("clothing_hanger")))
    clothingHanger.x, clothingHanger.y = 335, 350

    timer = 0
    shop1Price = 10
    shop2Price = 50
    if love.filesystem.getInfo("savedata.chcsave") then
        savefile = love.filesystem.read("savedata.chcsave")
        f = lume.deserialize(savefile)

        clicks = f.savefile.saveClicks
        CHPS = f.savefile.saveCHPS
        clickUpgrade = f.savefile.saveClickUpgrade
        miniHangerOwn = f.savefile.saveminiHangerOwn
        clickerPowerOwn = f.savefile.saveclickerPowerOwn
        plasticHangerOwn = f.savefile.saveplasticHangerOwn
        copperHangerOwn = f.savefile.savecopperHangerOwn
        steelHangerOwn = f.savefile.savesteelHangerOwn
        ironHangerOwn = f.savefile.saveironHangerOwn
        saveVer = f.savefile.saveVer
    end -- removed elseif statement to fix saves
    if not love.filesystem.getInfo("savedata.chcsave") or saveVer ~= 5 then -- if there is no save file or the save file is outdated
        love.window.showMessageBox(
            "Save Error",
            "Old/Unavailable savefile detected.\
            Resetting save...",
            "error"
        )
        clicks = 0
        CHPS = 0
        clickUpgrade = 0
        miniHangerOwn = 0
        clickerPowerOwn = 0
        plasticHangerOwn = 0
        copperHangerOwn = 0
        steelHangerOwn = 0
        ironHangerOwn = 0
        saveVer = 5
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

    --[[
    timer = timer + dt
    if timer >= 1.4 then
        clicks = clicks + CHPS
        timer = 0  
    end
    --]]
    
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
    if not love.filesystem.isFused() then love.graphics.print("\n\n\n\n\n\nDEBUG\nMouse X: " .. mouseX .. "\nMouse Y: " .. mouseY,620) end
    
end

function love.quit()
    saveGame()
end
