local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/ui.lua"))()
local DoorESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/DoorESP.lua"))()


local walkspeedActive = false
local currentSpeedValue = 0
--shutdown

UI:Close(function()
	local char = game.Players.LocalPlayer.Character
	
	if char then
		char.SpeedBoost = 0
	end
	DoorESP:SetEnabled(false)
end)


--Buttonconnection

UI:addToggleButton("Door ESP", UI.visualsPage, -1, function(state)
	DoorESP:SetEnabled(state)
end)

UI:addToggleButton("Enable Walkspeed", UI.mainPage, 1, function(state)
	walkspeedActive = state
	local char = game.Players.LocalPlayer.Character

	if char then
		if walkspeedActive then
			char.SpeedBoost = currentSpeedValue
		else
			char.SpeedBoost = 0
		end
	end
end)

UI:addSlider("Walkspeed", 0, 75, UI.mainPage, 2, function(value)
	currentSpeedValue = value
	local char = game.Players.LocalPlayer.Character

	if walkspeedActive then
		if char then
			char.SpeedBoost = value
		end
	end
end)

