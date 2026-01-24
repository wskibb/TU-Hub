
--Variable

local rooms = workspace.CurrentRooms
local font = Enum.Font.Oswald

--DoorESP

local DoorESP = {}
local DoorHighlights = {}
local DoorEnabled = false
local Doors = {}

function DoorESP:SetEnabled(state)
    
    DoorEnabled = state

    if DoorEnabled then
        
        for _, child in ipairs(rooms:GetDescendants()) do
            if child.Name == "Door" then
                if child:IsA("Model") then
                    table.insert(Doors, child)
                end
                    
                    
                
                for _, child in ipairs(Doors) do
                    
                    if child:FindFirstChild("DoorESP") or child:FindFirstChild("Info") then 
                        continue 
                    end
                    
                    child.Hidden.Transparency = 1
                    
                    local DoorESP = Instance.new("Highlight")
                    DoorESP.Name = "DoorESP"
                    DoorESP.FillColor = Color3.fromRGB(181, 101, 29)
                    DoorESP.OutlineColor = Color3.fromRGB(181, 101, 29)
                    DoorESP.Parent = child

                    local Info = Instance.new("BillboardGui")
                    Info.Name = "DoorInfo"
                    Info.Size = UDim2.new(0, 200, 0, 50)
                    Info.StudsOffset = Vector3.new(0, 2, 0)
                    Info.AlwaysOnTop = true
                    Info.Parent = child
                    Info.Adornee = Info.Parent.Door

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.fromScale(1, 1)
                    textLabel.BackgroundTransparency = 1
                    local currentRoom = tonumber(child.Parent.Name)
                    if currentRoom then
                        textLabel.Text = tostring(currentRoom + 1)
                    else
                        textLabel.Text = "?"
                    end
                    textLabel.TextScaled = true
                    textLabel.TextColor3 = Color3.new(255, 255, 255)
                    textLabel.Font = font
                    textLabel.Parent = Info   
                    
                    table.insert(DoorHighlights, DoorESP, Info, textlabel)
                
                end
            end
        end 

    else            
        
        for _,  esp in ipairs(DoorHighlights) do
            if  esp and  esp.Parent then
                esp:Destroy()              
            end
        end            

        table.clear(DoorHighlights)

    end
end



