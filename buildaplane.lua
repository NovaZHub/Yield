-- Carregar Rayfield (Sirius)
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local AutoFarm = false
local AutoBuyItens = false

-- Criar Janela
local Window = Rayfield:CreateWindow({
    Name = "NovaZHub | Auto Farm 💀",
    LoadingTitle = "Build a Plane Hub",
    LoadingSubtitle = "NovaZHub",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BABFT_AutoFarm",
        FileName = "AutoFarmRayfield"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Aba principal
local MainTab = Window:CreateTab("Main", 4483362458)

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

-- Aba Itens
local ItensTab = Window:CreateTab("Itens", 4483362458)

ItensTab:CreateToggle({
    Name = "Auto Buy Todos os Itens 🧱",
    CurrentValue = false,
    Flag = "AutoBuyItensToggle",
    Callback = function(Value)
        AutoBuyItens = Value

        if AutoBuyItens then
            Rayfield:Notify({
                Title = "Auto Buy Ativado",
                Content = "Comprando itens repetidamente...",
                Duration = 5
            })

            task.spawn(function()
                while AutoBuyItens do
                    local items = {
                        "block_1", "wing_1", "fuel_1", "propeller_1", "seat_1", "fuel_2",
                        "wing_2", "fuel_3", "propeller_2", "balloon", "boost_1",
                        "missile_1", "shield"
                    }

                    for _, item in ipairs(items) do
                        local args = {item}
                        local success, err = pcall(function()
                            game:GetService("ReplicatedStorage")
                                :WaitForChild("Remotes")
                                :WaitForChild("ShopEvents")
                                :WaitForChild("BuyBlock")
                                :FireServer(unpack(args))
                        end)
                        if not success then
                            warn("Erro ao comprar item:", err)
                        end
                        task.wait(0.1)
                    end

                    task.wait(1)
                end
            end)
        else
            Rayfield:Notify({
                Title = "Auto Buy Desativado",
                Content = "Parado de comprar itens.",
                Duration = 4
            })
        end
    end
})

-- Aba Blood Moon
local BloodMoonTab = Window:CreateTab("Blood Moon", 4483362458)

local AutoBloodMoon = false
local r = game:GetService("ReplicatedStorage").Remotes

BloodMoonTab:CreateToggle({
    Name = "Auto GET Inf Blood coin and spin",
    CurrentValue = false,
    Flag = "AutoBloodMoonToggle",
    Callback = function(Value)
        AutoBloodMoon = Value

        if AutoBloodMoon then
            Rayfield:Notify({
                Title = "Blood Moon Ativado",
                Content = "Auto GET Inf Blood coin and spin ligado.",
                Duration = 5
            })

            -- Spawn Evil Eye e Kill Evil Eye em paralelo
            task.spawn(function()
                for i = 1, 303 do
                    task.spawn(function()
                        while AutoBloodMoon do
                            task.wait()
                            pcall(function()
                                r.EventEvents.SpawnEvilEye:InvokeServer()
                                r.EventEvents.KillEvilEye:InvokeServer()
                            end)
                        end
                    end)
                end
            end)

            -- Purchase Spin e Perform Spin em paralelo
            task.spawn(function()
                for i = 1, 80 do
                    task.spawn(function()
                        while AutoBloodMoon do
                            task.wait()
                            pcall(function()
                                r.SpinEvents.PurchaseSpin:InvokeServer()
                                r.SpinEvents.PerformSpin:InvokeServer()
                            end)
                        end
                    end)
                end
            end)
        else
            Rayfield:Notify({
                Title = "Blood Moon Desativado",
                Content = "Auto GET Inf Blood coin and spin desligado.",
                Duration = 4
            })
        end
    end
})
