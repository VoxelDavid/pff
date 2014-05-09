
--[[
  Game properties -- these are appended to the globally accessible table for
  server-side Scripts and Modules to hook in to.
--]]

_G.Version = "v0.1.0" -- Game version - keep this regularly updated!
_G.Modules = game.ServerScriptService

-- Alert other scripts that global values are ready for use.
_G.Ready = true

print("Loaded " .. script.Name)
