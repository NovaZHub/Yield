-- // Script: Support Ended Screen 😔🥀 (Multilíngue)
-- // Feito por ChatGPT (GPT-5)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Button = Instance.new("TextButton")
local LanguageDropdown = Instance.new("TextButton")
local UICorner1 = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")

if syn and syn.protect_gui then
	syn.protect_gui(ScreenGui)
end

ScreenGui.Name = "SupportEnded"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- Fundo
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 0, 0, 0)
Frame.Size = UDim2.new(1, 0, 1, 0)

-- Texto principal
TextLabel.Parent = Frame
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.Position = UDim2.new(0.5, 0, 0.4, 0)
TextLabel.Size = UDim2.new(0, 700, 0, 100)
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "This script has ended support for this game 😔🥀"

-- Botão OK
Button.Parent = Frame
Button.AnchorPoint = Vector2.new(0.5, 0.5)
Button.Position = UDim2.new(0.5, 0, 0.6, 0)
Button.Size = UDim2.new(0, 200, 0, 50)
Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Button.Text = "OK"
Button.TextColor3 = Color3.new(1, 1, 1)
Button.TextScaled = true
Button.Font = Enum.Font.GothamBold
UICorner1.Parent = Button
UICorner1.CornerRadius = UDim.new(0, 10)

-- Botão de idioma
LanguageDropdown.Parent = Frame
LanguageDropdown.AnchorPoint = Vector2.new(0.5, 0.5)
LanguageDropdown.Position = UDim2.new(0.5, 0, 0.72, 0)
LanguageDropdown.Size = UDim2.new(0, 240, 0, 45)
LanguageDropdown.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LanguageDropdown.Text = "🌍 Language: English"
LanguageDropdown.TextColor3 = Color3.new(1, 1, 1)
LanguageDropdown.TextScaled = true
LanguageDropdown.Font = Enum.Font.GothamBold
UICorner2.Parent = LanguageDropdown
UICorner2.CornerRadius = UDim.new(0, 10)

-- Idiomas disponíveis
local languages = {
	["English"] = "This script has ended support for this game 😔🥀",
	["Português"] = "Este script encerrou o suporte para este jogo 😔🥀",
	["Español"] = "Este script ha finalizado el soporte para este juego 😔🥀",
	["Tiếng Việt"] = "Script này đã ngừng hỗ trợ cho trò chơi này 😔🥀"
}

local langList = {"English", "Português", "Español", "Tiếng Việt"}
local currentLang = 1

-- Trocar idioma ao clicar no botão de idioma
LanguageDropdown.MouseButton1Click:Connect(function()
	currentLang = currentLang + 1
	if currentLang > #langList then
		currentLang = 1
	end
	local lang = langList[currentLang]
	TextLabel.Text = languages[lang]
	LanguageDropdown.Text = "🌍 Language: " .. lang
end)

-- Fade in
Frame.BackgroundTransparency = 1
TextLabel.TextTransparency = 1
Button.TextTransparency = 1
Button.BackgroundTransparency = 1
LanguageDropdown.TextTransparency = 1
LanguageDropdown.BackgroundTransparency = 1

task.spawn(function()
	for i = 1, 30 do
		local t = i / 30
		Frame.BackgroundTransparency = 1 - t
		TextLabel.TextTransparency = 1 - t
		Button.TextTransparency = 1 - t
		Button.BackgroundTransparency = 1 - t
		LanguageDropdown.TextTransparency = 1 - t
		LanguageDropdown.BackgroundTransparency = 1 - t
		task.wait(0.03)
	end
end)

-- Botão OK fecha com fade out
Button.MouseButton1Click:Connect(function()
	for i = 1, 30 do
		local t = i / 30
		Frame.BackgroundTransparency = t
		TextLabel.TextTransparency = t
		Button.TextTransparency = t
		Button.BackgroundTransparency = t
		LanguageDropdown.TextTransparency = t
		LanguageDropdown.BackgroundTransparency = t
		task.wait(0.02)
	end
	ScreenGui:Destroy()
end)
