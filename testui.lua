local WhatsLib = loadstring(game:HttpGet("LINK_DA_LIBRARY"))()

local Window = WhatsLib:MakeWindow({
    Title = "NovaZHub - WhatsApp Style"
})

local Tab = WhatsLib:MakeTab(Window, {Name = "Main"})

WhatsLib:AddLabel(Tab, {
    Text = "Bem-vindo ao NovaZHub 📲"
})

WhatsLib:AddButton(Tab, {
    Name = "Ativar ESP",
    Callback = function()
        print("ESP Ligado")
    end
})
