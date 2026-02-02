local DoorESP = {}

local rooms = workspace.CurrentRooms
local font = Enum.Font.Oswald

local enabled = false
local created = {}

function DoorESP:Enable()
	
	
		for _, model in ipairs(rooms:GetDescendants()) do
			if model:IsA("Model") and model.Name == "Door" then

				model.AttributeChanged:Connect(function(a)
					if a == "Opened" and model:GetAttribute("Opened") == true then
						task.wait(5)
						
						local info = model:FindFirstChild("DoorInfo")
						local esp = model:FindFirstChild("DoorESP")

						if info then
							local index = table.find(created, info)
							if index then table.remove(created, index) end
							info:Destroy()
						end

						if esp then
							local index = table.find(created, esp)
							if index then table.remove(created, index) end
							esp:Destroy()
						end

						
					end	
				end)

				if model:FindFirstChild("DoorESP") or model:GetAttribute("Opened") then
					print("found one")	
					continue
				end


				
				local hidden = model:FindFirstChild("Hidden")
				if hidden then
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
				info.Size = UDim2.new(0, 200, 0, 25)
				info.StudsOffset = Vector3.new(0, 2, 0)
				info.AlwaysOnTop = true
				info.Adornee = model.PrimaryPart
				info.Parent = model
				table.insert(created, info)

				local label = Instance.new("TextLabel")
				label.Size = UDim2.fromScale(1, 1)
				label.BackgroundTransparency = 1
				label.TextScaled = true
				label.TextColor3 = Color3.new(181, 101, 29)
				label.TextStrokeTransparency = 0
				label.Font = font

				local currentRoom = tonumber(model.Parent.Name)
				label.Text = "Door:\n[ " .. (currentRoom and tostring(currentRoom + 1) or "?") .. " ]"
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

end

function DoorESP:SetEnabled(state)
	if state and not enabled then
		self:Enable()
	elseif not state and enabled then
		self:Disable()
	end
	enabled = state
end

rooms.ChildAdded:Connect(function(room)
	if not enabled then return end
	task.wait(1)
	DoorESP:Enable()
end)

return DoorESP


