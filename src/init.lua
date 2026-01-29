local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/ui.lua"))()
local DoorESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wskibb/TU-Hub/refs/heads/main/src/modules/ESP/DoorESP.lua"))()


--------------------------------------------------
-- BUTTON VERBINDEN
--------------------------------------------------

--Buttons for Main Page

UI:addToggleButton("Walkspeed", UI.mainPage, function(state)
	DoorESP:SetEnabled(state)
end)


