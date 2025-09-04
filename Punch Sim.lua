local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/Levi4Chan/Lib/refs/heads/main/Mercury%20Lib/source.lua"))()

local GUI = Mercury:Create{
    Name = "Mercury",
    Size = UDim2.fromOffset(600, 400),
    Theme = self.Themes.Dark,
    Link = "https://github.com/Levi4Chan"
}

local Tab = GUI:Tab{
	Name = "Main",
	Icon = "rbxassetid://8569322835"
}

Tab:Button{
	Name = "Punch Sim (Tora)",
	Description = nil,
	Callback = function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JustAP1ayer/PlayerHubOther/main/PlayerHubPunchingSimulator.lua", true))()
    end
}

Tab:Textbox{
    Name = "Wave to Stop",
	Placeholder = "Type something..",
	Description = nil,
	Callback = function(t) 
        getgenv().DunPlace = t
    end
}

Tab:Toggle{
	Name = "Auto Start Dungeon",
	StartingState = false,
	Description = nil,
	Callback = function(state) 
        getgenv().DungeonTog = state
		if getgenv().DungeonTog then game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer("StartDungeon")
    end
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

--[[Tab:Dropdown{
	Name = "Dropdown",
	StartingText = "Select...",
	Description = nil,
	Items = {},
	Callback = function(item) return end
}

Tab:Slider{
	Name = "Slider",
	Default = 50,
	Min = 0,
	Max = 100,
	Callback = function() end
}

Tab:Keybind{
	Name = "Keybind",
	Keybind = nil,
	Description = nil
}

GUI:Prompt{
	Followup = false,
	Title = "Prompt",
	Text = "Prompts are cool",
	Buttons = {
		ok = function()
			return true
		end
		no = function()
			return false
		end
	}
}

GUI:Notification{
	Title = "Alert",
	Text = "You shall bump the thread on V3rmillion!",
	Duration = 3,
	Callback = function() end
}

GUI:ColorPicker{
	Style = Library.ColorPickerStyles.Legacy,
	Callback = function(color) end
}

GUI:Credit{
	Name = "Creditor's name",
	Description = "Helped with the script",
	V3rm = "link/name",
	Discord = "helo#1234"
}
]]
