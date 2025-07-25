-- Módulo: test
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local test = {}

function test:MakeWindow(settings)
	local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
	ScreenGui.Name = "TestFluentUI"
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local Main = Instance.new("Frame", ScreenGui)
	Main.Size = UDim2.new(0, 500, 0, 400)
	Main.Position = UDim2.new(0.5, -250, 0.5, -200)
	Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Main.BorderSizePixel = 0
	Main.Name = "Main"
	Main.ClipsDescendants = true
	Main.Active = true
	Main.Draggable = settings.Draggable

	local Title = Instance.new("TextLabel", Main)
	Title.Size = UDim2.new(1, 0, 0, 40)
	Title.BackgroundTransparency = 1
	Title.Text = settings.Title or "Nova Fluent UI"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 20

	local TabsHolder = Instance.new("Frame", Main)
	TabsHolder.Position = UDim2.new(0, 0, 0, 40)
	TabsHolder.Size = UDim2.new(0, 100, 1, -40)
	TabsHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	TabsHolder.BorderSizePixel = 0

	local PagesHolder = Instance.new("Frame", Main)
	PagesHolder.Position = UDim2.new(0, 100, 0, 40)
	PagesHolder.Size = UDim2.new(1, -100, 1, -40)
	PagesHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	PagesHolder.BorderSizePixel = 0
	PagesHolder.Name = "PagesHolder"

	local function createTabButton(tabName, tabFrame)
		local TabBtn = Instance.new("TextButton", TabsHolder)
		TabBtn.Size = UDim2.new(1, 0, 0, 30)
		TabBtn.BackgroundTransparency = 1
		TabBtn.Text = tabName
		TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabBtn.Font = Enum.Font.Gotham
		TabBtn.TextSize = 14

		TabBtn.MouseButton1Click:Connect(function()
			for _, page in ipairs(PagesHolder:GetChildren()) do
				page.Visible = false
			end
			tabFrame.Visible = true
		end)
	end

	function test:MakeTab(name)
		local Page = Instance.new("Frame", PagesHolder)
		Page.Name = name
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.BackgroundTransparency = 1
		Page.Visible = false

		local Layout = Instance.new("UIListLayout", Page)
		Layout.Padding = UDim.new(0, 6)
		Layout.SortOrder = Enum.SortOrder.LayoutOrder

		createTabButton(name, Page)

		local tab = {}

		function tab:AddButton(text, callback)
			local Btn = Instance.new("TextButton", Page)
			Btn.Size = UDim2.new(1, -20, 0, 30)
			Btn.Position = UDim2.new(0, 10, 0, 0)
			Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			Btn.Font = Enum.Font.Gotham
			Btn.TextSize = 14
			Btn.Text = text
			Btn.BorderSizePixel = 0

			Btn.MouseButton1Click:Connect(function()
				if typeof(callback) == "function" then
					callback()
				end
			end)
		end

		function tab:AddToggle(text, default, callback)
			local Toggle = Instance.new("TextButton", Page)
			Toggle.Size = UDim2.new(1, -20, 0, 30)
			Toggle.Position = UDim2.new(0, 10, 0, 0)
			Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.Font = Enum.Font.Gotham
			Toggle.TextSize = 14
			Toggle.Text = "[ OFF ] " .. text
			Toggle.BorderSizePixel = 0

			local toggled = default or false
			if toggled then Toggle.Text = "[ ON  ] " .. text end

			Toggle.MouseButton1Click:Connect(function()
				toggled = not toggled
				Toggle.Text = toggled and ("[ ON  ] " .. text) or ("[ OFF ] " .. text)
				if typeof(callback) == "function" then
					callback(toggled)
				end
			end)
		end

		function tab:AddSlider(name, config, callback)
			local Holder = Instance.new("Frame", Page)
			Holder.Size = UDim2.new(1, -20, 0, 50)
			Holder.Position = UDim2.new(0, 10, 0, 0)
			Holder.BackgroundTransparency = 1

			local Label = Instance.new("TextLabel", Holder)
			Label.Size = UDim2.new(1, 0, 0, 20)
			Label.Text = name .. ": " .. config.Default
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.BackgroundTransparency = 1
			Label.Font = Enum.Font.Gotham
			Label.TextSize = 13

			local Slider = Instance.new("Frame", Holder)
			Slider.Position = UDim2.new(0, 0, 0, 25)
			Slider.Size = UDim2.new(1, 0, 0, 10)
			Slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Slider.BorderSizePixel = 0

			local Fill = Instance.new("Frame", Slider)
			Fill.Size = UDim2.new((config.Default - config.Min) / (config.Max - config.Min), 0, 1, 0)
			Fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			Fill.BorderSizePixel = 0

			local dragging = false

			Slider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					local relX = input.Position.X - Slider.AbsolutePosition.X
					local percent = math.clamp(relX / Slider.AbsoluteSize.X, 0, 1)
					Fill.Size = UDim2.new(percent, 0, 1, 0)
					local val = math.floor(config.Min + (config.Max - config.Min) * percent)
					Label.Text = name .. ": " .. val
					if callback then callback(val) end
				end
			end)
		end

		return tab
	end

	-- Mostrar a primeira aba automaticamente
	local firstTab = PagesHolder:FindFirstChildOfClass("Frame")
	if firstTab then firstTab.Visible = true end

	return test
end

return test
