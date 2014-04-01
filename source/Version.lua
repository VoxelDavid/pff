--[[

]]

repeat wait() until _G.ready

local Data = require(_G.modules.Data)

--[[
  Takes the version string and seperates each part into a key/value pair in a table.
  eg. v0.1.0-alpha.1 would be turned into:

  {
    "full" = "v0.1.0-alpha.1",
    "major" = 0,
    "minor" = 1,
    "patch" = 0,
    "alpha" = 1
  }

]]
function convertVersionToTable(fullVersion)
  -- fullVersion = "v0.1.0-alpha.1"
  local versionNumber = fullVersion:match("v%d\.%d\.%d") -- "v0.1.0"
  local prereleaseVersion = fullVersion:match("\-%a*\.%d") -- "-alpha.1"

  local versionTable = {
    full = fullVersion
  }

  function majorMinorPatch()
    -- Is there a method I can use to accomplish this
    -- without an iterator variable?
    local iterator = 0
    for digit in versionNumber:gmatch("%d") do
      if iterator == 0 then
        versionTable.major = digit
      elseif iterator == 1 then
        versionTable.minor = digit
      elseif iterator == 2 then
        versionTable.patch = digit
      end

      iterator = iterator +1
    end
  end

  function prerelease()
    versionTable[prereleaseVersion:match("%a+")] = prereleaseVersion:match("%d") -- alpha = 1
  end
  end

  majorMinorPatch()

  if prereleaseVersion then
    prerelease()
  end

  return versionTable
end

convertVersionToTable()
