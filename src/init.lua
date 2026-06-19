local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/ui.lua"))()
local DoorESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/DoorESP.lua"))()
local KeyESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/KeyESP.lua"))()
local RushESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/RushESP.lua"))()
local ACBypass = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/utilities.lua/AntiCheatBypass.lua"))()
local Fullbright = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/Visuals/Fullbright.lua"))()
local AntiEyes = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/Exploits/AntiEyes.lua"))()



local plr = game.Players.LocalPlayer

local walkspeedActive = false
local currentSpeedValue = 0

--shutdown

UI:CloseButton(function()
	
	--Walkspeed
	local char = game.Players.LocalPlayer.Character
	
	if char then
		char:SetAttribute("SpeedBoost", 0) 
	end
	
	--ESP
	DoorESP:SetEnabled(false)

	KeyESP:SetEnabled(false)

	--Fullbright
	Fullbright:SetEnabled(false)
	
	--AntiCheatBypass
	ACBypass:SetEnabled(false)

	--AntiEyes
	AntiEyes:SetEnabled(false)
	
end)


--//Buttons\\--

--AntiCheat Bypass
UI:addToggleButton("Bypass Anti-Cheat", UI.mainPage, -1, function(state)
	ACBypass:SetEnabled(state)
end)

--AntiEyes
UI:addToggleButton("AntiEyes", UI.exploitPage, 0, function(state)
	AntiEyes:SetEnabled(state)
end)
	
--DoorESP
UI:addToggleButton("Door ESP", UI.visualsPage, 0, function(state)
	DoorESP:SetEnabled(state)
end)

--KeyESP
UI:addToggleButton("KeyESP", UI.visualsPage, 1, function(state)
	KeyESP:SetEnabled(state)
end)

--RushESP
UI:addToggleButton("RushESP", UI.visualsPage, 2, function(state)
	RushESP:SetEnabled(state)
end)

--Fullbright
UI:addToggleButton("Fullbright", UI.visualsPage, 3, function(state)
	Fullbright:SetEnabled(state)
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

