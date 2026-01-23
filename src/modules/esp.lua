
--Variable

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local rooms = workspace.CurrentRooms
local font = Enum.Font.Oswald

--DoorESP

local DoorESP = {}
local DoorHighlights = {}
local DoorEnabled = false
local Doors = {}

local function DoorESP:SetEnabled(state)
    
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

--KeyESP

local KeyESP = {}
local KeyHighlights = {}
local Keys = {}
local KeyEnabled = false

local function KeyESP:SetEnabled(state)
    
   KeyEnabled = state
    
    if KeyEnabled then
        rooms:ChildAdded:Connect(function()
        
            
            for _, obj in ipairs(rooms:GetDescendants()) do
                if obj.Name == "KeyObtain" then
                    table.insert(Keys, obj)
                end
            end            
                
            for _, obj in ipairs(Keys) do
                
                if obj:FindFirstChild("KeyESP") then continue end

                local   esp = Instance.new("Highlight")
                esp.Name = "KeyESP"
                esp.FillColor = Color3.fromRGB(136,231,136)
                esp.OutlineColor = Color3.fromRGB(136,231,136)
                esp.Parent = obj

                local Info = Instance.new("BillboardGui")
                Info.Name = "KeyInfo"
                Info.Size = UDim2.new(0, 200, 0, 50)
                Info.StudsOffset = Vector3.new(0, 2, 0)
                Info.AlwaysOnTop = true
                Info.Parent = child
                Info.Adornee = Info.Parent        

                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.fromScale(1, 1)
                textLabel.BackgroundTransparency = 1
                textLabel.Text = "Key"
                textLabel.TextScaled = true
                textLabel.TextColor3 = Color3.new(255, 255, 255)
                textLabel.Font = font
                textLabel.Parent = Info   
                        
                table.insert(KeyHighlights, esp, Info, textLabel)  
            end
        end)                             
    else
            
            for _,  esp in ipairs(KeyHighlights) do
                if  esp and  esp.Parent then
                    esp:Destroy()
                end
            end

           table.clear(KeyHighlights)
    end   
    
end

--RushESP
local RusheESP = {}
local RushHighlights = {}
local RushEnabled = false
local Rushes = {}

local function RushESP:SetEnabled(state)
    
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

