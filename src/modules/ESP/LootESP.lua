--Variables

local rooms = Workspace.CurrentRooms
local font = Enum.Font.Oswald

--LootESP

local LootESP = {}
local Loot = {}
local LootHighlights = {}
local enabled = false



print("works till 15")

function LootESP:Enable(state)
    print("works till 18")
    for _, obj in ipairs(rooms:GetDescendants()) do
        if obj.Name == "GoldPile" then
            table.insert(Loot, obj)
        end
    end

    for _, obj in ipairs(Loot) do
        
        local prnt = obj.Parent

        
        if prnt.Knobs.ActivateEventPrompt:GetAttribute("Interactions") or obj:FindFirstChild("LootESP") then
            continue
        end
        
        
        local highlight = Instance.new("Highlight")
		highlight.Name = "LootESP"
        highlight.FillColor = Color3.fromRGB(181, 101, 29)
        highlight.OutlineColor = Color3.fromRGB(181, 101, 29)
        highlight.Parent = obj
        table.insert(LootHighlights, highlight)

        local info = Instance.new("BillboardGui")
        info.Name = "LootInfo"
        info.Size = UDim2.new(0, 200, 0, 25)
        info.StudsOffset = Vector3.new(0, 2, 0)
        info.AlwaysOnTop = true
        info.Adornee = obj.PrimaryPart
        info.Parent = obj
        table.insert(LootHighlights, info)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.fromScale(1, 2)
        label.BackgroundTransparency = 1
        label.TextScaled = false
        label.TextSize = 20
        label.TextColor3 = Color3.new(181, 101, 29)
        label.TextStrokeTransparency = 0
        label.Font = font

        
        label.Text = "Gold:\n[ " .. (obj.GoldValue) .. " ]"
        label.Parent = info
        table.insert(LootHighlights, label)		
    end
end

function LootESP:Disable()
    for _, obj in ipairs(LootHighlights) do
        if obj and obj.Parent then
			obj:Destroy()
		end
    end
    table.clear(LootHighlights)
end

function LootESP:SetEnabled(state)
    if state and not enabled then
        self:Enable()
    elseif not state and enabled then
        self:Disable()
    end
    enabled = state
end

rooms.ChildAdded:Connect(function()
    if not enabled then return end
    task.wait(1)
    LootESP:Enable()
end)

return LootESP