local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/ui.lua"))()
local DoorESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/DoorESP.lua"))()
local KeyESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/KeyESP.lua"))()
local RushESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/RushESP.lua"))()

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
