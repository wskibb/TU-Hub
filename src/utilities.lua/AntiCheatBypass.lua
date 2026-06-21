local Bp = {}
local player = game.Players.LocalPlayer
local enabled = false
local workerId = 0

local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

local function getCollisionClone()
    local character = getCharacter()
    local clone = character:FindFirstChild("CollisionPartClone")

    if clone then
        return clone
    end

    local collisionPart = character:FindFirstChild("CollisionPart")
    if not collisionPart then
        return nil
    end

    clone = collisionPart:Clone()
    clone.Name = "CollisionPartClone"
    clone.CanCollide = false
    clone.Massless = true
    clone.Parent = character

    local collisionCrouch = clone:FindFirstChild("CollisionCrouch")
    if collisionCrouch then
        collisionCrouch:Destroy()
    end

    return clone
end

local function resetMassless()
    local clone = getCollisionClone()
    if clone then
        clone.Massless = true
    end
end

function Bp:SetEnabled(state)
    if state == enabled then
        if not state then
            resetMassless()
        end
        return
    end

    enabled = state
    workerId = workerId + 1

    if not enabled then
        resetMassless()
        return
    end

    local currentWorker = workerId
    task.spawn(function()
        while enabled and currentWorker == workerId do
            local clone = getCollisionClone()
            if clone and clone.Parent then
                clone.Massless = not clone.Massless
            end
            task.wait(0.25)
        end

        if currentWorker == workerId then
            resetMassless()
        end
    end)
end

player.CharacterAdded:Connect(function()
    if enabled then
        getCollisionClone()
    else
        resetMassless()
    end
end)

return Bp
