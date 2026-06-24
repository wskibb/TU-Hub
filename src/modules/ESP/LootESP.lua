local LootESP = {}

local rooms = workspace.CurrentRooms
local font = Enum.Font.Oswald
local highlightColor = Color3.fromRGB(255, 215, 0)

local enabled = false
local created = {}

local function getAdornee(instance)
	if instance:IsA("BasePart") then
		return instance
	end

	if instance:IsA("Model") then
		return instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart", true)
	end

	return instance:FindFirstChildWhichIsA("BasePart", true)
end

local function getDrawerActivatePrompt(instance)
	local current = instance
	while current and current ~= rooms do
		if current.Name == "DrawerContainer" then
			local knobs = current:FindFirstChild("Knobs")
			if knobs then
				return knobs:FindFirstChild("ActivateEventPrompt")
			end
			return nil
		end

		current = current.Parent
	end

	return nil
end

local function getGoldValue(prompt, loot)
	local current = loot or prompt
	while current and current ~= rooms do
		local value = current:GetAttribute("GoldValue")
		if value ~= nil then
			return value
		end
		current = current.Parent
	end

	return nil
end

local function getLootInstance(prompt)
	local current = prompt.Parent
	while current and current ~= rooms do
		if current:IsA("Model") or current:IsA("BasePart") then
			return current
		end
		current = current.Parent
	end

	return nil
end

local function shouldSkipPrompt(prompt, loot)
	local activatePrompt = getDrawerActivatePrompt(loot or prompt)
	return activatePrompt and activatePrompt:GetAttribute("Interactions") ~= nil
end

local function getLootLabelText(prompt, loot)
	local goldValue = getGoldValue(prompt, loot)
	if goldValue ~= nil then
		return "Gold\n[ " .. tostring(goldValue) .. " ]"
	end

	return "Loot"
end

function LootESP:Enable()
	for _, prompt in ipairs(rooms:GetDescendants()) do
		if not prompt:IsA("ProximityPrompt") or prompt.Name ~= "LootPrompt" then
			continue
		end

		local loot = getLootInstance(prompt)
		if not loot or shouldSkipPrompt(prompt, loot) or loot:FindFirstChild("LootESP") or loot:FindFirstChild("LootInfo") then
			continue
		end

		local adornee = getAdornee(loot)
		if not adornee then
			continue
		end

		local highlight = Instance.new("Highlight")
		highlight.Name = "LootESP"
		highlight.FillColor = highlightColor
		highlight.OutlineColor = highlightColor
		highlight.Parent = loot
		table.insert(created, highlight)

		local info = Instance.new("BillboardGui")
		info.Name = "LootInfo"
		info.Size = UDim2.new(0, 200, 0, 25)
		info.StudsOffset = Vector3.new(0, 2, 0)
		info.AlwaysOnTop = true
		info.Adornee = adornee
		info.Parent = loot
		table.insert(created, info)

		local label = Instance.new("TextLabel")
		label.Size = UDim2.fromScale(1, 2)
		label.BackgroundTransparency = 1
		label.Text = getLootLabelText(prompt, loot)
		label.TextScaled = false
		label.TextSize = 20
		label.TextStrokeTransparency = 0
		label.TextColor3 = highlightColor
		label.Font = font
		label.Parent = info
		table.insert(created, label)
	end
end

function LootESP:Disable()
	for _, obj in ipairs(created) do
		if obj and obj.Parent then
			obj:Destroy()
		end
	end
	table.clear(created)
end

function LootESP:SetEnabled(state)
	if state and not enabled then
		self:Enable()
	elseif not state and enabled then
		self:Disable()
	end
	enabled = state
end

rooms.DescendantAdded:Connect(function(prompt)
	if not enabled then
		return
	end

	if not prompt:IsA("ProximityPrompt") or prompt.Name ~= "LootPrompt" then
		return
	end

	task.wait(0.5)
	LootESP:Enable()
end)

return LootESP
