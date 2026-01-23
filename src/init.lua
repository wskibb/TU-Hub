local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/ui.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/esp.lua"))()

--------------------------------------------------
-- BUTTON VERBINDEN
--------------------------------------------------

UI:AddToggle("Door ESP", function(state)
	DoorESP:SetEnabled(state)
end)

UI:AddToggle("Key ESP", function(state)
	KeyESP:SetEnabled(state)
end)
