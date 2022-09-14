repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local UI = Material.Load({
     Title = "Anime Story GUI",
     Style = 2,
     SizeX = 250,
     SizeY = 250,
     Theme = "Jester"
     })
local Page1 = UI.New({
    Title = "Scripts"
})

getgenv().Settings = {
    AutoMine = false,
    LootEsp = false
}

Page1.Toggle({
    Text = "Auto Mine",
    Callback = function(AM)
        Settings.AutoMine = AM
    end
})

Page1.Toggle({
    Text = "Loot Esp",
    Callback = function(AM)
        Settings.LootEsp = AM
    end
})

Page1.Button({
    Text = "Server Age",
    Callback = function()
        local ServerAge = workspace.ServerAge.Value
        print(convertToHMS(ServerAge))
    end
})

Page1.Button({
    Text = "Loot and Event Notifier",
    Callback = function()
        game:GetService("Workspace").Interactable.ChildAdded:Connect(function(interactables)
            local TIME_ZONE = 8
        
            local date = os.date("!*t")
            local hour = (date.hour + TIME_ZONE) % 24
            local ampm = hour < 12 and "AM" or "PM"
            local timestamp = string.format("%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, ampm)
            
            game:GetService("StarterGui"):SetCore("SendNotification", { 
                Title = "Spawn Notif",
                Text = interactables.Name .. " has spawned",
                Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
            })
            print(interactables.Name .. " has spawned on " .. timestamp)
        end)
        
        game:GetService("Workspace").Loot.ChildAdded:Connect(function(loot)
            local TIME_ZONE = 8
        
            local date = os.date("!*t")
            local hour = (date.hour + TIME_ZONE) % 24
            local ampm = hour < 12 and "AM" or "PM"
            local timestamp = string.format("%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, ampm)
            
            game:GetService("StarterGui"):SetCore("SendNotification", { 
                Title = "Loot Spawn Notif",
                Text = loot.Name .. " has spawned",
                Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
            })
            print(loot.Name .. " has spawned on " .. timestamp)
        end)
    end
})

Page1.Button({
    Text = "Print Ore, Loot & Event NPCs",
    Callback = function()
        warn("------ Ores ------")
        for i,v in ipairs(game:GetService("Workspace").Interactable.Ores:GetChildren()) do
            print(v)
        end
        warn("------ Loot ------")
        for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
            print(v)
        end
        warn("------ Event NPC ------")
        for i,v in ipairs(game:GetService("Workspace").Interactable:GetChildren()) do
            if not v:IsA("Folder") then
                print(v)
            end
        end
        for i,v in ipairs(game:GetService("Workspace").Live:GetChildren()) do
            if v.Name == "Flower Captain" then
                print(v.Name)
            end
        end
    end
})

function ClearESP(espname)
    for _,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == espname and v:isA('BillboardGui') then
            v:Destroy()
        end
    end
end

function Simple_Create(base, name, trackername, studs)
    local bb = Instance.new('BillboardGui', game.CoreGui)
    bb.Adornee = base
    bb.ExtentsOffset = Vector3.new(0,1,0)
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0,6,0,6)
    bb.StudsOffset = Vector3.new(0,1,0)
    bb.Name = trackername

    local frame = Instance.new('Frame', bb)
    frame.ZIndex = 10
    frame.BackgroundTransparency = 0.3
    frame.Size = UDim2.new(1,0,1,0)
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    local txtlbl = Instance.new('TextLabel', bb)
    txtlbl.ZIndex = 10
    txtlbl.BackgroundTransparency = 1
    txtlbl.Position = UDim2.new(0,0,0,-48)
    txtlbl.Size = UDim2.new(1,0,10,0)
    txtlbl.Font = 'ArialBold'
    txtlbl.FontSize = 'Size12'
    txtlbl.Text = name
    txtlbl.TextStrokeTransparency = 0.5
    txtlbl.TextColor3 = Color3.fromRGB(255, 0, 0)

    local txtlblstud = Instance.new('TextLabel', bb)
    txtlblstud.ZIndex = 10
    txtlblstud.BackgroundTransparency = 1
    txtlblstud.Position = UDim2.new(0,0,0,-35)
    txtlblstud.Size = UDim2.new(1,0,10,0)
    txtlblstud.Font = 'ArialBold'
    txtlblstud.FontSize = 'Size12'
    txtlblstud.Text = tostring(studs) .. " Studs"
    txtlblstud.TextStrokeTransparency = 0.5
    txtlblstud.TextColor3 = Color3.new(255,255,255)
end

function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

task.spawn(function()
    while task.wait() do
        if Settings.AutoMine then
            pcall(function()
                for i,v in ipairs(game:GetService("Workspace").Interactable.Ores:GetDescendants()) do
                    if v:IsA("ProximityPrompt") and Player:DistanceFromCharacter(v.Parent.Position) <= 30 then
                        fireproximityprompt(v)
                    else
                        continue
                    end
                end
            end)
        end
        if Settings.LootEsp then
            pcall(function()
                ClearESP("Loot_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
                    local studs = Player:DistanceFromCharacter(v.Main.Position)
                    Simple_Create(v.Main, v.Name, "Loot_Tracker", math.floor(studs + 0.5))
                end
            end)
        else
            ClearESP("Loot_Tracker")
        end
    end
end)

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        syn.queue_on_teleport(loadstring(game:HttpGet("https://raw.githubusercontent.com/Levi4Chan/Rblx-Scripts/main/AnimeStory.lua"))())
    end
end)
