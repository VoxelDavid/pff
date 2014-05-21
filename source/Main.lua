
--[[
  Game properties -- these are appended to the globally accessible table for
  server-side Scripts and Modules to hook in to.
--]]

_G.Version = "v0.1.0" -- Game version - keep this regularly updated!
_G.Modules = game.ServerScriptService

--[[
  When enabled, this property prevents object replication from the client.

  This means that if the client tries to add parts or manipulate the properties
  of existing parts, the change will not propagate to the server or other
  players.

  As a side effect, this also breaks the majority of Gear created by Roblox.

  Reference:
  - http://wiki.roblox.com/index.php?title=FilteringEnabled_(Property)
  - https://medium.com/roblox-stories/11dd0729d138
--]]
Workspace.FilteringEnabled = true

-- Alert other scripts that global values are ready for use.
_G.Ready = true

print("Loaded " .. script.Name)
