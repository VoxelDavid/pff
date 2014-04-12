--[[
  This script provides an easy way of copying LocalScripts and other objects to
  players when they first join or respawn.

  Until Roblox provides a means of copying local objects to players other than
  StarterGui or StarterPack, this script should act as a good supplement.

  All desendants of this script are copied to the Player's character, so just
  plop in your LocalScripts or Values and be on your way.
--]]

-- The name of the Configuration instance where objects for each player are
-- stored.
local storageName = "PlayerScripts"

game.Players.PlayerAdded:connect(function(player)
  player.CharacterAdded:connect(copyToPlayerCharacter)
end)

function copyToPlayerCharacter(char)
  local localPlayerStorage = cloneLocation(char)

  cloneObjectsTo(localPlayerStorage)
end

function cloneLocation(location)
  if not location:FindFirstChild(storageName) then
    local storage = Instance.new("Configuration", location)
    storage.Name = storageName
  end
  return location:FindFirstChild(storageName)
end

function cloneObjectsTo(location)
  for _,child in pairs(script:GetChildren()) do
    local clonedChild = child:clone()
    clonedChild.Parent = location
  end
end

print("Loaded " .. script.Name)
