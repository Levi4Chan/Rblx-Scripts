--[[ 
Credits to: Rafa#0069
]]

local Library = require(game:GetService("ReplicatedStorage").Library)
while not Library.Loaded do task.wait() end

hookfunction(debug.getupvalue(Library.Network.Invoke, 1), function(...) return true end)

local originalPlay = Library.Audio.Play
Library.Audio.Play = function(...) 
    if checkcaller() then
        local audioId, parent, pitch, volume, maxDistance, group, looped, timePosition = unpack({ ... })
        if type(audioId) == "table" then
            audioId = audioId[Random.new():NextInteger(1, #audioId)]
        end
        if not parent then
            warn("Parent cannot be nil", debug.traceback())
            return nil
        end
        if audioId == 0 then return nil end
        
        if type(audioId) == "number" or not string.find(audioId, "rbxassetid://", 1, true) then
            audioId = "rbxassetid://" .. audioId
        end
        if pitch and type(pitch) == "table" then
            pitch = Random.new():NextNumber(unpack(pitch))
        end
        if volume and type(volume) == "table" then
            volume = Random.new():NextNumber(unpack(volume))
        end
        if group then
            local soundGroup = game.SoundService:FindFirstChild(group) or nil
        else
            soundGroup = nil
        end
        if timePosition == nil then
            timePosition = 0
        else
            timePosition = timePosition
        end
        local isGargabe = false
        if not pcall(function() local _ = parent.Parent end) then
            local newParent = parent
            pcall(function()
                newParent = CFrame.new(newParent)
            end)
            parent = Instance.new("Part")
            parent.Anchored = true
            parent.CanCollide = false
            parent.CFrame = newParent
            parent.Size = Vector3.new()
            parent.Transparency = 1
            parent.Parent = workspace:WaitForChild("__DEBRIS")
            isGargabe = true
        end
        local sound = Instance.new("Sound")
        sound.SoundId = audioId
        sound.Name = "sound-" .. audioId
        sound.Pitch = pitch and 1
        sound.Volume = volume and 0.5
        sound.SoundGroup = soundGroup
        sound.Looped = looped and false
        sound.MaxDistance = maxDistance and 100
        sound.TimePosition = timePosition
        sound.RollOffMode = Enum.RollOffMode.Linear
        sound.Parent = parent
        if not require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client")).Settings.SoundsEnabled then
            sound:SetAttribute("CachedVolume", sound.Volume)
            sound.Volume = 0
        end
        sound:Play()
        getfenv(originalPlay).AddToGarbageCollection(sound, isGargabe)
        return sound
    end
    
    return originalPlay(...)
end
