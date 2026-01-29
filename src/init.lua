local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/ui.lua"))()
local DoorESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/DoorESP.lua"))()

--shutdown

UI:Close(function()
	DoorESP:SetEnabled(false)
end)


--Buttonconnection

UI:addToggleButton("Door ESP", UI.visualsPage, function(state)
	DoorESP:SetEnabled(state)
end)


