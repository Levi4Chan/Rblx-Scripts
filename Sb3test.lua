local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/mercury-lib-edit/master/src.lua"))()

local GUI = Library:Create{
    Name = "SwordBurst 3",
    Size = UDim2.fromOffset(600, 400),
    Theme = Library.Themes.Serika,
    Link = "https://github.com/deeeity/mercury-lib"
}

local tab = GUI:tab{
    Name = "Main",
    Icon = "rbxassetid://2174510075" -- rbxassetid://2174510075 home icon
}

local funtab = GUI:tab{
    Name = "Misc",
    Icon = "rbxassetid://8569322835" -- rbxassetid://2174510075 home icon
}

local teleporttab = GUI:tab{
    Name = "Teleport",
    Icon = "rbxassetid://8569322835" -- rbxassetid://2174510075 home icon
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lplr = Players.LocalPlayer

local Stamina = require(game:GetService("ReplicatedStorage").Systems.Stamina)
local ItemList = require(ReplicatedStorage.Systems.Items.ItemList)

local mobs = {}
local mines = {}
local bosses = {}
local quests = {}
local waystone = {}
local swordburst = {}
local methods = {"above", "below", "behind"}
local category = {"Material", "Mount", "Cosmetic", "Pickaxe"}
local raritys = {"common (white)", "uncommon (green) and below", "rare (blue) and below", "epic (purple) and below", "legendary (orange) and below"}
local realrarity = {["common (white)"] = 1, ["uncommon (green) and below"] = 2, ["rare (blue) and below"] = 3, ["epic (purple) and below"] = 4, ["legendary (orange) and below"] = 5,}

local cd
local range
local dist

local mine
local boss
local rarity
local insert
local method
local waystones
local choosemob
local choosequest

local function getchar()
    return lplr.Character or lplr.CharacterAdded:Wait()
end

for i,v in next, workspace.BossArenas:GetChildren() do
    table.insert(bosses, v.Name)
end

for i,v in next, workspace.MobSpawns:GetChildren() do
    table.insert(mobs,v.Name)
end

for i,v in next, workspace.Waystones:GetChildren() do
    table.insert(waystone, v.Name)
end

for i,v in next, workspace.Ores:GetChildren() do
    insert = true
    for _,v2 in next, mines do
        if v2 == v.Name then
            insert = false
        end
    end
    if insert then
        table.insert(mines, v.Name)
    end
end

local Quest = require(game:GetService("ReplicatedStorage").Systems.Quests.QuestList)
for i,v in next, Quest do
    table.insert(quests, "Level " .. v.Level .. " " .. v.Target .. " " .. (v.Repeatable and "Repeatable" or ""))
end

for i, v in next, getconnections(lplr.Idled) do
    if v["Disable"] then
        v["Disable"](v)
    elseif v["Disconnect"] then
        v["Disconnect"](v)
    end
end


tab:Dropdown{
    Name = "Select Mobs",
    StartingText = "Select...",
    Description = nil,
    Items = mobs,
    Callback = function(item)
        choosemob = item
    end
}

tab:Dropdown{
    Name = "Farm Method",
    StartingText = "Select...",
    Description = nil,
    Items = methods,
    Callback = function(item)
        method = item
    end
}

tab:TextBox{
	Name = "Farm Distance",
	Description = "Max is only 50",
	Callback = function(Value)
		dist = tonumber(Value)
	end
}

--[[tab:Slider{
	Name = "Auto Farm Distance",
	Default = 25,
	Min = 1,
	Max = 50,
	Callback = function(Value) 
		dist = Value
	end
}
]]

tab:Toggle{
    Name = "Auto Farm Mobs",
    StartingState = false,
    Description = nil,
    Callback = function(state)
        swordburst["automobs"] = state
    end
}

tab:Dropdown{
    Name = "Select Boss",
    StartingText = "Select...",
    Description = nil,
    Items = bosses,
    Callback = function(item)
        boss = item
    end
}

tab:Toggle{
    Name = "Auto Farm Boss",
    StartingState = false,
    Description = nil,
    Callback = function(state)
        swordburst["autoboss"] = state
    end
}

tab:Toggle{
    Name = "Kill Aura",
    StartingState = false,
    Description = "doesnt work with killaura for players",
    Callback = function(state)
        swordburst["killaura"] = state
    end
}

tab:Toggle{
    Name = "Kill Aura for Players",
    StartingState = false,
    Description = "turn on pvp and doesnt work with killaura ",
    Callback = function(state)
        swordburst["killauraplr"] = state
    end
}

tab:Toggle{
    Name = "Auto Collect",
    StartingState = false,
    Description = nil,
    Callback = function(state)
        swordburst["autocollect"] = state
    end
}

tab:Dropdown{
    Name = "Select Quest",
    StartingText = "Select...",
    Description = nil,
    Items = quests,
    Callback = function(item)
        choosequest = item
    end
}

tab:Toggle{
    Name = "Auto Quest",
    StartingState = false,
    Description = nil,
    Callback = function(state)
        swordburst["autoquest"] = state
    end
}

tab:Dropdown{
    Name = "Select Ores",
    StartingText = "Select...",
    Description = nil,
    Items = mines,
    Callback = function(item)
        mine = item
    end
}


tab:Toggle{
    Name = "Auto Mine Ores" ,
    StartingState = false,
    Description = nil,
    Callback = function(state)
        swordburst["automine"] = state
        if swordburst["automine"] and mine then
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Equipment"):WaitForChild("EquipTool"):FireServer("Pickaxe", true) 
        end
    end
}

teleporttab:Dropdown{
    Name = "Select Waystones",
    StartingText = "Select...",
    Description = nil,
    Items = waystone,
    Callback = function(item)
        waystones = item
    end
}

teleporttab:Button{
    Name = "Teleport Waystones",
    Description = nil,
    Callback = function()
        if waystones and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
            for i,v in next, workspace.Waystones:GetChildren() do
                if v.Name == waystones then
                    getchar().HumanoidRootPart.CFrame = v.Main.CFrame * CFrame.new(0,0,5)
                end
            end
        end
    end
}

funtab:Button{
    Name = "Infinite Stamina",
    Description = nil,
    Callback = function()
        debug.setupvalue(Stamina.SetMaxStamina,1,99999999)
        debug.setupvalue(Stamina.CanUseStamina,1, 99999999)
    end
}

funtab:Dropdown{
    Name = "Select Rarity",
    StartingText = "Select...",
    Description = nil,
    Items = raritys,
    Callback = function(item)
        rarity = item
    end
}

funtab:Button{
    Name = "Dismantle Selected rarity",
    Description = nil,
    Callback = function()
        if rarity then
            for i,v in next, ItemList do
                if v.Rarity and v.Rarity <= realrarity[rarity] and not table.find(category, v.Category) then
                    for _,items in next, ReplicatedStorage.Profiles[lplr.Name].Inventory:GetChildren() do
                        if string.find(i, items.Name) then
                            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Crafting"):WaitForChild("Dismantle"):FireServer(items)
                            task.wait()
                        end
                    end
                end
            end
        end
    end
}

GUI:Credit{
    Name = "x3Fall3nAngel",
    Description = "Made the script",
    V3rm = "",
    Discord = "https://discord.gg/b9QX5rnkT5"
}

local function methodss()
    if method and dist then
        if method == "above" then
            return CFrame.new(0, dist, 0)
        elseif method == "below" then
            return CFrame.new(0, -dist,0)
        elseif method == "behind" then
            return CFrame.new(0,0, dist)
        end
    end
end

local function getclosestmobs(mob)
    local distance = math.huge
    local target
    local multitarget = {}
    for i,v in next, workspace.Mobs:GetChildren() do
        if v:FindFirstChild("HumanoidRootPart") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
            local magnitude = (getchar().HumanoidRootPart.Position - v:FindFirstChild("HumanoidRootPart").Position).magnitude
            if mob and string.find(v.Name, mob) then
                if magnitude < distance then
                    target = v
                    distance = magnitude
                end
            end
            if magnitude < 100 then
                table.insert(multitarget, v)
            end
        end
    end
    return target , multitarget
end

local function getplr() 
    local distance = 100
    local target = {}
    for i,v in next, Players:GetPlayers() do
        if v ~= lplr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
            local magnitude = (getchar().HumanoidRootPart.Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude
            if magnitude < distance then
                table.insert(target, v.Character)
            end
        end
    end
    return target
end

local function getores()
    local distance = math.huge
    local target
    for i,v in next, workspace.Ores:GetChildren() do
        if v.Name == mine and getchar() and getchar():FindFirstChild("HumanoidRootPart") and v:FindFirstChildWhichIsA("MeshPart").CFrame then
            local magnitude = (getchar().HumanoidRootPart.Position - v:FindFirstChildWhichIsA("MeshPart").Position).magnitude
            if magnitude < distance then
                target = v
                distance = magnitude
            end
        end
    end
    return target
end

local function getquest(chosequest) 
    for i,v in next, Quest do
        if string.find("Level " .. v.Level .. " " .. v.Target  .. " " .. (v.Repeatable and "Repeatable" or "") , chosequest) then
            return i
        end
    end
    return
end

task.spawn(function()
    while task.wait() do
        if swordburst["automobs"] and choosemob or swordburst["mobs"] and choosemob then
            local enemy = getclosestmobs(choosemob)
            if getchar() and getchar():FindFirstChild("HumanoidRootPart") and enemy and enemy:FindFirstChild("HumanoidRootPart") then
                getchar().HumanoidRootPart.CFrame = enemy:FindFirstChild("HumanoidRootPart").CFrame * methodss()
            end
        end 
    end
end)

task.spawn(function()
    while task.wait() do
        if swordburst["autoboss"] then
            if getchar() and getchar():FindFirstChild("HumanoidRootPart") and boss then
                local enemy = getclosestmobs(boss)
                if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                    swordburst["automobs"] = false
                    getchar().HumanoidRootPart.CFrame = enemy:FindFirstChild("HumanoidRootPart").CFrame * methodss()
                else
                    for i,v in next, workspace.BossArenas:GetChildren() do
                        if string.find(v.Name, boss) and string.find(v.Spawn.ArenaBillboard.Frame.StatusLabel.Text, "Boss Cooldown") then
                            local e = string.sub(v.Spawn.ArenaBillboard.Frame.StatusLabel.Text,16,18)
                            local spawntime = string.split(e, ")")[1]
                            if tonumber(spawntime) and tonumber(spawntime) <= 1 then
                                swordburst["mobs"] = false
                                getchar().HumanoidRootPart.CFrame = v:FindFirstChild("Spawn").CFrame 
                            else
                                swordburst["mobs"] = true
                            end
                        end
                    end
                end
            end
        else
            swordburst["mobs"] = false
        end 
    end
end)

task.spawn(function()
    while task.wait(.3) do
	local totalenemy = {}
        local enemy,multienemy = getclosestmobs()
	if swordburst["killaura"] and #multienemy >= 1 then
            for i,v in next, multienemy do
                table.insert(totalenemy, v)
            end
        end
        if swordburst["killauraplr"] and getplr() then
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Combat"):WaitForChild("PlayerAttack"):FireServer(getplr())
        end
        if #totalenemy >= 1 then
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Combat"):WaitForChild("PlayerAttack"):FireServer(totalenemy)
        end
    end
end)

task.spawn(function()
    while task.wait(.5) do
        for i,v in next, lplr.PlayerGui.SkillBar.Frame:GetChildren() do
            if v:FindFirstChild("Hotkey") then
                local totalenemy = {}
                local e = choosemob or boss
                local enemy,multienemy = getclosestmobs(e)
                if swordburst["killaura"] and #multienemy >= 1 then
                    for i,v in next, multienemy do
                        table.insert(totalenemy, v)
                    end
                end
                if swordburst["killauraplr"] and #getplr() >= 1 then
                    for i,v in next, getplr() do
                        table.insert(totalenemy,v)
                    end
                end
                if #totalenemy >= 1 then
                    ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Skills"):WaitForChild("UseSkill"):FireServer(v.Name)
                    for i = 1, 8 do
                        ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Combat"):WaitForChild("PlayerSkillAttack"):FireServer(totalenemy, v.Name, i)
                    end     
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        if swordburst["autocollect"] then
            for i,v in next, ReplicatedStorage.Drops:GetChildren() do
                if v:GetAttributes("Owner").Owner == lplr.Name then
                    ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Drops"):WaitForChild("Pickup"):FireServer(v)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if swordburst["autoquest"] and choosequest then
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Quests"):WaitForChild("AcceptQuest"):FireServer(getquest(choosequest))
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Quests"):WaitForChild("CompleteQuest"):FireServer(getquest(choosequest))
        end
    end
end)

task.spawn(function()
    while task.wait(.3) do
        if swordburst["automine"] and mine then
            if getores() and getores():FindFirstChildWhichIsA("MeshPart") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
                getchar():FindFirstChild("HumanoidRootPart").CFrame =  getores():FindFirstChildWhichIsA("MeshPart").CFrame * CFrame.new(0,3,0)
                ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Equipment"):WaitForChild("EquipTool"):FireServer("Pickaxe", true) 
                ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Mining"):WaitForChild("Mine"):FireServer()
            end
        end
    end
end)
