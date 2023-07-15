local sound = {}

sound.cache = {}
sound.cloneCache = {}

function sound.new(path, _type)
    local path = "assets/sounds/" .. path
    local _type = _type or "static"

    if not love.filesystem.getInfo(path) then
        error("File " .. path .. " does not exist!")
    end

    if not sound.cache[path] then
        if _type == "static" then
            sound.cache[path] = love.audio.newSource(path, "static")
        elseif _type == "stream" then
            sound.cache[path] = love.audio.newSource(path, "stream")
        end
    end

    local object = {
        x = 0,
        y = 0,

        volume = 1,
        pitch = 1,
        loop = false,

        sound = sound.cache[path],

        _type = "sound",

        play = function(self)
            print(self, self.sound)
            self.sound:setVolume(self.volume)
            self.sound:setPitch(self.pitch)
            self.sound:setLooping(self.loop)
            -- if its already playing, clone it
            if self.sound:isPlaying() then
                local clone = self.sound:clone()
                clone:setVolume(self.volume)
                clone:setPitch(self.pitch)
                clone:setLooping(self.loop)
                clone:play()
                table.insert(sound.cloneCache, clone)
            else
                self.sound:play()
            end
        end,

        stop = function(self)
            self.sound:stop()
        end,

        update = function(self, dt)
            for i, clone in ipairs(sound.cloneCache) do
                if not clone:isPlaying() then
                    table.remove(sound.cloneCache, i)
                end
            end
        end
    }

    return object
end

return sound