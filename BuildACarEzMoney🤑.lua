-- NovaZHub | Build a Car
-- Feito por Script Creator 💀👍

-- Introdução
print("Thank you very much for using NovaZHub Script")
print("Made by a Script Creator 💀👍")

game.StarterGui:SetCore("SendNotification", {
    Title = "NovaZHub",
    Text = "Thank you very much for using NovaZHub Script\nMade by a Script Creator 💀👍",
    Duration = 6
})

-- Espera a introdução terminar
task.wait(6)

-- Script principal (loop infinito)
while true do
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")

    local SpawnRemote = workspace:WaitForChild("__THINGS"):WaitForChild("__REMOTES"):WaitForChild("vehicle_spawn")
    local StopRemote = workspace:WaitForChild("__THINGS"):WaitForChild("__REMOTES"):WaitForChild("vehicle_stop")

    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    -- Spawnar veículo
    SpawnRemote:InvokeServer()

    task.wait(0.2)
    print("te𝗅epörting")
    character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(9000000000e9, 90000000000e9, 9000000000e9)
    print("döne")
    task.wait(0.2)

    -- Parar veículo
    StopRemote:InvokeServer()
    task.wait(0.5)
end
