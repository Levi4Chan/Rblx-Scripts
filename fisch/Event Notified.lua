local function onChildAdded(instance)
    if instance.Name == "Megalodon Default" then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "New Zone Added";
            Text =  "Megalodon has spawned.";
            Duration = 30;
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "New Zone Added";
            Text =  instance.Name .. " has spawned.";
            Duration = 30;
        })
    end
end

workspace.zones.fishing.ChildAdded:Connect(onChildAdded)
