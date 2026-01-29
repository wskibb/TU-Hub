local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/ui.lua"))()
local DoorESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/DoorESP.lua"))()
local KeyESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/testingwow/refs/heads/main/src/modules/key_esp.lua"))()

--------------------------------------------------
-- BUTTON VERBINDEN
--------------------------------------------------

--Buttons for Main Page

UI:addToggleButton("Walkspeed", mainPage, function(state)
	DoorESP:SetEnabled(state)
end)

UI:AddToggle("Key ESP", function(state)
	KeyESP:SetEnabled(state)
end)
