--// NovaZHub | Build A Cart Edition
--// UI: Rayfield (Tema Sirius)
--// Key System + Intro by ChatGPT

-- Libraries
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// Intro
do
	local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
	ScreenGui.IgnoreGuiInset = true

	local Frame = Instance.new("Frame", ScreenGui)
	Frame.Size = UDim2.new(0, 400, 0, 150)
	Frame.Position = UDim2.new(0.5, -200, 0.5, -75)
	Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
	Frame.BorderSizePixel = 0
	Frame.Visible = true
	Frame.Active = true
	Frame.Draggable = false
	Frame.ClipsDescendants = true

	local UICorner = Instance.new("UICorner", Frame)
	UICorner.CornerRadius = UDim.new(0, 10)

	local Title = Instance.new("TextLabel", Frame)
	Title.Size = UDim2.new(1, 0, 0, 40)
	Title.BackgroundTransparency = 1
	Title.Text = "Loading NovaZHub..."
	Title.Font = Enum.Font.GothamBold
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextScaled = true

	local BarBack = Instance.new("Frame", Frame)
	BarBack.Size = UDim2.new(0.9, 0, 0, 20)
	BarBack.Position = UDim2.new(0.05, 0, 0.7, 0)
	BarBack.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
	BarBack.BorderSizePixel = 0
	local BarCorner = Instance.new("UICorner", BarBack)
	BarCorner.CornerRadius = UDim.new(0, 5)

	local Bar = Instance.new("Frame", BarBack)
	Bar.Size = UDim2.new(0, 0, 1, 0)
	Bar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	Bar.BorderSizePixel = 0
	local BarCorner2 = Instance.new("UICorner", Bar)
	BarCorner2.CornerRadius = UDim.new(0, 5)

	for i = 1, 100 do
		Bar:TweenSize(UDim2.new(i / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.03, true)
		task.wait(0.03)
	end

	task.wait(0.5)
	ScreenGui:Destroy()
end

--// Key System
local correctKey = "NovaZHub"
local keyVerified = false

repeat
	local keyInput = Rayfield:PromptInput({
		Title = "NovaZHub Key System",
		Placeholder = "Enter your access key",
		Description = "You must enter a valid key to continue.",
		InputType = "string",
	})
	if keyInput == correctKey then
		keyVerified = true
		Rayfield:Notify({
			Title = "Access Granted",
			Content = "Welcome to NovaZHub!",
			Duration = 4
		})
	else
		Rayfield:Notify({
			Title = "Invalid Key",
			Content = "Please enter the correct key to continue.",
			Duration = 4
		})
	end
until keyVerified

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

--// Helpers
local function fireRemote(path, args)
	local node = ReplicatedStorage:WaitForChild('Framework', 9e9)
	for _, step in ipairs(path) do
		node = node:WaitForChild(step, 9e9)
	end
	node:FireServer(unpack(args))
end

local function pressKey(keyCode, duration)
	VIM:SendKeyEvent(true, keyCode, false, game)
	task.wait(duration or 0.1)
	VIM:SendKeyEvent(false, keyCode, false, game)
end

local function teleportTo(pos)
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
	end
end

--// Main UI
local Window = Rayfield:CreateWindow({
	Name = "NovaZHub | Build A Cart",
	LoadingTitle = "NovaZHub",
	LoadingSubtitle = "by ChatGPT",
	ConfigurationSaving = { Enabled = false },
	KeySystem = false
})

local MoneyTab = Window:CreateTab("💰 Money")
local ShopTab = Window:CreateTab("🛒 Shop")
local CartTab = Window:CreateTab("🛻 Cart")
local RebirthTab = Window:CreateTab("♻️ Rebirth")
local MiscTab = Window:CreateTab("⚙️ Misc")

----------------------------------------------------
-- Money Tab
----------------------------------------------------
MoneyTab:CreateButton({
	Name = "Launch",
	Callback = function()
		fireRemote({ "Features", "RailSystem", "LaunchUtil", "RemoteEvent" }, { "Launch" })
		task.wait(0.1)
		pressKey(Enum.KeyCode.W, 1)
		task.wait(1)
		teleportTo(Vector3.new(-21474831380, 50000, 1000000))
		task.wait(4)
		fireRemote({ "Features", "RailSystem", "LaunchUtil", "RemoteEvent" }, { "Return" })
	end
})

local AutoFarm = false
MoneyTab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarm",
	Callback = function(state)
		AutoFarm = state
		task.spawn(function()
			while AutoFarm do
				fireRemote({ "Features", "RailSystem", "LaunchUtil", "RemoteEvent" }, { "Launch" })
				task.wait(0.1)
				pressKey(Enum.KeyCode.W, 1)
				task.wait(1)
				teleportTo(Vector3.new(-21474831380, 50000, 1000000))
				task.wait(4)
				fireRemote({ "Features", "RailSystem", "LaunchUtil", "RemoteEvent" }, { "Return" })
				task.wait(1)
			end
		end)
	end
})

----------------------------------------------------
-- Shop Tab
----------------------------------------------------
local shopItems = {
	"Small Fuel", "Engine", "Big Fuel", "V8 Engine",
	"Giant Fuel", "V12 Engine", "Tesla Battery", "Tesla Engine", "Turret"
}

for _, item in ipairs(shopItems) do
	ShopTab:CreateButton({
		Name = item,
		Callback = function()
			fireRemote({ "Features", "RailSystem", "GearUtil", "RemoteEvent" }, { "BuyGear", item })
		end
	})
end

----------------------------------------------------
-- Cart Tab
----------------------------------------------------
local AutoUpgradeCart = false
CartTab:CreateToggle({
	Name = "Auto Upgrade Cart",
	CurrentValue = false,
	Flag = "AutoUpgradeCart",
	Callback = function(state)
		AutoUpgradeCart = state
		task.spawn(function()
			while AutoUpgradeCart do
				fireRemote({ "Features", "RailSystem", "CartUtil", "RemoteEvent" }, { "BuyCart" })
				task.wait(1)
			end
		end)
	end
})

----------------------------------------------------
-- Rebirth Tab
----------------------------------------------------
local AutoRebirth = false
RebirthTab:CreateToggle({
	Name = "Auto Rebirth",
	CurrentValue = false,
	Flag = "AutoRebirth",
	Callback = function(state)
		AutoRebirth = state
		task.spawn(function()
			while AutoRebirth do
				fireRemote({ "Features", "RebirthSystem", "RebirthUtil", "RemoteEvent" }, { "Rebirth" })
				task.wait(1)
			end
		end)
	end
})

----------------------------------------------------
-- Misc Tab
----------------------------------------------------
MiscTab:CreateKeybind({
	Name = "Toggle UI",
	CurrentKeybind = "LeftControl",
	Flag = "UIBind",
	Callback = function()
		Rayfield:Toggle()
	end
})

Rayfield:Notify({
	Title = "NovaZHub Loaded",
	Content = "Welcome to Build A Cart Edition!",
	Duration = 5
})
