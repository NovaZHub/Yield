-- Carregar Rayfield (Sirius)
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local AutoFarm = false

-- Criar Janela
local Window = Rayfield:CreateWindow({
    Name = "NOVAZHUB| Build a Plane",
    LoadingTitle = "Build A Boat Hub",
    LoadingSubtitle = "By Carlos",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BABFT_AutoFarm", -- Salvar configs
        FileName = "AutoFarmRayfield"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Aba principal
local MainTab = Window:CreateTab("Main", 4483362458)

-- Toggle do Auto Farm
MainTab:CreateToggle({
    Name = "Ativar Auto Farm 💀",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        AutoFarm = Value

        if AutoFarm then
            Rayfield:Notify({
                Title = "Auto Farm Ativado",
                Content = "Farmando infinitamente...",
                Duration = 5
            })

            task.spawn(function()
                while AutoFarm do
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local Players = game:GetService("Players")

                    local LaunchRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LaunchEvents"):WaitForChild("Launch")
                    local ReturnRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LaunchEvents"):WaitForChild("Return")

                    local player = Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    LaunchRemote:FireServer()
                    task.wait(2)

                    if character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = CFrame.new(9000000000e9, 90000000000e9, 9000000000e9)
                    end

                    task.wait(2)
                    ReturnRemote:FireServer()
                    task.wait(3)
                end
            end)
        else
            Rayfield:Notify({
                Title = "Auto Farm Desativado",
                Content = "Farm parado!",
                Duration = 4
            })
        end
    end
})
