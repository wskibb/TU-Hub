
--Variable

local ws = game.Workspace
local font = Enum.Font.Oswald

--AmbushESP

local AmbushESP = {}
local AmbushHighlights = {}
local Ambushs = {}
local enabled = false

function AmbushESP:Enable(state)
    
    for _, obj in ipairs(ws:GetChildren()) do
        if obj.Name == "AmbushMoving" then
            table.insert(Ambushs, obj)
        end
    end            
        
    for _, obj in ipairs(Ambushs) do
        
        if obj:FindFirstChild("AmbushInfo") then 
            continue 
        end 

        local Info = Instance.new("BillboardGui")
        Info.Name = "AmbushInfo"
        Info.Size = UDim2.new(0, 200, 0, 25)
        Info.StudsOffset = Vector3.new(0, 2, 0)
        Info.AlwaysOnTop = true
        Info.Parent = obj       
        table.insert(AmbushHighlights, Info)  

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.fromScale(1, 2)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "Ambush"
        textLabel.TextScaled = false
        textLabel.TextSize = 20
        textLabel.TextStrokeTransparency = 0
        textLabel.TextColor3 = Color3.new(0, 0, 1) -- Blue color for Ambush
        textLabel.Font = font
        textLabel.Parent = Info   
        table.insert(AmbushHighlights, textLabel)          
            
    end                               
end

function AmbushESP:Disable()
	for _, obj in ipairs(AmbushHighlights) do
		if obj and obj.Parent then
			obj:Destroy()
		end
	end
	table.clear(AmbushHighlights)

end

function AmbushESP:SetEnabled(state)
	if state and not enabled then
		self:Enable()
	elseif not state and enabled then
		self:Disable()
	end
	enabled = state
end

ws.ChildAdded:Connect(function()
	if not enabled then return end
	task.wait(1)
	AmbushESP:Enable()
end)

return AmbushESP
