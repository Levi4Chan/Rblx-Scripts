local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/Levi4Chan/Lib/refs/heads/main/Mercury%20Lib/source.lua"))()

local button = game:GetService("Players").LocalPlayer.PlayerGui.DungeonFinishUI.Frame.ClaimButton
local events = {"MouseButton1Click", "MouseButton1Down", "Activated"}

local GUI = Mercury:Create{
    Name = "Mercury",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

local Tab = GUI:Tab{
	Name = "New Tab",
	Icon = "rbxassetid://8569322835"
}

Tab:Button{
	Name = "Button",
	Description = nil,
	Callback = function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JustAP1ayer/PlayerHubOther/main/PlayerHubPunchingSimulator.lua", true))()
    end
}

Tab:Textbox{
	Name = "Wave to Stop",
	Callback = function(text) 
        getgenv().DunPlace = text
    end
}

Tab:Toggle{
	Name = "Toggle",
	StartingState = false,
	Description = nil,
	Callback = function(state) 
        getgenv().DungeonTog = state
		if getgenv().DungeonTog then 
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer("StartDungeon")
        end
    end
}

GUI:Credit{
	Name = "Creditor's name",
	Description = "Helped with the script",
	V3rm = "link/name",
	Discord = "helo#1234"
}

task.spawn(function()
    while task.wait() do
	    if getgenv().DungeonTog then
	    --print("Stopping on " .. "Wave: " .. tostring(getgenv().DunPlace))
            if game:GetService("Players").LocalPlayer.PlayerGui.DungeonMain.Frame.Wave.WaveNumber.Text ~= "Wave: " .. tostring(getgenv().DunPlace) then
                repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.DungeonMain.Frame.Wave.WaveNumber.Text == "Wave: " .. tostring(getgenv().DunPlace)
                task.wait(2)
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer("Exit")
                task.wait(5)
                for i,v in pairs(events) do
                    for i,v in pairs(getconnections(button[v])) do
                        v:Fire()
                    end
                end
                task.wait(8)
		        if getgenv().DungeonTog then
                	game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer("StartDungeon")
		        end
            end
        end
    end
end)
