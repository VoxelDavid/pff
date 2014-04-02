--[[

]]

repeat wait() until _G.ready

local Data = require(_G.modules.Data)

--[[
  Takes the version string and seperates each part into a key/value pair in
  a table. Eg. "v0.1.0-alpha.1" would be turned into:

  {
    "full" = "v0.1.0-alpha.1",
    "major" = 0,
    "minor" = 1,
    "patch" = 0,
    "alpha" = 1,
    "prerelease" = true
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
    local prereleaseName = prereleaseVersion:match("%a+") -- alpha
    local prereleaseNumber = prereleaseVersion:match("%d") -- 1

    versionTable[prereleaseName] = prereleaseNumber

    -- A value used to check if the current version is a prerelease
    -- without needing to look for "alpha" or "beta" strings.
    versionTable.prerelease = true
  end

  majorMinorPatch()

  if prereleaseVersion then
    prerelease()
  end

  return versionTable
end

function latestSemanticVersion()
  local currentVersion = convertVersionToTable(_G.version)
  local latestVersion = convertVersionToTable(Data:get("Server", "version"))

  print("Current version: " .. _G.version)
  print("Latest version: " .. Data:get("Server", "version"))

  function compareVersions(current, latest)
    local majorUpdated
    local minorUpdated

    if current.major > latest.major then
      majorUpdated = true
      print "MAJOR was updated."
    elseif current.major < latest.major then
      majorUpdated = false
      print "MAJOR is out of date."
    end

    -- If MAJOR has been updated but MINOR is a lower value than latest, return true

    if current.minor < latest.minor and majorUpdated == true then
      minorUpdated = true
      print "MINOR decreased in value, MAJOR was updated."
    elseif current.minor > latest.minor then
      minorUpdated = true
      print "MINOR is greater than latest"
    elseif current.minor < latest.minor or majorUpdated == false then
      minorUpdated = false
      print "MINOR is out of date"
    end

    -- If MINOR has been updated but PATCH is a lower value than latest, return true

    if current.patch < latest.patch and minorUpdated == true then
      print "PATCH decreased in value, MINOR was updated."
    elseif current.patch > latest.patch then
      print "PATCH is greater than latest."
    elseif current.patch < latest.patch or minorUpdated == false then
      print "PATCH is out of date."
    end
  end

  compareVersions(currentVersion, latestVersion)
end

