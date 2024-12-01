local root = game.Players.LocalPlayer.Character.HumanoidRootPart

for _, v in next, workspace.zones.fishing:GetChildren() do
    if v.Name == "Megalodon Default" or v.Name == "Megalodon Ancient" then
        root.CFrame = v.CFrame + Vector3.new(0, 5, 0)
        break
    end
end
