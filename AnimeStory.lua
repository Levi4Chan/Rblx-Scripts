repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players")
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Alive = game:GetService("Workspace"):WaitForChild("Live")
local Lighting = game:GetService("Lighting")

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
     
local Page2 = UI.New({
    Title = "Misc"
})

getgenv().Settings = {
    AutoMine = false,
    SIK = false,
    ValOreEsp = false,
    OreEsp = false,
    LootEsp = false,
    SellItem = nil,
    PlyrEsp = false,
    SellVal = 1
}

Page1.Toggle({
    Text = "Auto Mine",
    Callback = function(AM)
        Settings.AutoMine = AM
    end
})

Page1.Toggle({
    Text = "Semi Insta-Kill",
    Callback = function(SIK)
        Settings.SIK = SIK
    end
})

Page1.Toggle({
    Text = "Player Esp",
    Callback = function(PE)
        Settings.PlyrEsp = PE
    end
})

Page1.Toggle({
    Text = "Valuable Ore Esp",
    Callback = function(VOE)
        Settings.ValOreEsp = VOE
    end
})

Page1.Toggle({
    Text = "Ore Esp",
    Callback = function(OE)
        Settings.OreEsp = OE
    end
})

Page1.Toggle({
    Text = "Loot Esp",
    Callback = function(LE)
        Settings.LootEsp = LE
    end
})

Page1.TextField({
	Text = "Item to sell",
	Callback = function(Value)
		Settings.SellItem = Value
	end
})

Page1.TextField({
	Text = "Amount to sell",
	Callback = function(Value)
		Settings.SellVal = tonumber(Value)
	end
})

Page1.Button({
    Text = "Sell",
    Callback = function()
        for i=1, Settings.SellVal do
            game:GetService("ReplicatedStorage").Remotes.Sell:FireServer(Settings.SellItem)
        end
    end
})

Page2.Button({
    Text = "Boss Spawn Notifier",
    Callback = function()
        game:GetService("Workspace").Live.ChildAdded:Connect(function(Boss)
            local TIME_ZONE = 8
        
            local date = os.date("!*t")
            local hour = (date.hour + TIME_ZONE) % 24
            local ampm = hour < 12
            local timestamp = string.format("%02i:%02i", ((hour - 1) % 24) + 1, date.min)
            
            if Boss.Name == "Zakuza" or Boss.Name == "Demon" or Boss.Name == "Cellz" or Boss.Name == "Fraza" or Boss.Name == "Arkong" then
                game:GetService("StarterGui"):SetCore("SendNotification", { 
                    Title = "Boss Spawned",
                    Text = Boss.Name .. " has spawned",
                    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
                })
                print(timestamp ..": " .. Boss.Name .. " has spawned")
            end
        end)
    end
})

Page2.Button({
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
        
        game:GetService("Workspace").Live.ChildAdded:Connect(function(EventBoss)
            if EventBoss.Name == "Flower Captain" or EventBoss.Name == "Coyote" then
                local TIME_ZONE = 8
        
                local date = os.date("!*t")
                local hour = (date.hour + TIME_ZONE) % 24
                local ampm = hour < 12 and "AM" or "PM"
                local timestamp = string.format("%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, ampm)
            
                game:GetService("StarterGui"):SetCore("SendNotification", { 
                    Title = "Spawn Notif",
                    Text = EventBoss.Name .. " has spawned",
                    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
                })
                print(EventBoss.Name .. " has spawned on " .. timestamp)
            end
        end)
    end
})

Page2.Button({
    Text = "Server Age",
    Callback = function()
        local ServerAge = workspace.ServerAge.Value
        print(convertToHMS(ServerAge))
    end
})

Page2.Button({
    Text = "Full Bright",
    Callback = function()
        Lighting.Brightness = 2
	    Lighting.ClockTime = 14
	    Lighting.FogEnd = 100000
	    Lighting.GlobalShadows = false
	    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
})

Page2.Button({
    Text = "No Fog",
    Callback = function()
        Lighting.FogEnd = 100000
        for i,v in pairs(Lighting:GetDescendants()) do
            if v:IsA("Atmosphere") then
                v:Destroy()
            end
        end
    end
})

Page2.Button({
    Text = "Skip Tutorial",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.TutorialCompleted:FireServer()
    end
})

Page2.Button({
    Text = "Low Player Hop",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"

        local _place = game.PlaceId
        local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
        function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
        end

        local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
        until Server

        TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
    end
})

Page2.Button({
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

function SimplePlyr_Create(base, name, trackername, studs)
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
    txtlbl.TextColor3 = Color3.fromRGB(255, 150, 50)

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
        if Settings.SIK then
            pcall(function()
                for _, Mob in next, Alive:GetChildren() do
                    local Humanoid = Mob:FindFirstChildOfClass("Humanoid")
                    if Humanoid and Mob.PrimaryPart and isnetworkowner(Mob.PrimaryPart) and Mob:FindFirstChild("Participation") and Mob.Participation:FindFirstChild(Player.Name) then
                        Humanoid.Health = 0
                    end
                end
            end)
        end
        if Settings.PlyrEsp then
            pcall(function()
                ClearESP("Player_Tracker")
                for i, v in ipairs(Players:GetPlayers()) do
                    if v ~= Player then
                        if v.Character then
                            local studs = Player:DistanceFromCharacter(v.Character.HumanoidRootPart.Position)
                            SimplePlyr_Create(v.Character.HumanoidRootPart, v.Name, "Player_Tracker", math.floor(studs + 0.5))
                        end
                    end
                end
            end)
        else
            pcall(function()
                ClearESP("Player_Tracker")
            end)
        end
        if Settings.ValOreEsp then
            pcall(function()
                ClearESP("ValOre_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Interactable.Ores:GetChildren()) do
                    if v.Name == "Rune" or v.Name == "Magic Gem" or v.Name == "Blessed Gem" then
                        local studs = Player:DistanceFromCharacter(v.Rock.Position)
                        Simple_Create(v.Rock, v.Name, "ValOre_Tracker", math.floor(studs + 0.5))
                    end
                end
                for i,v in ipairs(game:GetService("Workspace").Interactable.Ores:GetChildren()) do
                    if (v.Name == "Rune" and not v:FindFirstChild("IOreH")) or (v.Name == "Magic Gem" and not v:FindFirstChild("IOreH")) or (v.Name == "Blessed Gem" and not v:FindFirstChild("IOreH")) then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "IOreH"
                        highlight.Parent = v
                        highlight.Adornee = v
                        highlight.OutlineColor = Color3.new(255, 255, 255)
                        highlight.FillColor = Color3.new(0, 255, 0)
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillTransparency = 0.3
                    end
                end
            end)
        else
            pcall(function()
                for i,v in ipairs(game:GetService("Workspace").Interactable.Ores:GetChildren()) do
                    if (v.Name == "Rune" and v:FindFirstChild("IOreH")) or (v.Name == "Magic Gem" and v:FindFirstChild("IOreH")) or (v.Name == "Blessed Gem" and v:FindFirstChild("IOreH")) then
                        v.IOreH:Destroy()
                    end
                end
                ClearESP("ValOre_Tracker")
            end)
        end
        if Settings.OreEsp then
            pcall(function()
                ClearESP("Ore_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Interactable.Ores:GetChildren()) do
                    local studs = Player:DistanceFromCharacter(v.Rock.Position)
                    Simple_Create(v.Rock, v.Name, "Ore_Tracker", math.floor(studs + 0.5))
                end
            end)
        else
            ClearESP("Ore_Tracker")
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
	repeat task.wait() until State == Enum.TeleportState.InProgress
        syn.queue_on_teleport(loadstring(game:HttpGet("https://raw.githubusercontent.com/Levi4Chan/Rblx-Scripts/main/AnimeStory.lua"))())
    end
end)
