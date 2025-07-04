--// BOTÃO FLUTUANTE COM IMAGEM HACKER
local Players = game:GetService("Players")
local player = Players.LocalPlayer
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
local Window = Rayfield:CreateWindow({ Name = "Prefeito Hub 😎", ConfigurationSaving = { Enabled = false } })

local GUIVisible = true
openButton.MouseButton1Click:Connect(function()
	clickSound:Play()
	GUIVisible = not GUIVisible
	Window:SetVisible(GUIVisible)
end)

--// ABA MAIN
local MainTab = Window:CreateTab("Main", 4483362458)
local RunService = game:GetService("RunService")
local ESPConnection

-- ESP HAWK TUAH
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

-- INFINITE STAMINA
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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

-- TOOL ESP (Medkit, BloxyCola)
local toolhighlightActive = false
local function highlighttools(state)
	toolhighlightActive = state
	local function applyHighlight(tool)
		if toolhighlightActive then
			local h = tool:FindFirstChild("ToolHighlight")
			if not h then
				h = Instance.new("Highlight", tool)
				h.Name = "ToolHighlight"
				h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				if tool.Name == "Medkit" then h.FillColor = Color3.fromRGB(0,255,0)
				elseif tool.Name == "BloxyCola" then h.FillColor = Color3.fromRGB(88, 57, 39)
				else h.FillColor = Color3.fromRGB(255,255,255) end
			end
		else
			local h = tool:FindFirstChild("ToolHighlight")
			if h then h:Destroy() end
		end
	end
	for _, v in pairs(workspace.Map.Ingame:GetChildren()) do
		if v:IsA("Tool") then applyHighlight(v) end
	end
	workspace.Map.Ingame.ChildAdded:Connect(function(child)
		if child:IsA("Tool") then applyHighlight(child) end
	end)
end

MainTab:CreateToggle({
	Name = "Tool ESP (Itens como Medkit)",
	CurrentValue = false,
	Callback = function(Value)
		highlighttools(Value)
	end
})

-- ABA GENERATORS
local GeneratorTab = Window:CreateTab("Generators", 4483362458)
local runAutoGen = false
local autoGenThread = nil

local function isSafeGenerator(gen)
	return gen:FindFirstChild("Remotes") and gen.Remotes:FindFirstChild("RE")
end

local function getRandomDelay()
	return math.random(4, 7) / 10 -- 0.4 a 0.7 segundos
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
	Name = "Auto Generator (Turbo e Seguro)",
	CurrentValue = false,
	Callback = function(Value)
		runAutoGen = Value
		if Value then startSafeAutoGen() else stopSafeAutoGen() end
	end
})
