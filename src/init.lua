local UI = 
local DoorESP = 
local KeyESP = 

--------------------------------------------------
-- BUTTON VERBINDEN
--------------------------------------------------

UI:AddToggle("Door ESP", function(state)
	DoorESP:SetEnabled(state)
end)

UI:AddToggle("Key ESP", function(state)
	KeyESP:SetEnabled(state)
end)
