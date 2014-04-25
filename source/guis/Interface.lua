local starterGui = game.StarterGui

function disableCoreGuis()
  gui:SetCoreGuiEnabled("Health", false)
  gui:SetCoreGuiEnabled("Backpack", false)
end

disableCoreGuis()

print("Loaded " .. script.Name)
