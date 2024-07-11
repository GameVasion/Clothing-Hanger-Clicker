function love.load()
    -- Libraries
    input = (require "lib.baton").new {
        controls = {
            pressed = {"key:space", "mouse:1"},
        }
    }
    state = require "lib.gamestate"
    push = require "lib.push"
    Timer = require "lib.timer"
    lume = require "lib.lume"
    json = require "lib.json"

    -- Modules
    graphics = require "modules.graphics"
    sound = require "modules.sound"
    mod = require "modules.mod"

    push.setupScreen(800, 600, {upscale="normal"})

    clothinghanger = graphics.newImage("clothing_hanger")
    clothinghanger.x = love.graphics.getWidth() / 2 
    clothinghanger.y = love.graphics.getHeight() / 2
    clothinghanger.scale = 1
    clothinghanger.alignment = "center"

    curState = "menu"

    states = {}
    -- load all states in states/
    for _, file in ipairs(love.filesystem.getDirectoryItems("states")) do
        if file:sub(-4) == ".lua" then
            local name = file:sub(1, -5)
            states[name] = require("states." .. name)
        end
    end

    saveVer = 1
    clicks = 0
    CHPS = 0

    timer = 0

    hangers = {}

    boughtHangers = {}

    -- for all in data/hangers, load the json file
    for _, file in ipairs(love.filesystem.getDirectoryItems("data/hangers")) do
        if file:sub(-5) == ".json" then
            local name = file:sub(1, -6)
            local data = json.decode(love.filesystem.read("data/hangers/" .. file))
            data.data.ogPrice = data.data.price
            hangers[data.name] = data     
        end
    end

    -- for all in hangers, add a variable to boughtHangers
    for k, v in pairs(hangers) do
        boughtHangers[v.name] = 0
    end

    -- sort the hangers table by price
    table.sort(hangers, function(a, b) return a.data.price < b.data.price end)

    mod.loadCustomHangers()

    loadGame()

    -- load all sounds in sounds/
    sounds = {}
    for _, file in ipairs(love.filesystem.getDirectoryItems("assets/sounds")) do
        if file:sub(-4) == ".wav" then
            local name = file:sub(1, -5)
            sounds[name] = sound.new(file)
            print(name)
        end
    end

    state.switch(states[curState])
end

function saveGame()
    local saveData = {
        clicks = clicks,
        hangers = boughtHangers,

        CHPS = CHPS,
        saveVer = saveVer,
    }
    love.filesystem.write("save.chc", lume.serialize(saveData))
end

function loadGame()
    if not love.filesystem.getInfo("save.chc") then
        return
    end
    local saveData = lume.deserialize(love.filesystem.read("save.chc")) or {}
    clicks = saveData.clicks or 0
    CHPS = saveData.CHPS or 0
    saveVer = saveData.saveVer or 1

    boughtHangers = saveData.hangers or {}

    -- add all missing hangers
    for k, v in pairs(hangers) do
        if not boughtHangers[v.name] then
            boughtHangers[v.name] = 0
        end
    end

    -- change price of hangers
    for k, v in pairs(boughtHangers) do
        if v > 0 then
            hangers[k].data.price = hangers[k].data.price * (1.1 ^ v)
        end
    end
end

function love.update(dt)
    input:update()
    state.update(dt)

    timer = timer + dt
    if timer >= 1 then
        timer = 0
        clicks = clicks + CHPS
    end
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.mousepressed(x, y, button, istouch, presses)
    state.mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
    state.mousereleased(x, y, button, istouch, presses)
end

function love.draw()
    push.start()
    state.draw()
    push.finish()
end

function love.quit()
    saveGame()
end