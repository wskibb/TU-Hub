local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/ui.lua"))()
local DoorESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/DoorESP.lua"))()
local ACBypass = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/utilities.lua/AntiCheatBypass.lua"))()


local plr = game.Players.LocalPlayer

local walkspeedActive = false
local currentSpeedValue = 0
--shutdown

UI:CloseButton(function()
	local char = game.Players.LocalPlayer.Character
	
	if char then
		char:SetAttribute("SpeedBoost", 0) 
	end
	DoorESP:SetEnabled(false)
end)


--Buttonconnection

--AntiCheat Bypass
UI:addToggleButton("Bypass Anti-Cheat", UI.mainPage, -1, function(state)
	Bp:SetEnabled(state)
end)
	
--DoorESP
UI:addToggleButton("Door ESP", UI.visualsPage, -1, function(state)
	DoorESP:SetEnabled(state)
end)

--Enable Walkspeed Button
UI:addToggleButton("Enable Walkspeed", UI.mainPage, 1, function(state)
	walkspeedActive = state
	local char = game.Players.LocalPlayer.Character

	if char then
		if walkspeedActive then
			char:SetAttribute("SpeedBoost", currentSpeedValue)
		else
			char:SetAttribute("SpeedBoost", 0)
		end
	end
end)

--Change Walkspeed Slider
UI:addSlider("Walkspeed", 0, 75, UI.mainPage, 2, function(value)
	currentSpeedValue = value
	local char = game.Players.LocalPlayer.Character

	if walkspeedActive then
		if char then
			char:SetAttribute("SpeedBoost", value)
		end
	end
end)

