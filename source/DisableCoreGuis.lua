--[[
  Disable core gui elements.
--]]

local gui = game.StarterGui

gui:SetCoreGuiEnabled("PlayerList", false)
gui:SetCoreGuiEnabled("Health", false)
gui:SetCoreGuiEnabled("Backpack", false)

print("Loaded " .. script.Name)
