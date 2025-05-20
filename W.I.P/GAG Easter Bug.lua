local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CandyClickGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
frame.BorderSizePixel = 0
frame.Draggable = true
frame.Active = true
frame.Selectable = true
frame.Parent = gui

local candyButton = Instance.new("TextButton")
candyButton.Size = UDim2.new(1, -20, 0, 60)
candyButton.Position = UDim2.new(0, 10, 0, 20)
candyButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
candyButton.Text = "🍬 Start Buying"
candyButton.TextColor3 = Color3.new(1, 1, 1)
candyButton.Font = Enum.Font.Cartoon
candyButton.TextSize = 22
candyButton.Parent = frame

local running = false
local loopConnection = nil

candyButton.MouseButton1Click:Connect(function()
    running = not running

    if running then
        candyButton.Text = "🛑 Stop Buying"

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local BuyEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyEventShopStock")
        local RunService = game:GetService("RunService")
        local counter = 0

        loopConnection = RunService.Heartbeat:Connect(function()
            if not running then
                loopConnection:Disconnect()
                candyButton.Text = "🍬 Start Buying"
                return
            end

            for _ = 1, 10 do
                BuyEvent:FireServer("Easter Egg")
                BuyEvent:FireServer("Chocolate Sprinkler")
                BuyEvent:FireServer("Candy Blossom")
                BuyEvent:FireServer("Red Lollipop")
                BuyEvent:FireServer("Candy Sunflower")
                BuyEvent:FireServer("Chocolate Carrot")
                BuyEvent:FireServer("Night Seed Pack")
                counter += 1
                if counter >= 1000000 then
                    running = false
                    break
                end
            end
        end)

    else
        candyButton.Text = "🍬 Start Buying"
    end
end)
