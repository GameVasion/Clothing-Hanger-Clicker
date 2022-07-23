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

    -- Data/Function files
    shopFunc = require "data.shopFunctions"-- Shop data
    clickerFunc = require "data.clickerFunctions"-- Clicker data

    function saveGame()
        f = {}
        f.savefile = {
            saveClicks = clicks,
            saveminiHangerOwn = __OWNED[1],
            
            
            saveplasticHangerOwn = __OWNED[2],
            savecopperHangerOwn = __OWNED[3],
            savesteelHangerOwn = __OWNED[4],
            saveironHangerOwn = __OWNED[5],
            savegoldHangerOwn = __OWNED[6],

            saveclickerPowerOwn = __OWNED[#__OWNED],

            saveCHPS = CHPS,
            saveVer = saveVer
        }
    
        serialized = lume.serialize(f)
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

    love.graphics.setDefaultFilter("nearest")
    clothingHanger = graphics.newImage(love.graphics.newImage(graphics.imagePath("clothingHanger")))
    love.graphics.setDefaultFilter("linear")
    clothingHanger.sizeX, clothingHanger.sizeY = 2.2
    clothingHanger.x, clothingHanger.y = 340, 350

    timer = 0
    shop1Price = 10
    shop2Price = 50
    if love.filesystem.getInfo("savedata.chcsave") then
        savefile = love.filesystem.read("savedata.chcsave")
        f = lume.deserialize(savefile)

        clicks = f.savefile.saveClicks
        CHPS = f.savefile.saveCHPS
        __OWNED = {
            [1] = f.savefile.saveminiHangerOwn,
            [2] = f.savefile.saveplasticHangerOwn,
            [3] = f.savefile.savecopperHangerOwn,
            [4] = f.savefile.savesteelHangerOwn,
            [5] = f.savefile.saveironHangerOwn,
            [6] = f.savefile.savegoldHangerOwn
        }
        table.insert(__OWNED, f.savefile.saveclickerPowerOwn) -- makes sures Clicker Power is ALWAYS last
        saveVer = f.savefile.saveVer
    end -- removed elseif statement to fix saves
    if not love.filesystem.getInfo("savedata.chcsave") or saveVer ~= 2 then -- if there is no save file or the save file is outdated
        love.window.showMessageBox(
            "Save Error",
            "Old/Unavailable savefile detected.\
            Resetting save...",
            "error"
        )
        clicks = 0
        CHPS = 0
        __OWNED = {
            [1] = 0, -- Mini Hanger
            [2] = 0, -- Plastic Hanger
            [3] = 0, -- Copper Hanger
            [4] = 0, -- Steel Hanger
            [5] = 0, -- Iron Hanger
            [6] = 0, -- Gold Hanger
        }
        table.insert(__OWNED, 0) -- makes sure Clicker Power is ALWAYS last
        saveVer = 2
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
    if Gamestate.current() == startMenu then
        for i = 1, #__OWNED do
            love.graphics.print(
                __OWNED[i],
                0,
                10 * i
            )
        end
    end
    if not love.filesystem.isFused() then love.graphics.print("\n\n\n\n\n\nDEBUG\nMouse X: " .. mouseX .. "\nMouse Y: " .. mouseY,620) end
    
end

function love.quit()
    saveGame()
end
