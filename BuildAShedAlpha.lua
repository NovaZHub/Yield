--[[
    Build a Shed | Auto Farm (RedzUI V5)
    by Carlos
]]

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- RemoteFunction correto para Launch
local launchRemote = ReplicatedStorage.Packages.Tech.Services.Game.RF.Launch

-- Função para lançar
local function launchBoat()
    if launchRemote then
        launchRemote:InvokeServer()
    else
        warn("⚠ RemoteFunction Launch não encontrado!")
    end
end

-- Função para teleportar para distância absurda
local function teleportDistance(dist)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = hrp.CFrame + Vector3.new(dist, 0, 0) -- Mover no eixo X
end

-- Variável do Auto Farm
local autoFarm = false

-- Loop do Auto Farm
task.spawn(function()
    while task.wait(1) do
        if autoFarm then
            launchBoat()
            task.wait(1)
            teleportDistance(100000000000000)
        end
    end
end)

-- UI RedzLib V5
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

local win = redzlib:MakeWindow({
    Title = "LumaZHub | Build a shed ( Alpha Script",
    SubTitle = "By Carlos",
    SaveFolder = "BuildAShedAutoFarm"
})

local main = win:MakeTab({"Main", "rbxassetid://4483362458"})

main:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(v)
        autoFarm = v
    end
})
