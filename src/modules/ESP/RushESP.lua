
--Variable

local rooms = workspace.CurrentRooms
local font = Enum.Font.Oswald

--RushESP
local RushESP = {}
local RushHighlights = {}
local RushEnabled = false
local Rushes = {}

function RushESP:SetEnabled(state)
    
    RushEnabled = state 

    if RushEnabled then
        workspace.ChildAdded:Connect(function()
            
            for _, child in ipairs(workspace:GetChildren()) do
                if child.Name == "RushMoving" then
                    table.insert(Rushes, child)
                end
            end

            for _, Rush in ipairs(Rushes) do
                if Rush then
                    if Rush:FindFirstChild("RushESP") then 
                    continue
                    end

                    local RushESP = Instance.new("BillboardGui")
                    RushESP.Name = "RushESP"
                    RushESP.Size = UDim2.new(0, 200, 0, 50)
                    RushESP.StudsOffset = Vector3.new(0, 2, 0)
                    RushESP.AlwaysOnTop = true
                    RushESP.Parent = Rush

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.fromScale(1, 1)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Text = "Rush"
                    textLabel.TextScaled = true
                    textLabel.TextColor3 = Color3.new(255, 0, 0)
                    textLabel.Font = font
                    textLabel.Parent = RushESP

                    table.insert(RushHighlights, RushESP, textLabel)
                end
            end
        end)
    else
        for _, esp in ipairs(RushHighlights) do
            if esp and esp.Parent then
                esp:Destroy()
            end
        end
        
        table.clear(RushHighlights)
    end
end