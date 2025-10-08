1--// Rayfield UI Version with Key System
--// Build A Cart | NovaZHub Edition

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// Window
local Window = Rayfield:CreateWindow({
	Name = "Build A Cart | NovaZHub Edition",
	LoadingTitle = "NovaZHub | Build A Cart",
	LoadingSubtitle = "Powered by Rayfield UI",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "BuildACart_NovaZHub",
		FileName = "Settings"
	},

	--// Key System
	KeySystem = true,
	KeySettings = {
		Title = "NovaZHub | Key System",
		Subtitle = "Enter your access key below",
		Note = "Key: NovaZHub",
		SaveKey = true,
		Key = {"NovaZHub"} -- Key válida
	}
})

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

--// Helpers
local function fireRemote(path, args)
	local node = ReplicatedStorage:WaitForChild("Framework", 9e9)
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

----------------------------------------------------
-- Tabs
----------------------------------------------------
local MoneyTab = Window:CreateTab("💰 Money")
local ShopTab = Window:CreateTab("🛒 Shop")
local CartTab = Window:CreateTab("🛞 Cart")
local RebirthTab = Window:CreateTab("🔁 Rebirth")
local CreditsTab = Window:CreateTab("📜 Credits")
local MiscTab = Window:CreateTab("⚙️ Misc")

----------------------------------------------------
-- Money Tab
----------------------------------------------------
MoneyTab:CreateParagraph({Title = "Info", Content = "Auto farm gives about 100il+ (depends on carts)."})

MoneyTab:CreateButton({
	Name = "Launch",
	Callback = function()
		fireRemote({"Features", "RailSystem", "LaunchUtil", "RemoteEvent"}, {"Launch"})
		task.wait(0.1)
		pressKey(Enum.KeyCode.W, 1)
		task.wait(1)
		teleportTo(Vector3.new(-21474831380, 50000, 1000000))
		task.wait(4)
		fireRemote({"Features", "RailSystem", "LaunchUtil", "RemoteEvent"}, {"Return"})
	end
})

local AutoFarm = false
MoneyTab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarm",
	Callback = function(state)
		AutoFarm = state
		if AutoFarm then
			task.spawn(function()
				while AutoFarm do
					fireRemote({"Features", "RailSystem", "LaunchUtil", "RemoteEvent"}, {"Launch"})
					task.wait(0.1)
					pressKey(Enum.KeyCode.W, 1)
					task.wait(1)
					teleportTo(Vector3.new(-21474831380, 50000, 1000000))
					task.wait(4)
					fireRemote({"Features", "RailSystem", "LaunchUtil", "RemoteEvent"}, {"Return"})
					task.wait(1)
				end
			end)
		end
		Rayfield:Notify({
			Title = "Auto Farm",
			Content = "Toggled " .. (state and "ON" or "OFF"),
			Duration = 3
		})
	end
})

----------------------------------------------------
-- Shop Tab
----------------------------------------------------
ShopTab:CreateParagraph({Title = "Shop", Content = "Buy items for your cart."})

local shopItems = {
	"Small Fuel", "Engine", "Big Fuel", "V8 Engine",
	"Giant Fuel", "V12 Engine", "Tesla Battery", "Tesla Engine", "Turret"
}

for _, item in ipairs(shopItems) do
	ShopTab:CreateButton({
		Name = item,
		Callback = function()
			fireRemote({"Features", "RailSystem", "GearUtil", "RemoteEvent"}, {"BuyGear", item})
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
		if AutoUpgradeCart then
			task.spawn(function()
				while AutoUpgradeCart do
					fireRemote({"Features", "RailSystem", "CartUtil", "RemoteEvent"}, {"BuyCart"})
					task.wait(1)
				end
			end)
		end
		Rayfield:Notify({
			Title = "Auto Upgrade Cart",
			Content = "Toggled " .. (state and "ON" or "OFF"),
			Duration = 3
		})
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
		if AutoRebirth then
			task.spawn(function()
				while AutoRebirth do
					fireRemote({"Features", "RebirthSystem", "RebirthUtil", "RemoteEvent"}, {"Rebirth"})
					task.wait(1)
				end
			end)
		end
		Rayfield:Notify({
			Title = "Auto Rebirth",
			Content = "Toggled " .. (state and "ON" or "OFF"),
			Duration = 3
		})
	end
})

----------------------------------------------------
-- Credits Tab
----------------------------------------------------
CreditsTab:CreateParagraph({Title = "Scripters", Content = "Original scripts by UILIB/Doze"})
CreditsTab:CreateParagraph({Title = "Converted", Content = "Converted to Rayfield UI + Key System by ChatGPT (NovaZ)"})

----------------------------------------------------
-- Misc Tab
----------------------------------------------------
MiscTab:CreateParagraph({Title = "Settings", Content = "LeftControl toggles UI visibility."})

MiscTab:CreateKeybind({
	Name = "Toggle UI",
	CurrentKeybind = "LeftControl",
	HoldToInteract = false,
	Flag = "ToggleUI",
	Callback = function()
		Rayfield:Toggle()
	end
})

MiscTab:CreateParagraph({Title = "Discord", Content = "Join the official server below."})

local requestFunc = syn and syn.request or http_request or fluxus and fluxus.request or Krnl and Krnl.request or zenith and zenith.request
local INVITE_CODE = "QYRBbM4gHp"

MiscTab:CreateButton({
	Name = "Join Discord",
	Callback = function()
		if not requestFunc then
			warn("No supported executor found!")
			return
		end
		requestFunc({
			Url = "http://127.0.0.1:6463/rpc?v=1",
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json",
				["Origin"] = "https://discord.com",
			},
			Body = game:GetService("HttpService"):JSONEncode({
				cmd = "INVITE_BROWSER",
				args = { code = INVITE_CODE },
				nonce = game:GetService("HttpService"):GenerateGUID(false),
			}),
		})
	end
})

----------------------------------------------------
-- Notification
----------------------------------------------------
task.wait(1)
Rayfield:Notify({
	Title = "NovaZ Build A Cart",
	Content = "Rayfield UI + Key System Loaded Successfully!",
	Duration = 5
})
