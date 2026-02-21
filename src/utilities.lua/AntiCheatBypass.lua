local Bp = {}
local player = game.Players.LocalPlayer
local tclp = player.Character.CollisionPart
local enabled = false

local ntclp = tclp:Clone()
ntclp.Name = "CollisionPartClone"
ntclp.CanCollide = false
ntclp.Massless = true
ntclp.Parent = player.Character

local collisionCrouch = ntclp:FindFirstChild("CollisionCrouch")
if collisionCrouch then
    collisionCrouch:Destroy()
end


function Bp:SetEnabled(state)
    enabled = state
    while enabled do
        if ntclp and ntclp.Parent then
            ntclp.Massless = not ntclp.Massless
            task.wait(.25)
        end
    end
end


return Bp