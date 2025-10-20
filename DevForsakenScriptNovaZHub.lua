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
		pcall(function() typingSound:Play() end)
		task.wait(delayPerChar)
	end
end)

task.delay(#fullText * delayPerChar + 1, function()
	pcall(function()
		TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 1}):Play()
		TweenService:Create(bg, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
	end)
	task.wait(1)
	pcall(function() introGui:Destroy() end)
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
local Window = Rayfield:CreateWindow({ Name = "NovaZHub| Dev Script test", ConfigurationSaving = { Enabled = false } })

local GUIVisible = true
openButton.MouseButton1Click:Connect(function()
	pcall(function() clickSound:Play() end)
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
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local workspace = game:GetService("Workspace")

-- ====== O SEU CÓDIGO EXISTENTE (ESP, Stamina, ToolESP, TPWalk, Generator, AutoGen) ======
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
				local healthGui = head:FindFirstChild("HealthGui")
				if healthGui then
					local label = healthGui:FindFirstChildWhichIsA("TextLabel")
					if label then
						label.Text = math.floor(humanoid.Health) .. "/" .. humanoid.MaxHealth
					end
				end
			end
		end
	end
end

local function startESP()
	ESPConnection = RunService.Heartbeat:Connect(function()
		for _, plr in pairs(Players:GetPlayers()) do
			local char = plr.Character
			if char then
				for _, v in ipairs(char:GetChildren()) do if v:IsA("Highlight") then v:Destroy() end end
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
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("Highlight") or v.Name == "HealthGui" then
			pcall(function() v:Destroy() end)
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
	Name = "Inf stamina",
	CurrentValue = false,
	Callback = function(Value)
		if Value then
			local success, m = pcall(function() return require(ReplicatedStorage.Systems.Character.Game.Sprinting) end)
			if success and m then
				if type(m) == "table" then
					m.Stamina = 100
				elseif type(m) == "userdata" then
					pcall(function() m.Stamina = 100 end)
				end
				staminaThread = task.spawn(function()
					while true do
						pcall(function()
							if m and m.Stamina and m.Stamina <= 5 then m.Stamina = 20 end
						end)
						task.wait(0.1)
					end
				end)
			end
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
            if obj:FindFirstChild("ToolESP") then pcall(function() obj.ToolESP:Destroy() end) end
            if obj:FindFirstChild("ToolName") then pcall(function() obj.ToolName:Destroy() end) end
        end
    end
    for _, conn in pairs(ToolESPConnections) do
        pcall(function() conn:Disconnect() end)
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
        if moveDir and moveDir.Magnitude > 0 then
            HRP.CFrame = HRP.CFrame + (moveDir * tpDistance * 0.1)
        end
    end
end)

--// ESP GENERATOR
local generatorESPEnabled = false
local generatorHighlights = {}
local function toggleGeneratorESP(state)
	generatorESPEnabled = state
	for _, h in pairs(generatorHighlights) do pcall(function() h:Destroy() end) end
	table.clear(generatorHighlights)
	if state then
		local ok, map = pcall(function() return workspace.Map.Ingame.Map end)
		if ok and map then
			for _, gen in pairs(map:GetChildren()) do
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
			local ok, children = pcall(function() return workspace.Map.Ingame.Map:GetChildren() end)
			if ok and children then
				for _, gen in ipairs(children) do
					if gen.Name == "Generator" and isSafeGenerator(gen) then
						safeActivate(gen)
						task.wait(getRandomDelay())
					end
				end
			end
			task.wait(0.05)
		end
	end)
end
local function stopSafeAutoGen()
	runAutoGen = false
	if autoGenThread then pcall(task.cancel, autoGenThread) end
	autoGenThread = nil
end
GeneratorTab:CreateToggle({
	Name = "Auto Generator",
	CurrentValue = false,
	Callback = function(Value)
		runAutoGen = Value
		if Value then startSafeAutoGen() else stopSafeAutoGen() end
	end
})

-- ====== NOVAS TABS: KILLERS + MISC ======
local KillersTab = Window:CreateTab("Killers", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

--// AUTO KILL NEARBY SURVIVORS
local AutoKillEnabled = false
local AutoKillThread = nil
local KILL_DISTANCE = 15 -- pode ajustar via edição manual se quiser
local TELEPORT_DISTANCE_FROM_TARGET = 2.5 -- quão perto teleportar (em studs)

-- Heurística para achar remotes que pareçam habilidades
local function findAbilityRemotes()
	local candidates = {}
	for _, v in pairs(game:GetDescendants()) do
		if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
			local name = tostring(v.Name):lower()
			-- palavras comuns de habilidade
			if name:find("attack") or name:find("ability") or name:find("skill") or name:find("slash")
			or name:find("behead") or name:find("gash") or name:find("rage") or name:find("ability")
			or name:find("ability") then
				table.insert(candidates, v)
			end
		end
	end
	return candidates
end

local function prepareAbilitiesList(remotes)
	table.sort(remotes, function(a,b) return a.Name < b.Name end)
	local filtered = {}
	for i, r in ipairs(remotes) do
		-- ignora a 4ª habilidade (index 4)
		if i ~= 4 then
			table.insert(filtered, r)
		end
	end
	return filtered
end

local function getAlivePlayers()
	local alive = {}
	for _, otherPlayer in pairs(Players:GetPlayers()) do
		if otherPlayer ~= Players.LocalPlayer and otherPlayer.Character and otherPlayer.Character:FindFirstChildOfClass("Humanoid") then
			local humanoid = otherPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				table.insert(alive, otherPlayer)
			end
		end
	end
	return alive
end

local function getClosestAlivePlayer(maxDist)
	maxDist = maxDist or KILL_DISTANCE
	local localPlayer = Players.LocalPlayer
	if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return nil, math.huge end
	local hrp = localPlayer.Character:FindFirstChild("HumanoidRootPart")
	local closest, dist = nil, math.huge
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= localPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChildOfClass("Humanoid") then
			local hum = plr.Character:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health > 0 then
				local d = (plr.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
				if d < dist and d <= maxDist then
					dist = d
					closest = plr
				end
			end
		end
	end
	return closest, dist
end

local function safeTeleportNear(targetPlayer)
	local lp = Players.LocalPlayer
	if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
	if not (targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
	local targetHRP = targetPlayer.Character.HumanoidRootPart
	local myHRP = lp.Character.HumanoidRootPart
	-- teleport um pouco atrás do target para evitar colidir exatamente
	local dir = (myHRP.Position - targetHRP.Position).Unit
	if dir and dir.Magnitude == 0 then dir = Vector3.new(0,0,1) end
	local desiredPos = targetHRP.Position + dir * TELEPORT_DISTANCE_FROM_TARGET + Vector3.new(0, 1, 0)
	pcall(function() myHRP.CFrame = CFrame.new(desiredPos) end)
end

local function callRemoteOrFunction(r)
	if not r then return end
	pcall(function()
		if r:IsA("RemoteEvent") then
			r:FireServer()
		elseif r:IsA("RemoteFunction") then
			r:InvokeServer()
		end
	end)
end

local function virtualClickOnce()
	pcall(function()
		VirtualUser:CaptureController()
		VirtualUser:Button1Down(Vector2.new(0,0))
		task.wait(0.03)
		VirtualUser:Button1Up(Vector2.new(0,0))
	end)
end

local function performAbilitiesOnTarget(abilitiesList)
	-- abilitiesList: array de remotes; se vazio, usa virtual clicks
	if #abilitiesList > 0 then
		for _, rem in ipairs(abilitiesList) do
			callRemoteOrFunction(rem)
			task.wait(0.08)
		end
	else
		-- fallback: 3 clicks (um pouco de "spam" nas skills)
		for i = 1, 3 do
			virtualClickOnce()
			task.wait(0.06)
		end
	end
end

local function startAutoKill()
	-- encontra remotes uma vez (poderia re-scanner periodicamente)
	local found = findAbilityRemotes()
	local abilities = prepareAbilitiesList(found)

	AutoKillThread = task.spawn(function()
		while AutoKillEnabled do
			local target, dist = getClosestAlivePlayer(KILL_DISTANCE)
			if target and dist and dist <= KILL_DISTANCE then
				-- teleportar próximo
				pcall(safeTeleportNear, target)
				task.wait(0.08)
				-- executar habilidades (remotes preferenciais)
				pcall(performAbilitiesOnTarget, abilities)
			end
			task.wait(0.12)
		end
	end)
end

local function stopAutoKill()
	AutoKillEnabled = false
	if AutoKillThread then
		pcall(task.cancel, AutoKillThread)
		AutoKillThread = nil
	end
end

KillersTab:CreateToggle({
	Name = "Auto Kill nearby survivors",
	CurrentValue = false,
	Callback = function(Value)
		AutoKillEnabled = Value
		if Value then
			startAutoKill()
		else
			stopAutoKill()
		end
	end
})

--// MISC TAB: AntiLag, FullBright, Shaders
-- AntiLag: remove particles/trails, disables expensive effects
local AntiLagEnabled = false
local savedDescendants = {}
local function enableAntiLag()
	AntiLagEnabled = true
	-- remove particle emitters, trails, beam, light (temporarily destroy or disable)
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Sparkles") then
			local parent = v.Parent
			if parent then
				-- store that we removed it so we can reparent if needed (best-effort)
				table.insert(savedDescendants, {obj = v, parent = parent})
				pcall(function() v:Destroy() end)
			end
		end
	end
	-- stop sounds with high emitter distance (best-effort)
	for _, s in ipairs(workspace:GetDescendants()) do
		if s:IsA("Sound") then
			-- mute or lower volume
			pcall(function() s.Volume = 0 end)
		end
	end
	-- lowering rendering settings
	pcall(function()
		if typeof(settings) == "table" and settings().Rendering then
			pcall(function() settings().Rendering.QualityLevel = 1 end)
		end
	end)
end

local function disableAntiLag()
	AntiLagEnabled = false
	-- we destroyed particles; cannot restore reliably. best-effort: do nothing or re-create minimal.
	-- restore sounds volumes to default (best-effort)
	for _, s in ipairs(workspace:GetDescendants()) do
		if s:IsA("Sound") then
			pcall(function() s.Volume = 1 end)
		end
	end
	savedDescendants = {}
end

-- FullBright
local FullBrightEnabled = false
local originalLighting = {}
local function enableFullBright()
	if FullBrightEnabled then return end
	FullBrightEnabled = true
	-- save current important properties
	originalLighting.Brightness = Lighting.Brightness
	originalLighting.TimeOfDay = Lighting.TimeOfDay
	originalLighting.FogEnd = Lighting.FogEnd
	originalLighting.Ambient = Lighting.Ambient
	originalLighting.OutdoorAmbient = Lighting.OutdoorAmbient
	-- apply fullbright
	pcall(function()
		Lighting.Brightness = 2
		Lighting.TimeOfDay = "14:00:00"
		Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.new(1,1,1)
		Lighting.OutdoorAmbient = Color3.new(1,1,1)
	end)
end

local function disableFullBright()
	if not FullBrightEnabled then return end
	FullBrightEnabled = false
	pcall(function()
		if originalLighting.Brightness then Lighting.Brightness = originalLighting.Brightness end
		if originalLighting.TimeOfDay then Lighting.TimeOfDay = originalLighting.TimeOfDay end
		if originalLighting.FogEnd then Lighting.FogEnd = originalLighting.FogEnd end
		if originalLighting.Ambient then Lighting.Ambient = originalLighting.Ambient end
		if originalLighting.OutdoorAmbient then Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient end
	end)
	originalLighting = {}
end

-- Shaders (ColorCorrection + Bloom)
local ShadersEnabled = false
local shaderInstances = {}
local function enableShaders()
	if ShadersEnabled then return end
	ShadersEnabled = true
	local cc = Instance.new("ColorCorrectionEffect")
	cc.Name = "NovaZHub_ColorCorrection"
	cc.Parent = Lighting
	cc.Saturation = 0.05
	cc.Contrast = 0.08

	local bloom = Instance.new("BloomEffect")
	bloom.Name = "NovaZHub_Bloom"
	bloom.Parent = Lighting
	bloom.Intensity = 1
	bloom.Size = 24
