local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/Levi4Chan/Lib/refs/heads/main/Mercury%20Lib/source.lua"))()

local GUI = Mercury:Create{
    Name = "Mercury",
    Size = UDim2.fromOffset(600, 400),
    Link = "https://github.com/deeeity/mercury-lib"
}

local Tab = GUI:Tab{
	Name = "Main",
	Icon = "rbxassetid://8569322835"
}

Tab:Button{
	Name = "TP to Megalodon",
	Description = nil,
	Callback = function()
        local root = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("BasePart")
        for _, v in next, workspace.zones.fishing:GetChildren() do
			if v.Name == "Megalodon Default" then
				root.CFrame = v.CFrame + Vector3.new(0, 5, 0)
				break
			end
		end
	end
}

Tab:Button{
	Name = "TP to Ancient Megalodon",
	Description = nil,
	Callback = function()
        local root = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("BasePart")
        for _, v in next, workspace.zones.fishing:GetChildren() do
			if v.Name == "Megalodon Ancient" then
				root.CFrame = v.CFrame + Vector3.new(0, 5, 0)
				break
			end
		end
	end
}

Tab:Button{
	Name = "Step all Pressure Plates",
	Description = nil,
	Callback = function() 
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("TouchTransmitter") and v.Name == "PressurePlate" or v.Parent.Name == "PressurePlate" then
				touch(v)
			end
        end
	end
}

Tab:Toggle{
	Name = "Auto Buy Lantern",
	StartingState = false,
	Description = nil,
	Callback = function(state) 
    getgenv().AutoLantern = state
  end
}

game:GetService("RunService").Heartbeat:Connect(function()
	while getgenv().AutoLantern do
                workspace.world.npcs["Latern Keeper"].lantern.purchase:InvokeServer()
                task.wait()
        end
end)
