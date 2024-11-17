--// Services \\--
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")

--// Variables \\--
local Player = Players.LocalPlayer
local Enabled = false
local Mouse = Player:GetMouse()
local X, Y = 0, 0
local LastC = Color3.new(1, 0, 0)
local LastU = tick()

--// Exploit Fix \\--
if not pcall(function() return syn.protect_gui end) then
    syn = {}
    syn.protect_gui = function(A_1)
        A_1.Parent = CoreGui
    end
end

--// UI Library \\--
local Library = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Levi4Chan/AnotherScriptStore/main/Misc/ACLib.lua'))()
local Window = Library:CreateWindow("AutoClicker")
Enabled_1 = Window:AddColor({
    text = 'Status:',
    flag = "Levia4Chan",
    color = Color3.new(1, 0, 0),
    callback = function(A_1)
        local NewColor = Color3.new(0, 1, 0)
        if Enabled == false then
            NewColor = Color3.new(1, 0, 0)
        end
        if NewColor ~= Last or A_1 ~= NewColor then
            Last = NewColor
            Enabled_1:SetColor(NewColor)
        end
    end
})
Window:AddBind({
    text = 'Toggle',
    callback = function()
        getgenv().Enabled = false
        local NewColor = Color3.new(0, 1, 0)
        if getgenv().Enabled == false then
            NewColor = Color3.new(1, 0, 0)
        end
        if NewColor ~= Last then
            Last = NewColor
            Enabled_1:SetColor(NewColor)
        end
        if getgenv().Enabled then
            X, Y = Mouse.X, Mouse.Y + 10
            Box_1:SetValue()
        else
            X, Y = 0, 0
            Box_1:SetValue()
        end
    end
})
Box_1 = Window:AddBox({
    text = "AutoClick Position:",
    value = "X: " .. X .. ", Y: " .. Y,
    callback = function()
        if tick()-LastU > 0.1 then
            LastU = tick()
            Box_1:SetValue("X: " .. X .. ", Y: " .. Y)
        end
    end
})
Library:Init()

game:GetService("RunService").Heartbeat:Connect(function()
	local VU = game:GetService("VirtualUser")
	while getgenv().Enabled do
        	VU:CaptureController()
        	VU:ClickButton1(Vector2.new())
        	task.wait()
    	end
end)
