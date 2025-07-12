-- Carrega Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

-- Cria Janela
local Window = OrionLib:MakeWindow({
    Name = "NovaZHub | Raise a c00lkidd",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "NovaZHub-c00lkidd"
})

-- Cria Aba Principal
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Variáveis
local AutoClick = false
local AutoCollect = false

-- Toggle Auto Click
MainTab:AddToggle({
    Name = "🤖 Auto Click no bebê",
    Default = false,
    Callback = function(Value)
        AutoClick = Value
        if AutoClick then
            task.spawn(function()
                while AutoClick do
                    local c00lkidd = workspace:FindFirstChild("c00lkidd")
                    if c00lkidd then
                        local click = c00lkidd:FindFirstChildWhichIsA("ClickDetector", true)
                        if click then
                            fireclickdetector(click)
                        end
                    end
                    task.wait(0.2)
                end
            end)
        end
    end
})

-- Toggle Auto Coletar Dinheiro
MainTab:AddToggle({
    Name = "🤑 Auto Coletar Dinheiro",
    Default = false,
    Callback = function(Value)
        AutoCollect = Value
        if AutoCollect then
            task.spawn(function()
                while AutoCollect do
                    for _,obj in pairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("money") or obj.Name:lower():find("cash") then
                            pcall(function()
                                obj.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            end)
                        end
                    end
                    task.wait(0.3)
                end
            end)
        end
    end
})

-- Creditos (opcional)
MainTab:AddParagraph("NovaZHub", "Feito por Carlos com ajuda da IA 🔥")
