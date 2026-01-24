local DoorESP = {}

local rooms = workspace.CurrentRooms
local font = Enum.Font.Oswald

local enabled = false
local created = {}
local originalTransparency = {}

function DoorESP:Enable()
	for _, model in ipairs(rooms:GetDescendants()) do
		if model:IsA("Model") and model.Name == "Door" then

			if model:FindFirstChild("DoorESP") then
				continue
			end

			local hidden = model:FindFirstChild("Hidden")
			if hidden then
				originalTransparency[hidden] = hidden.Transparency
				hidden.Transparency = 1
			end

			local highlight = Instance.new("Highlight")
			highlight.Name = "DoorESP"
			highlight.FillColor = Color3.fromRGB(181, 101, 29)
			highlight.OutlineColor = Color3.fromRGB(181, 101, 29)
			highlight.Parent = model
			table.insert(created, highlight)

			local info = Instance.new("BillboardGui")
			info.Name = "DoorInfo"
			info.Size = UDim2.new(0, 200, 0, 50)
			info.StudsOffset = Vector3.new(0, 2, 0)
			info.AlwaysOnTop = true
			info.Adornee = model.PrimaryPart
			info.Parent = model
			table.insert(created, info)

			local label = Instance.new("TextLabel")
			label.Size = UDim2.fromScale(1, 1)
			label.BackgroundTransparency = 1
			label.TextScaled = true
			label.TextColor3 = Color3.new(1, 1, 1)
			label.Font = font

			local currentRoom = tonumber(model.Parent.Name)
			label.Text = currentRoom and tostring(currentRoom + 1) or "?"
			label.Parent = info
			table.insert(created, label)
		end
	end
end

function DoorESP:Disable()
	for _, obj in ipairs(created) do
		if obj and obj.Parent then
			obj:Destroy()
		end
	end
	table.clear(created)

	for part, value in pairs(originalTransparency) do
		if part and part.Parent then
			part.Transparency = value
		end
	end
	table.clear(originalTransparency)
end



return DoorESP
