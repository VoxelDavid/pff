--[[
  This script contains variables (constants, in this case) used by scripts
  throughout the game.

  Children of this script are primarily composed of ModuleScripts that
  get require()'d in 'call scripts' inside objects in the Workspace.
--]]

_G.version = "v0.1.0" -- Game version - keep this regularly updated!
_G.modules = script -- Location of ModuleScripts

-- Alert other scripts that global values are ready for use.
_G.ready = true

print("Loaded " .. script.Name)
