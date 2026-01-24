
--Variable

local rooms = workspace.CurrentRooms
local font = Enum.Font.Oswald

--KeyESP

local KeyESP = {}
local KeyHighlights = {}
local Keys = {}
local KeyEnabled = false

function KeyESP:SetEnabled(state)
    
   KeyEnabled = state
    
    if KeyEnabled then
        rooms.ChildAdded:Connect(function()
        
            
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

                local Info = Instance.new("BillboardGui")
                Info.Name = "KeyInfo"
                Info.Size = UDim2.new(0, 200, 0, 50)
                Info.StudsOffset = Vector3.new(0, 2, 0)
                Info.AlwaysOnTop = true
                Info.Parent = obj       

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

