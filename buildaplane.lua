-- Carregar Rayfield (Sirius)
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local AutoFarm = false

-- Criar Janela
local Window = Rayfield:CreateWindow({
    Name = "NovaZHub| Auto Farm  💀",
    LoadingTitle = "Build a plane Hub",
    LoadingSubtitle = "NovaZHub",
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

-- Aba 'Grup' com links para grupos do WhatsApp
local GrupTab = Window:CreateTab("Grup", 4483362458)

GrupTab:CreateButton({
    Name = "Grupo WhatsApp 🇧🇷 Comunidade BR",
    Callback = function()
        setclipboard("https://chat.whatsapp.com/C54lAZeVHDb2lRfFGKZGUm?mode=ac_t")
        Rayfield:Notify({
            Title = "Link BR Copiado!",
            Content = "Abra o navegador e cole o link para entrar no grupo BR.",
            Duration = 5
        })
    end,
})

GrupTab:CreateButton({
    Name = "Grupo WhatsApp 🇺🇸 USA Community",
    Callback = function()
        setclipboard("https://chat.whatsapp.com/EnnQ58Rt7bvDzHA8LXu7ZE?mode=ac_t")
        Rayfield:Notify({
            Title = "USA Link Copied!",
            Content = "Open your browser and paste the link to join the USA group.",
            Duration = 5
        })
    end,
})
