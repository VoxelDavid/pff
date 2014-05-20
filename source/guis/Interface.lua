local player     = game.Players.LocalPlayer
local gui        = player.PlayerGui
local starterGui = game.StarterGui

-- The game's interface container.
local interface = gui:FindFirstChild("Interface")

function disableCoreGuis()
  starterGui:SetCoreGuiEnabled("Health", false)
  starterGui:SetCoreGuiEnabled("Backpack", false)
end

disableCoreGuis()

print("Loaded " .. script.Name)
