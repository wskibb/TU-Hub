
--Variable

local rooms = workspace.CurrentRooms
local font = Enum.Font.Oswald

--KeyESP

local KeyESP = {}
local KeyHighlights = {}
local Keys = {}
local enabled = false

function KeyESP:Enable(state)
    
    for _, obj in ipairs(rooms:GetDescendants()) do
        if obj.Name == "KeyObtain" then
            table.insert(Keys, obj)
        end
    end            
        
    for _, obj in ipairs(Keys) do
        
        if obj:FindFirstChild("KeyESP") then 
            continue 
        end

        local   esp = Instance.new("Highlight")
        esp.Name = "KeyESP"
        esp.FillColor = Color3.fromRGB(136,231,136)
        esp.OutlineColor = Color3.fromRGB(136,231,136)
        esp.Parent = obj
        table.insert(KeyHighlights, esp)  

        local Info = Instance.new("BillboardGui")
        Info.Name = "KeyInfo"
        Info.Size = UDim2.new(0, 200, 0, 25)
        Info.StudsOffset = Vector3.new(0, 2, 0)
        Info.AlwaysOnTop = true
        Info.Parent = obj       
        table.insert(KeyHighlights, Info)  

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.fromScale(1, 2)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "Key"
        textLabel.TextScaled = false
        textLabel.TextSize = 20
        textLabel.TextStrokeTransparency = 0
        textLabel.TextColor3 = Color3.new(255, 255, 255)
        textLabel.Font = font
        textLabel.Parent = Info   
        table.insert(KeyHighlights, textLabel)          
            
    end                               
end

function KeyESP:Disable()
	for _, obj in ipairs(KeyHighlights) do
		if obj and obj.Parent then
			obj:Destroy()
		end
	end
	table.clear(KeyHighlights)

end

function KeyESP:SetEnabled(state)
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
	KeyESP:Enable()
end)

return KeyESP


