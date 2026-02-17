--// ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "NovaXAnnouncement"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

--// Frame Principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 520, 0, 380)
frame.Position = UDim2.new(0.5, -260, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,14)

--// Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 50)
title.Position = UDim2.new(0, 20, 0, 10)
title.BackgroundTransparency = 1
title.Text = "NovaX Hub - Announcement"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

--// Botão Fechar
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -40, 0, 10)
close.BackgroundColor3 = Color3.fromRGB(200,50,50)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextScaled = true
close.Parent = frame
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

--// Caixa de Texto
local textBox = Instance.new("TextLabel")
textBox.Size = UDim2.new(1, -40, 0, 230)
textBox.Position = UDim2.new(0, 20, 0, 70)
textBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
textBox.TextColor3 = Color3.new(1,1,1)
textBox.TextWrapped = true
textBox.TextYAlignment = Enum.TextYAlignment.Top
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.Parent = frame
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0,10)

--// Mensagens completas
local messages = {

PT = [[Na comunidade de scripters, apesar de eu ainda gostar do que faço, tenho estado em dúvida ultimamente. Muitas vezes começo um projeto e acabo travando, sem saber exatamente o que adicionar ou como evoluir a ideia. Não é falta de vontade, é mais um bloqueio criativo mesmo.

Por isso, vou dar um tempo na criação de scripts para organizar minhas ideias e recuperar a motivação. Agradeço a todos que apoiaram até aqui. Se puderem divulgar meus projetos, isso ajuda bastante.

Não sei exatamente quanto tempo essa pausa vai durar, mas não é um adeus. É apenas um tempo necessário para clarear a mente e voltar com algo que realmente valha a pena. Prefiro entregar qualidade do que lançar algo sem propósito.

Durante esse período, vou focar em aprender coisas novas, testar ideias diferentes e melhorar como desenvolvedor. Quando eu voltar, quero trazer algo mais sólido, mais bem pensado e mais impactante.

Obrigado a quem entende e continua apoiando.]],

EN = [[In the scripting community, even though I still enjoy what I do, I’ve been feeling uncertain lately. Many times I start a project and end up getting stuck, not knowing what to add or how to improve the idea. It’s not a lack of interest, it’s more of a creative block.

Because of that, I’ll be taking a break from script development to organize my ideas and regain motivation. I appreciate everyone who has supported me so far. If you can, please help by sharing my projects.

I don’t know exactly how long this break will last, but it’s not a goodbye. It’s simply time I need to clear my mind and come back with something truly worth it. I prefer delivering quality instead of releasing something without purpose.

During this time, I’ll focus on learning new things, testing different ideas, and improving myself as a developer. When I return, I want to bring something more solid, more refined, and more impactful.

Thank you to everyone who understands and continues to support me.]],

ES = [[En la comunidad de scripters, aunque todavía me gusta lo que hago, últimamente he tenido dudas. Muchas veces empiezo un proyecto y termino bloqueado, sin saber qué agregar o cómo mejorar la idea. No es falta de ganas, es más un bloqueo creativo.

Por eso, voy a tomar un descanso en la creación de scripts para organizar mis ideas y recuperar la motivación. Agradezco a todos los que me han apoyado hasta ahora. Si pueden, ayuden compartiendo mis proyectos.

No sé exactamente cuánto durará este descanso, pero no es una despedida. Es solo el tiempo que necesito para aclarar mi mente y regresar con algo que realmente valga la pena. Prefiero entregar calidad antes que lanzar algo sin propósito.

Durante este tiempo, me enfocaré en aprender cosas nuevas, probar ideas diferentes y mejorar como desarrollador. Cuando regrese, quiero traer algo más sólido, más trabajado y más impactante.

Gracias a todos los que entienden y siguen apoyando.]]
}

textBox.Text = messages.PT

--// Criar botões de idioma
local function createLangButton(name, posX)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 80, 0, 35)
	btn.Position = UDim2.new(0, posX, 1, -60)
	btn.BackgroundColor3 = Color3.fromRGB(0,120,255)
	btn.Text = name
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.Parent = frame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	btn.MouseButton1Click:Connect(function()
		textBox.Text = messages[name]
	end)
end

createLangButton("PT", 40)
createLangButton("EN", 150)
createLangButton("ES", 260)

--// Botão Copiar
local copy = Instance.new("TextButton")
copy.Size = UDim2.new(0, 120, 0, 35)
copy.Position = UDim2.new(1, -150, 1, -60)
copy.BackgroundColor3 = Color3.fromRGB(0,170,255)
copy.Text = "Copy"
copy.TextColor3 = Color3.new(1,1,1)
copy.Font = Enum.Font.GothamBold
copy.TextScaled = true
copy.Parent = frame
Instance.new("UICorner", copy).CornerRadius = UDim.new(0,8)

copy.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(textBox.Text)
		copy.Text = "Copied!"
		task.wait(1.5)
		copy.Text = "Copy"
	end
end)