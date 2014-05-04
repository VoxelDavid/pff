
--[[
  Game properties -- these are appended to the globally accessible table for
  server-side Scripts and Modules to hook in to.
--]]

_G.version = "v0.1.0" -- Game version - keep this regularly updated!
_G.modules = script -- Location of ModuleScripts

-- Alert other scripts that global values are ready for use.
_G.ready = true

print("Loaded " .. script.Name)
