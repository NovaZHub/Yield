--// INTRO COM EFEITO DIGITANDO - NovaZHub
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local introGui = Instance.new("ScreenGui")
introGui.Name = "KyraZHubIntro"
introGui.IgnoreGuiInset = true
introGui.ResetOnSpawn = false
introGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
introGui.Parent = PlayerGui

local bg = Instance.new("Frame")
bg.BackgroundColor3 = Color3.new(0, 0, 0)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Parent = introGui
bg.ZIndex = 5

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(0, 255, 128)
label.Font = Enum.Font.Code
label.TextScaled = true
label.Text = ""
label.ZIndex = 6
label.Parent = bg

local typingSound = Instance.new("Sound", bg)
typingSound.SoundId = "rbxassetid://9118823100"
typingSound.Volume = 1

local fullText = "NovaZHub"
local delayPerChar = 0.12

task.spawn(function()
	for i = 1, #fullText do
		label.Text = string.sub(fullText, 1, i)
		typingSound:Play()
		task.wait(delayPerChar)
	end
end)

task.delay(#fullText * delayPerChar + 1, function()
	TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 1}):Play()
	TweenService:Create(bg, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
	task.wait(1)
	introGui:Destroy()
end)

--// BOTÃO FLUTUANTE
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ToggleButtonGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game:GetService("CoreGui")

local openButton = Instance.new("ImageButton")
openButton.Size = UDim2.new(0, 54, 0, 54)
openButton.Position = UDim2.new(0, 12, 0, 12)
openButton.BackgroundTransparency = 1
openButton.Image = "rbxassetid://16870168856"
openButton.ZIndex = 10
openButton.Parent = screenGui

local clickSound = Instance.new("Sound", openButton)
clickSound.SoundId = "rbxassetid://9118823100"
clickSound.Volume = 1

openButton.MouseEnter:Connect(function()
	openButton:TweenSize(UDim2.new(0, 62, 0, 62), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
end)
openButton.MouseLeave:Connect(function()
	openButton:TweenSize(UDim2.new(0, 54, 0, 54), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
end)

--// RAYFIELD GUI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({ Name = "KyraZHub", ConfigurationSaving = { Enabled = false } })

local GUIVisible = true
openButton.MouseButton1Click:Connect(function()
	clickSound:Play()
	GUIVisible = not GUIVisible
	Window:SetVisible(GUIVisible)
end)

--// TABS
local MainTab = Window:CreateTab("Main", 4483362458)
local GeneratorTab = Window:CreateTab("Generators", 4483362458)

--// DEPENDÊNCIAS
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

--// ESP HAWK TUAH
local ESPConnection
local function createOutlineESP(model, outlineColor, fillColor)
	if not model:FindFirstChildOfClass("Highlight") then
		local h = Instance.new("Highlight", model)
		h.Adornee = model
		h.FillColor = fillColor
		h.FillTransparency = 0.75
		h.OutlineColor = outlineColor
	end
end

local function createHealthIndicator(character, textColor)
	local head = character:FindFirstChild("Head")
	if head and not head:FindFirstChild("HealthGui") then
		local gui = Instance.new("BillboardGui", head)
		gui.Name = "HealthGui"
		gui.Size = UDim2.new(0, 100, 0, 30)
		gui.AlwaysOnTop = true
		local label = Instance.new("TextLabel", gui)
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.Font = Enum.Font.SourceSansBold
		label.TextScaled = true
		label.TextColor3 = textColor
	end
end

local function updateHealthIndicators()
	for _, plr in Players:GetPlayers() do
		local char = plr.Character
		if char then
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			local head = char:FindFirstChild("Head")
			if humanoid and head then
				local label = head:FindFirstChild("HealthGui"):FindFirstChildWhichIsA("TextLabel")
				if label then
					label.Text = math.floor(humanoid.Health) .. "/" .. humanoid.MaxHealth
				end
			end
		end
	end
end

local function startESP()
	ESPConnection = RunService.Heartbeat:Connect(function()
		for _, plr in Players:GetPlayers() do
			local char = plr.Character
			if char then
				for _, v in char:GetChildren() do if v:IsA("Highlight") then v:Destroy() end end
				local humanoid = char:FindFirstChildOfClass("Humanoid")
				if humanoid then
					local hp = humanoid.MaxHealth
					local fill = hp > 500 and Color3.new(1, 0.5, 0.5) or Color3.new(0.7, 0.7, 0.7)
					local outline = hp > 500 and Color3.new(1, 0, 0) or Color3.new(0.5, 0.5, 0.5)
					createOutlineESP(char, outline, fill)
					createHealthIndicator(char, outline)
				end
			end
		end
		updateHealthIndicators()
	end)
end

local function stopESP()
	if ESPConnection then ESPConnection:Disconnect() end
	for _, v in workspace:GetDescendants() do
		if v:IsA("Highlight") or v.Name == "HealthGui" then
			v:Destroy()
		end
	end
end

MainTab:CreateToggle({
	Name = "ESP (Hawk Tuah)",
	CurrentValue = false,
	Callback = function(Value)
		if Value then startESP() else stopESP() end
	end
})

--// INFINITE STAMINA
local staminaThread
MainTab:CreateToggle({
	Name = "Infinite Stamina",
	CurrentValue = false,
	Callback = function(Value)
		if Value then
			local m = require(ReplicatedStorage.Systems.Character.Game.Sprinting)
			m.Stamina = 100
			staminaThread = task.spawn(function()
				while true do
					if m.Stamina <= 5 then m.Stamina = 20 end
					task.wait(0.1)
				end
			end)
		else
			if staminaThread then task.cancel(staminaThread) end
		end
	end
})

--// ESP TOOL
local ToolESPEnabled = false
local ToolESPConnections = {}
local function createToolESP(tool)
    if tool:FindFirstChild("ToolESP") then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "ToolESP"
    highlight.Parent = tool
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    local adornee = tool:FindFirstChildWhichIsA("BasePart")
    if adornee then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ToolName"
        billboard.Parent = tool
        billboard.Size = UDim2.new(0, 100, 0, 30)
        billboard.Adornee = adornee
        billboard.AlwaysOnTop = true
        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Text = tool.Name
        text.TextColor3 = Color3.fromRGB(0, 255, 0)
        text.TextStrokeTransparency = 0
        text.Font = Enum.Font.SourceSansBold
        text.TextScaled = true
        text.Parent = billboard
    end
end
local function enableToolESP()
    ToolESPEnabled = true
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") then
            createToolESP(obj)
        end
    end
    ToolESPConnections["Added"] = workspace.DescendantAdded:Connect(function(obj)
        if ToolESPEnabled and obj:IsA("Tool") then
            createToolESP(obj)
        end
    end)
end
local function disableToolESP()
    ToolESPEnabled = false
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") then
            if obj:FindFirstChild("ToolESP") then obj.ToolESP:Destroy() end
            if obj:FindFirstChild("ToolName") then obj.ToolName:Destroy() end
        end
    end
    for _, conn in pairs(ToolESPConnections) do
        conn:Disconnect()
    end
    ToolESPConnections = {}
end
MainTab:CreateToggle({
    Name = "ESP Tool",
    CurrentValue = false,
    Callback = function(Value)
        if Value then enableToolESP() else disableToolESP() end
    end
})

--// TP WALK
local tpDistance = 10
local walking = false
MainTab:CreateToggle({
    Name = "TP Walk (Limited until October 14th)",
    CurrentValue = false,
    Callback = function(Value)
        walking = Value
    end
})
MainTab:CreateSlider({
    Name = "distance TP Walk",
    Range = {5, 100},
    Increment = 5,
    Suffix = " studs",
    CurrentValue = tpDistance,
    Callback = function(Value)
        tpDistance = Value
    end
})
RunService.RenderStepped:Connect(function()
    if walking and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = Players.LocalPlayer.Character.HumanoidRootPart
        local moveDir = Players.LocalPlayer.Character.Humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            HRP.CFrame = HRP.CFrame + (moveDir * tpDistance * 0.1)
        end
    end
end)

--// ESP GENERATOR
local generatorESPEnabled = false
local generatorHighlights = {}
local function toggleGeneratorESP(state)
	generatorESPEnabled = state
	for _, h in pairs(generatorHighlights) do h:Destroy() end
	table.clear(generatorHighlights)
	if state then
		for _, gen in pairs(workspace.Map.Ingame.Map:GetChildren()) do
			if gen:IsA("Model") and gen.Name == "Generator" then
				local highlight = Instance.new("Highlight", gen)
				highlight.FillColor = Color3.fromRGB(255, 255, 0)
				highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
				highlight.FillTransparency = 0.5
				table.insert(generatorHighlights, highlight)
			end
		end
	end
end
GeneratorTab:CreateToggle({
	Name = "ESP Generator",
	CurrentValue = false,
	Callback = toggleGeneratorESP
})

--// AUTO GENERATOR
local runAutoGen = false
local autoGenThread = nil
local function isSafeGenerator(gen)
	return gen:FindFirstChild("Remotes") and gen.Remotes:FindFirstChild("RE")
end
local function getRandomDelay()
	return math.random(4, 7) / 10
end
local function safeActivate(gen)
	if isSafeGenerator(gen) then
		pcall(function()
			gen.Remotes.RE:FireServer()
		end)
	end
end
local function startSafeAutoGen()
	if autoGenThread then task.cancel(autoGenThread) end
	autoGenThread = task.spawn(function()
		while runAutoGen do
			for _, gen in ipairs(workspace.Map.Ingame.Map:GetChildren()) do
				if gen.Name == "Generator" and isSafeGenerator(gen) then
					safeActivate(gen)
					task.wait(getRandomDelay())
				end
			end
			task.wait(0.05)
		end
	end)
end
local function stopSafeAutoGen()
	runAutoGen = false
	if autoGenThread then task.cancel(autoGenThread) end
end
GeneratorTab:CreateToggle({
	Name = "Auto Generator",
	CurrentValue = false,
	Callback = function(Value)
		runAutoGen = Value
		if Value then startSafeAutoGen() else stopSafeAutoGen() end
	end
})
