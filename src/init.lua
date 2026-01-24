local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/ui.lua"))()
local DoorESP = 
local KeyESP = 
local RushESP =

--------------------------------------------------
-- BUTTON VERBINDEN
--------------------------------------------------

UI:AddToggle("Door ESP", function(state)
	DoorESP:SetEnabled(state)
end)

UI:AddToggle("Key ESP", function(state)
	KeyESP:SetEnabled(state)
end)

UI:AddToggle("RushESP", function(state)
	RushESP:SetEnabled(state)
end)
