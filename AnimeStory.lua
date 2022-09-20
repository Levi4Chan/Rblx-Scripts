repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players")
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

-- Configs
getgenv().Settings = {
    AutoMine = false,
    SIK = false,
    SSA = false,
    ValOreEsp = false,
    OreEsp = false,
    LootEsp = false,
    SellItem = nil,
    PlyrEsp = false,
    AutoM1 = false,
    r2p = 1,
    SellVal = 1,
    KisugeItem = nil,
    KisugeSlot = "Item1",
    CoinsColor = Color3.fromRGB(255, 255, 255),
    GemsColor = Color3.fromRGB(255, 255, 255),
    ArrowColor = Color3.fromRGB(255, 255, 255),
    RokakaColor = Color3.fromRGB(255, 255, 255),
    AdamColor = Color3.fromRGB(255, 255, 255),
    CoreColor = Color3.fromRGB(255, 255, 255),
    DFColor = Color3.fromRGB(255, 255, 255),
    ReqColor = Color3.fromRGB(255, 255, 255),
    DBColor = Color3.fromRGB(255, 255, 255)
}

getgenv().Loots = {
    Coins = false,
    Gems = false,
    Arrow = false,
    Rokaka = false,
    Adamantite = false,
    GoldenCore = false,
    DevilFruit = false,
    RequiemArrow = false,
    DragonBall = false
}

-- Services
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local Player = Players.LocalPlayer
local Alive = game:GetService("Workspace"):WaitForChild("Live")
local Loot = game:GetService("Workspace"):WaitForChild("Loot")
local Interactables = game:GetService("Workspace"):WaitForChild("Interactable")
local Remotes = ReplicatedStorage.Remotes
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local TIME_ZONE = 8
local date = os.date("!*t")
local hour = (date.hour + TIME_ZONE) % 24
local ampm = hour < 12 and "AM" or "PM"
local timestamp = string.format("%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, ampm)

-- GUI
local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = GameName .. " | Levia",
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab('Main'), 
    Visual = Window:AddTab('Visual'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local FarmGroupBox = Tabs.Main:AddLeftGroupbox('Farm')

FarmGroupBox:AddToggle('AutoMine', {
    Text = 'Auto Mine',
    Default = false, 
    Tooltip = 'Auto mine if you are near an ore.', 
})

FarmGroupBox:AddToggle('AutoM1', {
    Text = 'Auto Attack/M1',
    Default = false, 
    Tooltip = "So you don't have to click.", 
}):AddKeyPicker('KeyAutoM1', { Default = "F", NoUI = false, Text = "Auto Attack/M1" })

FarmGroupBox:AddToggle('SIK', {
    Text = 'Semi Insta-Kill',
    Default = false, 
    Tooltip = "Only works on humanoid-like mobs.", 
})

FarmGroupBox:AddToggle('SSA', {
    Text = 'Skip Summon Animation',
    Default = false, 
    Tooltip = "Removes summon animation.", 
})

Toggles.AutoMine:OnChanged(function()
    Settings.AutoMine = Toggles.AutoMine.Value
end)

Toggles.AutoM1:OnChanged(function()
    Settings.AutoM1 = Toggles.AutoM1.Value
end)

Toggles.SIK:OnChanged(function()
    Settings.SIK = Toggles.SIK.Value
end)

Toggles.SSA:OnChanged(function()
    Settings.SSA = Toggles.SSA.Value
end)

Options.KeyAutoM1:OnClick(function()
    if Settings.AutoM1 then
        Toggles.AutoM1:SetValue(false)
        Library:Notify("Auto Attack Disabled.", 3)
    else
        Toggles.AutoM1:SetValue(true)
        Library:Notify("Auto Attack Enabled.", 3)
    end
end)

local RubyGroupBox = Tabs.Main:AddLeftGroupbox('Ruby to Potion')

RubyGroupBox:AddInput('r2p', {
    Default = "Default: 1",
    Numeric = true,
    Finished = false,

    Text = 'Ruby Amount',
    Tooltip = 'How many rubies do you want to convert.',

    Placeholder = 'Default: 1',
})

RubyGroupBox:AddButton('Convert', function()
    for i=1, Settings.r2p do
        Remotes.UseItem:FireServer("Ruby")
    end
end)

Options.r2p:OnChanged(function()
    Settings.r2p = Options.r2p.Value
end)

local KintokiGroupBox = Tabs.Main:AddRightGroupbox('Kintoki')

KintokiGroupBox:AddInput('SellItem', {
    Default = "Item to sell",
    Numeric = false,
    Finished = false,

    Text = 'Item to sell',
    Tooltip = 'Type an item name to sell.',

    Placeholder = 'Item to sell',
})

KintokiGroupBox:AddInput('SellVal', {
    Default = "Amount to sell",
    Numeric = true,
    Finished = false,

    Text = 'Amount to sell',
    Tooltip = 'Type an amount to sell.',

    Placeholder = 'Amount to sell',
})

KintokiGroupBox:AddButton('Sell', function()
    for i=1, Settings.SellVal do
        Remotes.Sell:FireServer(Settings.SellItem)
    end
end)

KintokiGroupBox:AddButton('Sell All', function()
    Remotes.Sell:FireServer(Settings.SellItem, "All")
end)

Options.SellItem:OnChanged(function()
    Settings.SellItem = Options.SellItem.Value
end)

Options.SellVal:OnChanged(function()
    Settings.SellVal = Options.SellVal.Value
end)

local PlayerOreGroup = Tabs.Visual:AddLeftGroupbox("Player & Ore ESP")

PlayerOreGroup:AddToggle('PlyrEsp', {
    Text = 'Player',
    Default = false, 
})

PlayerOreGroup:AddToggle('ValOreEsp', {
    Text = 'Valuable Ore',
    Default = false, 
})

PlayerOreGroup:AddToggle('OreEsp', {
    Text = 'All Ore',
    Default = false, 
})

Toggles.PlyrEsp:OnChanged(function()
    Settings.PlyrEsp = Toggles.PlyrEsp.Value
end)

Toggles.ValOreEsp:OnChanged(function()
    Settings.ValOreEsp = Toggles.ValOreEsp.Value
end)

Toggles.OreEsp:OnChanged(function()
    Settings.OreEsp = Toggles.OreEsp.Value
end)

local LootGroup = Tabs.Visual:AddRightGroupbox('Loot ESP')

LootGroup:AddToggle('Coins', {
    Text = 'Coins',
    Default = false, 
}):AddColorPicker("CoinsColor", { Default = Color3.new(0, 1, 0) })

Options.CoinsColor:SetValueRGB(Color3.fromRGB(0, 255, 140))

LootGroup:AddToggle('Gems', {
    Text = 'Gems',
    Default = false, 
}):AddColorPicker("GemsColor", { Default = Color3.new(0, 1, 0) })

LootGroup:AddToggle('Arrow', {
    Text = 'Arrow',
    Default = false, 
}):AddColorPicker("ArrowColor", { Default = Color3.new(0, 1, 0) })

LootGroup:AddToggle('Rokaka', {
    Text = 'Rokaka',
    Default = false, 
}):AddColorPicker("RokakaColor", { Default = Color3.new(0, 1, 0) })

LootGroup:AddToggle('RequiemArrow', {
    Text = 'Requiem Arrow',
    Default = false, 
}):AddColorPicker("ReqColor", { Default = Color3.new(0, 1, 0) })

LootGroup:AddToggle('DevilFruit', {
    Text = 'Devil Fruit',
    Default = false, 
}):AddColorPicker("DFColor", { Default = Color3.new(0, 1, 0) })

LootGroup:AddToggle('GoldenCore', {
    Text = 'Golden Core',
    Default = false, 
}):AddColorPicker("CoreColor", { Default = Color3.new(0, 1, 0) })

LootGroup:AddToggle('Adamantite', {
    Text = 'Adamantite',
    Default = false, 
}):AddColorPicker("AdamColor", { Default = Color3.new(0, 1, 0) })

LootGroup:AddToggle('DragonBall', {
    Text = 'DragonBall',
    Default = false, 
}):AddColorPicker("DBColor", { Default = Color3.new(0, 1, 0) })

Options.GemsColor:SetValueRGB(Color3.fromRGB(255, 140, 0))
Options.ArrowColor:SetValueRGB(Color3.fromRGB(255, 0, 140))
Options.RokakaColor:SetValueRGB(Color3.fromRGB(255, 0, 140))
Options.AdamColor:SetValueRGB(Color3.fromRGB(255, 0, 140))
Options.CoreColor:SetValueRGB(Color3.fromRGB(255, 0, 140))
Options.DFColor:SetValueRGB(Color3.fromRGB(255, 0, 140))
Options.ReqColor:SetValueRGB(Color3.fromRGB(255, 0, 140))
Options.DBColor:SetValueRGB(Color3.fromRGB(255, 0, 140))

Options.CoinsColor:OnChanged(function()
    Settings.CoinsColor = Options.CoinsColor.Value
end)

Options.GemsColor:OnChanged(function()
    Settings.GemsColor = Options.GemsColor.Value
end)

Options.ArrowColor:OnChanged(function()
    Settings.ArrowColor = Options.ArrowColor.Value
end)

Options.RokakaColor:OnChanged(function()
    Settings.RokakaColor = Options.RokakaColor.Value
end)

Options.AdamColor:OnChanged(function()
    Settings.AdamColor = Options.AdamColor.Value
end)

Options.CoreColor:OnChanged(function()
    Settings.CoreColor = Options.CoreColor.Value
end)

Options.DFColor:OnChanged(function()
    Settings.DFColor = Options.DFColor.Value
end)

Options.ReqColor:OnChanged(function()
    Settings.ReqColor = Options.ReqColor.Value
end)

Options.DBColor:OnChanged(function()
    Settings.DBColor = Options.DBColor.Value
end)

Toggles.Coins:OnChanged(function()
    Loots.Coins = Toggles.Coins.Value
end)

Toggles.Gems:OnChanged(function()
    Loots.Gems = Toggles.Gems.Value
end)

Toggles.Arrow:OnChanged(function()
    Loots.Arrow = Toggles.Arrow.Value
end)

Toggles.Rokaka:OnChanged(function()
    Loots.Rokaka = Toggles.Rokaka.Value
end)

Toggles.RequiemArrow:OnChanged(function()
    Loots.RequiemArrow = Toggles.RequiemArrow.Value
end)

Toggles.DevilFruit:OnChanged(function()
    Loots.DevilFruit = Toggles.DevilFruit.Value
end)

Toggles.GoldenCore:OnChanged(function()
    Loots.GoldenCore = Toggles.GoldenCore.Value
end)

Toggles.Adamantite:OnChanged(function()
    Loots.Adamantite = Toggles.Adamantite.Value
end)

Toggles.DragonBall:OnChanged(function()
    Loots.DragonBall = Toggles.DragonBall.Value
end)

local NotifyGroup = Tabs.Misc:AddLeftGroupbox("In-game Notifier")

NotifyGroup:AddButton('Boss Spawn', function()
    Alive.ChildAdded:Connect(function(Boss)
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
            --print(timestamp ..": " .. Boss.Name .. " has spawned")
        end
    end)
end)

NotifyGroup:AddButton('Loot & Event', function()
    Interactables.ChildAdded:Connect(function(interactables)
        local TIME_ZONE = 8
    
        local date = os.date("!*t")
        local hour = (date.hour + TIME_ZONE) % 24
        local ampm = hour < 12 and "AM" or "PM"
        local timestamp = string.format("%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, ampm)
        
        game:GetService("StarterGui"):SetCore("SendNotification", { 
            Title = "Spawn Notif",
            Text = interactables.Name .. " has spawned!",
            Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
        })
        --print(interactables.Name .. " has spawned on " .. timestamp)
    end)
    
    Loot.ChildAdded:Connect(function(loot)
        local TIME_ZONE = 8
    
        local date = os.date("!*t")
        local hour = (date.hour + TIME_ZONE) % 24
        local ampm = hour < 12 and "AM" or "PM"
        local timestamp = string.format("%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, ampm)
        
        game:GetService("StarterGui"):SetCore("SendNotification", { 
            Title = "Loot Spawn Notif",
            Text = loot.Name .. " has spawned!",
            Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
        })
        --print(loot.Name .. " has spawned on " .. timestamp)
    end)
    
    Alive.ChildAdded:Connect(function(EventBoss)
        if EventBoss.Name == "Flower Captain" or EventBoss.Name == "Coyote" or EventBoss.Name == "The One" or EventBoss.Name == "Ascended Vampire" then
            game:GetService("StarterGui"):SetCore("SendNotification", { 
                Title = "Spawn Notif",
                Text = EventBoss.Name .. " has spawned!",
                Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
            })
            --print(EventBoss.Name .. " has spawned on " .. timestamp)
        elseif EventWeb.Name == "MeteorHitbox" then
            game:GetService("StarterGui"):SetCore("SendNotification", { 
                Title = "Spawn Notif",
                Text = EventBoss.Name .. " Event!",
                Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
            })
        end
    end)
end)

local WebGroup = Tabs.Misc:AddLeftGroupbox("Webhook Notifier")
    
WebGroup:AddButton("Event", function() 
    Interactables.ChildAdded:Connect(function(interactables)
        webhookC(interactables.Name)
    end)

    Alive.ChildAdded:Connect(function(EventWeb)
        if EventWeb.Name == "Flower Captain" or EventWeb.Name == "Coyote" or EventWeb.Name == "The One" or EventWeb.Name == "Ascended Vampire" then
            webhook(EventWeb.Name)
        elseif EventWeb.Name == "MeteorHitbox" then
            webhookC("Meteor")
        end
    end)
end)

WebGroup:AddButton("Valuable Loot", function() 
    Loot.ChildAdded:Connect(function(loot)
        if loot.Name ~= "Coins" or loot.Name ~= "Gems" or loot.Name ~= "Arrow" or loot.Name ~= "Rokaka" then
            webhookL(loot.Name)
        end
    end)
end)

WebGroup:AddButton("Loot", function() 
    Loot.ChildAdded:Connect(function(loot)
        webhookL(loot.Name)
    end)
end)

local idkGroup = Tabs.Misc:AddRightGroupbox("Useful (???)")

local SkipTutorial = idkGroup:AddButton("Skip Tutorial", function() 
    Remotes.TutorialCompleted:FireServer()
end)

local FullBright = idkGroup:AddButton("Full Bright", function() 
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
	Lighting.FogEnd = 100000
	Lighting.GlobalShadows = false
	Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)

local NoFog = idkGroup:AddButton("No Fog", function() 
    Lighting.FogEnd = 100000
    for i,v in pairs(Lighting:GetDescendants()) do
        if v:IsA("Atmosphere") then
            v:Destroy()
        end
    end
end)

local LowPlayerHop = idkGroup:AddButton("Low Player Hop", function() 
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
end)

SkipTutorial:AddTooltip('Start the game after pressing this button')
FullBright:AddTooltip('Full Brightooooo')
NoFog:AddTooltip("Removes Fog")
LowPlayerHop:AddTooltip("Server Hop on Low Player Server")

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' }) 

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('Levia')
ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:SetLibrary(Library)
-- SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
SaveManager:IgnoreThemeSettings() 
SaveManager:SetFolder('Levia/'.. game.PlaceId)
SaveManager:BuildConfigSection(Tabs['UI Settings'])

function ClearESP(espname)
    for _,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == espname and v:isA('BillboardGui') then
            v:Destroy()
        end
    end
end


function convert2rgb(red, green, blue)
    local color = Color3.fromHSV(red, green, blue)
    local r,g,b = math.floor((color.R*255)+0.5),math.floor((color.G*255)+0.5),math.floor((color.B*255)+0.5)
    
    return Format(r) .. ", " .. Format(g) .. ", " .. Format(b)
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

function Custom_Create(base, name, trackername, studs, color)
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
    txtlbl.TextColor3 = color

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

function webhook(Mob)
    local url = "https://discord.com/api/webhooks/968028466031239188/bk4TUshMXeXvkmpqRNRJvNJdYUC3gVYGr88fOtQaiy0ujQQ6Tz4VNTb_TeHJOWjHWYgR"
    local data = {
   --["content"] = " message(no embed)- you can take out embed if by deleting the bottom stuff(where it says EMBEDS)",
        ["embeds"] = {
            {
                ["title"] = "**Event Spawned**",
                ["description"] = nil,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da),
		        ["thumbnail"] = {
			        ["url"] = "https://tr.rbxcdn.com/e6ffdd59622416f22415ca53688d6f9a/768/432/Image/Png"
		        },
                ["fields"] = {
					{
                        ["name"] = "Event Spawn",
                        ["value"] = Mob,
                        ["inline"] = true
					}
                },
                ["footer"] = {
                        ["text"] = "Anime Story " ..tostring(os.date("%H:%M "))..tostring(os.date("%B %d, %Y "))
                }
            }
        }
    }
    
    local newdata = game:GetService("HttpService"):JSONEncode(data)

    local headers = {
        ["content-type"] = "application/json"
    }

    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end

function webhookC(CustomName)
    local url = "https://discord.com/api/webhooks/968028466031239188/bk4TUshMXeXvkmpqRNRJvNJdYUC3gVYGr88fOtQaiy0ujQQ6Tz4VNTb_TeHJOWjHWYgR"
    local data = {
   --["content"] = " message(no embed)- you can take out embed if by deleting the bottom stuff(where it says EMBEDS)",
        ["embeds"] = {
            {
                ["title"] = "**Event Spawned**",
                ["description"] = nil,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da),
		        ["thumbnail"] = {
			        ["url"] = "https://tr.rbxcdn.com/e6ffdd59622416f22415ca53688d6f9a/768/432/Image/Png"
		        },
                ["fields"] = {
					{
                        ["name"] = "Event Spawn",
                        ["value"] = CustomName,
                        ["inline"] = true
					}
                },
                ["footer"] = {
                        ["text"] = "Anime Story " ..tostring(os.date("%H:%M "))..tostring(os.date("%B %d, %Y "))
                }
            }
        }
    }
    
    local newdata = game:GetService("HttpService"):JSONEncode(data)

    local headers = {
        ["content-type"] = "application/json"
    }

    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end

function webhookL(CustomName)
    local url = "https://discord.com/api/webhooks/968028466031239188/bk4TUshMXeXvkmpqRNRJvNJdYUC3gVYGr88fOtQaiy0ujQQ6Tz4VNTb_TeHJOWjHWYgR"
    local data = {
   --["content"] = " message(no embed)- you can take out embed if by deleting the bottom stuff(where it says EMBEDS)",
        ["embeds"] = {
            {
                ["title"] = "**Loot Spawned**",
                ["description"] = nil,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da),
		        ["thumbnail"] = {
			        ["url"] = "https://tr.rbxcdn.com/e6ffdd59622416f22415ca53688d6f9a/768/432/Image/Png"
		        },
                ["fields"] = {
					{
                        ["name"] = "Loot Spawn",
                        ["value"] = CustomName,
                        ["inline"] = true
					}
                },
                ["footer"] = {
                        ["text"] = "Anime Story " ..tostring(os.date("%H:%M "))..tostring(os.date("%B %d, %Y "))
                }
            }
        }
    }
    
    local newdata = game:GetService("HttpService"):JSONEncode(data)

    local headers = {
        ["content-type"] = "application/json"
    }

    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end

task.spawn(function()
    while task.wait() do
        if Settings.AutoMine then
            pcall(function()
                for i,v in ipairs(Interactables.Ores:GetDescendants()) do
                    if v:IsA("ProximityPrompt") and Player:DistanceFromCharacter(v.Parent.Position) <= 30 then
                        fireproximityprompt(v)
                    else
                        continue
                    end
                end
            end)
        end
        if Settings.AutoM1 then
            pcall(function()
                Player.Backpack.PlayerControls.Attack:FireServer("M1")
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
        if Settings.SSA then
            pcall(function()
                Player.DataFolder["Dev_Products"].SkipAnimation.Value = true
            end)
        else
            Player.DataFolder["Dev_Products"].SkipAnimation.Value = false
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
                for i,v in ipairs(Interactables.Ores:GetChildren()) do
                    if v.Name == "Rune" or v.Name == "Magic Gem" or v.Name == "Blessed Gem" then
                        local studs = Player:DistanceFromCharacter(v.Rock.Position)
                        Simple_Create(v.Rock, v.Name, "ValOre_Tracker", math.floor(studs + 0.5))
                    end
                end
                for i,v in ipairs(Interactables.Ores:GetChildren()) do
                    if (v.Name ~= "Rune" and v:FindFirstChild("IOreH")) or (v.Name ~= "Magic Gem" and v:FindFirstChild("IOreH")) or (v.Name ~= "Blessed Gem" and v:FindFirstChild("IOreH")) then
                        v.IOreH:Destroy()
                    end
                end
                for i,v in ipairs(Interactables.Ores:GetChildren()) do
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
                for i,v in ipairs(Interactables.Ores:GetChildren()) do
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
                for i,v in ipairs(Interactables.Ores:GetChildren()) do
                    local studs = Player:DistanceFromCharacter(v.Rock.Position)
                    Simple_Create(v.Rock, v.Name, "Ore_Tracker", math.floor(studs + 0.5))
                end
            end)
        else
            ClearESP("Ore_Tracker")
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Loots.Coins then
            pcall(function()
                ClearESP("Coins_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
                    if v.Name == "Coins" then
                        local studs = Player:DistanceFromCharacter(v.Main.Position)
                        Custom_Create(v.Main, v.Name, "Coins_Tracker", math.floor(studs + 0.5), Settings.CoinsColor)
                    end
                end
            end)
        else
            ClearESP("Coins_Tracker")
        end
        if Loots.Gems then
            pcall(function()
                ClearESP("Gems_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
                    if v.Name == "Gems" then
                        local studs = Player:DistanceFromCharacter(v.Main.Position)
                        Custom_Create(v.Main, v.Name, "Gems_Tracker", math.floor(studs + 0.5), Settings.GemsColor)
                    end
                end
            end)
        else
            ClearESP("Gems_Tracker")
        end
        if Loots.Arrow then
            pcall(function()
                ClearESP("Arrow_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
                    if v.Name == "Arrow" then
                        local studs = Player:DistanceFromCharacter(v.Main.Position)
                        Custom_Create(v.Main, v.Name, "Arrow_Tracker", math.floor(studs + 0.5), Settings.ArrowColor)
                    end
                end
            end)
        else
            ClearESP("Arrow_Tracker")
        end
        if Loots.Rokaka then
            pcall(function()
                ClearESP("Rokaka_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
                    if v.Name == "Rokaka" then
                        local studs = Player:DistanceFromCharacter(v.Main.Position)
                        Custom_Create(v.Main, v.Name, "Rokaka_Tracker", math.floor(studs + 0.5), Settings.RokakaColor)
                    end
                end
            end)
        else
            ClearESP("Rokaka_Tracker")
        end
        if Loots.Adamantite then
            pcall(function()
                ClearESP("Adamantite_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
                    if v.Name == "Adamantite" then
                        local studs = Player:DistanceFromCharacter(v.Main.Position)
                        Custom_Create(v.Main, v.Name, "Adamantite_Tracker", math.floor(studs + 0.5), Settings.AdamColor)
                    end
                end
            end)
        else
            ClearESP("Adamantite_Tracker")
        end
        if Loots.GoldenCore then
            pcall(function()
                ClearESP("GoldenCore_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
                    if v.Name == "Golden Core" then
                        local studs = Player:DistanceFromCharacter(v.Main.Position)
                        Custom_Create(v.Main, v.Name, "GoldenCore_Tracker", math.floor(studs + 0.5), Settings.CoreColor)
                    end
                end
            end)
        else
            ClearESP("GoldenCore_Tracker")
        end
        if Loots.DevilFruit then
            pcall(function()
                ClearESP("DevilFruit_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
                    if v.Name == "Devil Fruit" then
                        local studs = Player:DistanceFromCharacter(v.Main.Position)
                        Custom_Create(v.Main, v.Name, "DevilFruit_Tracker", math.floor(studs + 0.5), Settings.DFColor)
                    end
                end
            end)
        else
            ClearESP("DevilFruit_Tracker")
        end
        if Loots.RequiemArrow then
            pcall(function()
                ClearESP("RequiemArrow_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
                    if v.Name == "Requiem Arrow" then
                        local studs = Player:DistanceFromCharacter(v.Main.Position)
                        Custom_Create(v.Main, v.Name, "RequiemArrow_Tracker", math.floor(studs + 0.5), Settings.ReqColor)
                    end
                end
            end)
        else
            ClearESP("RequiemArrow_Tracker")
        end
        if Loots.DragonBall then
            pcall(function()
                ClearESP("DragonBall_Tracker")
                for i,v in ipairs(game:GetService("Workspace").Loot:GetChildren()) do
                    if v.Name == "Dragon Ball" then
                        local studs = Player:DistanceFromCharacter(v.Main.Position)
                        Custom_Create(v.Main, v.Name, "DragonBall_Tracker", math.floor(studs + 0.5), Settings.DBColor)
                    end
                end
            end)
        else
            ClearESP("DragonBall_Tracker")
        end
    end
end)

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        syn.queue_on_teleport([[repeat task.wait() until game:IsLoaded() wait(5) print("ServerHoped or rejoined") loadstring(game:HttpGet("https://raw.githubusercontent.com/Levi4Chan/Rblx-Scripts/main/AnimeStory.lua"))()]])
    end
end)
