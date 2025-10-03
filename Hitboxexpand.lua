--// Carregar Rayfield (Sirius)
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Variáveis
local HitboxEnabled = false
local HitboxSize = Vector3.new(15,15,15)
local HitboxTransparency = 0.6
local HitboxColor = BrickColor.new("Really red")
local OriginalSizes = {}

-- Checar se é inimigo
local function IsEnemy(player)
    if player.Team and LocalPlayer.Team then
        return player.Team ~= LocalPlayer.Team
    elseif player.Team == nil or LocalPlayer.Team == nil then
        return true -- considera inimigo se não houver team definido
    end
    return false
end

-- Aplicar hitbox
local function ExpandHitbox(char)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if not OriginalSizes[char] then
        OriginalSizes[char] = hrp.Size
    end

    hrp.Size = HitboxSize
    hrp.Transparency = HitboxTransparency
    hrp.BrickColor = HitboxColor
    hrp.Material = Enum.Material.Neon
    hrp.CanCollide = false
end

-- Resetar hitbox
local function ResetHitbox(char)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if OriginalSizes[char] then
        hrp.Size = OriginalSizes[char]
    else
        hrp.Size = Vector3.new(2,2,1)
    end
    hrp.Transparency = 1
    hrp.CanCollide = false
    OriginalSizes[char] = nil
end

-- Aplicar em todos inimigos existentes
local function ApplyHitboxes()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsEnemy(player) and player.Character then
            ExpandHitbox(player.Character)
        end
    end
end

-- Conectar CharacterAdded para inimigos
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        if HitboxEnabled and IsEnemy(player) then
            char:WaitForChild("HumanoidRootPart")
            ExpandHitbox(char)
        end
    end)
end)

for _, player in pairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function(char)
        if HitboxEnabled and player ~= LocalPlayer and IsEnemy(player) then
            char:WaitForChild("HumanoidRootPart")
            ExpandHitbox(char)
        end
    end)
end

-- Loop inteligente: só aplica hitbox nos inimigos que ainda não estão expandidos
RunService.Heartbeat:Connect(function()
    if HitboxEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and IsEnemy(player) and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp and hrp.Size ~= HitboxSize then
                    ExpandHitbox(player.Character)
                end
            end
        end
    end
end)

-- GUI
local Window = Rayfield:CreateWindow({
    Name = "NovaZHub | Hitbox Expander Beta script",
    LoadingTitle = "NovaZHub",
    LoadingSubtitle = "by Carlos",
    ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main", 4483362458)

-- Toggle ON/OFF
MainTab:CreateToggle({
    Name = "Enable Hitbox Expander (Enemies Only)",
    CurrentValue = false,
    Flag = "HitboxToggle",
    Callback = function(Value)
        HitboxEnabled = Value
        if not Value then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    ResetHitbox(player.Character)
                end
            end
        else
            ApplyHitboxes()
        end
    end,
})

-- Slider tamanho
MainTab:CreateSlider({
    Name = "Hitbox Size",
    Range = {5,90},
    Increment = 1,
    Suffix = "Size",
    CurrentValue = 15,
    Flag = "HitboxSizeSlider",
    Callback = function(Value)
        HitboxSize = Vector3.new(Value,Value,Value)
    end,
})

-- Dropdown cor
MainTab:CreateDropdown({
    Name = "Hitbox Color",
    Options = {"Really red","Lime green","Bright blue","New Yeller","Hot pink","White"},
    CurrentOption = "Really red",
    Flag = "HitboxColorDropdown",
    Callback = function(Option)
        HitboxColor = BrickColor.new(Option)
    end,
})
