-- ui.lua
local UI = {}

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 300)
frame.Position = UDim2.new(0, 50, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 6)

--------------------------------------------------
-- TOGGLE BUTTON FACTORY
--------------------------------------------------

function UI:AddToggle(text, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -10, 0, 32)
	button.Text = text
	button.BackgroundColor3 = Color3.fromRGB(35,35,35)
	button.TextColor3 = Color3.fromRGB(220,220,220)
	button.Parent = frame

	local enabled = false

	button.MouseButton1Click:Connect(function()
		enabled = not enabled

		-- simple visual feedback
		button.BackgroundColor3 = enabled
			and Color3.fromRGB(60, 120, 60)
			or Color3.fromRGB(35, 35, 35)

		callback(enabled)
	end)
end

return UI
