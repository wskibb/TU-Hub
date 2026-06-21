local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/ui.lua"))()
local DoorESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/DoorESP.lua"))()
local KeyESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/KeyESP.lua"))()
local RushESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/RushESP.lua"))()
local ACBypass = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/utilities.lua/AntiCheatBypass.lua"))()
local Fullbright = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/Visuals/Fullbright.lua"))()
local AntiEyes = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/Exploits/AntiEyes.lua"))()
local AmbushESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/AmbushESP.lua"))()
local AutoLoot = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/Exploits/AutoLoot.lua"))()



local plr = game.Players.LocalPlayer

local walkspeedActive = false
local currentSpeedValue = 0

local mainMovementSection = UI:createSection("Movement", UI.mainPage, 0)
local visualsEspSection = UI:createSection("ESP", UI.visualsPage, 0)
local visualsEnvironmentSection = UI:createSection("Environment", UI.visualsPage, 1)
local exploitProtectionSection = UI:createSection("Protection", UI.exploitPage, 0)
local exploitLootingSection = UI:createSection("Looting", UI.exploitPage, 1)

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
	--AmbushESP
	AmbushESP:SetEnabled(false)
	--AutoLoot
	AutoLoot:SetEnabled(false)
	
end)


--//Buttons\\--

--AntiCheat Bypass
UI:addToggleButton("Bypass Anti-Cheat", exploitProtectionSection, 0, function(state)
	ACBypass:SetEnabled(state)
end)

--AntiEyes
UI:addToggleButton("AntiEyes", exploitProtectionSection, 1, function(state)
	AntiEyes:SetEnabled(state)
end)

--AutoLoot
UI:addToggleButton("AutoLoot", exploitLootingSection, 0, function(state)
	AutoLoot:SetEnabled(state)
end)
	
--DoorESP
UI:addToggleButton("Door ESP", visualsEspSection, 0, function(state)
	DoorESP:SetEnabled(state)
end)

--KeyESP
UI:addToggleButton("KeyESP", visualsEspSection, 1, function(state)
	KeyESP:SetEnabled(state)
end)

--RushESP
UI:addToggleButton("RushESP", visualsEspSection, 2, function(state)
	RushESP:SetEnabled(state)
end)

--Fullbright
UI:addToggleButton("Fullbright", visualsEnvironmentSection, 0, function(state)
	Fullbright:SetEnabled(state)
end)

--AmbushESP
UI:addToggleButton("AmbushESP", visualsEspSection, 3, function(state)
	AmbushESP:SetEnabled(state)
end)


--Enable Walkspeed Button
UI:addToggleButton("Enable Walkspeed", mainMovementSection, 0, function(state)
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
UI:addSlider("Walkspeed", 0, 75, mainMovementSection, 1, function(value)
	currentSpeedValue = value
	local char = game.Players.LocalPlayer.Character

	if walkspeedActive then
		if char then
			char:SetAttribute("SpeedBoost", value)
		end
	end
end)

