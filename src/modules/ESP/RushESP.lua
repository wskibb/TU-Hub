
--Variable

local ws = game.Workspace
local font = Enum.Font.Oswald

--RushESP

local RushESP = {}
local RushHighlights = {}
local Rushs = {}
local enabled = false

function RushESP:Enable(state)
    
    for _, obj in ipairs(ws:GetChildren()) do
        if obj.Name == "RushMoving" then
            table.insert(Rushs, obj)
        end
    end            
        
    for _, obj in ipairs(Rushs) do
        
        if obj:FindFirstChild("RushInfo") then 
            continue 
        end 

        local Info = Instance.new("BillboardGui")
        Info.Name = "RushInfo"
        Info.Size = UDim2.new(0, 200, 0, 25)
        Info.StudsOffset = Vector3.new(0, 2, 0)
        Info.AlwaysOnTop = true
        Info.Parent = obj       
        table.insert(RushHighlights, Info)  

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.fromScale(1, 2)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "Rush"
        textLabel.TextScaled = false
        textLabel.TextSize = 20
        textLabel.TextStrokeTransparency = 0
        textLabel.TextColor3 = Color3.new(1, 0, 0)
        textLabel.Font = font
        textLabel.Parent = Info   
        table.insert(RushHighlights, textLabel)          
            
    end                               
end

function RushESP:Disable()
	for _, obj in ipairs(RushHighlights) do
		if obj and obj.Parent then
			obj:Destroy()
		end
	end
	table.clear(RushHighlights)

end

function RushESP:SetEnabled(state)
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
	RushESP:Enable()
end)

return RushESP


