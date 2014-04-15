--[[
  This script is used to check the current game versions and return if they are
  up-to-date or not.

  The two versions are the built-in PlaceVersion value and a string set in
  Main.lua following the Semantic Versioning Specification (http://semver.org).

  PlaceVersion is a quick way to see if the server instance is out of date, while
  SemVer is a way to be more descriptive with the current game version, along with
  making it clear when creating releases of the software.
--]]

repeat wait() until _G.ready

local Data = require(_G.modules.Data)

local Version = {}

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
--]]
function Version:ConvertToTable(versionString)
  -- versionString = "v0.1.0-alpha.1"
  local versionNumber = versionString:match("v%d+\.%d+\.%d+") -- "v0.1.0"
  local prereleaseVersion = versionString:match("\-%a*\.%d+") -- "-alpha.1"

  local versionTable = {
    full = versionString
  }

  function majorMinorPatch()
    -- Is there a method I can use to accomplish this without an iterator
    -- variable?
    local iterator = 0
    for digit in versionNumber:gmatch("%d+") do
      if iterator == 0 then
        versionTable.major = tonumber(digit)
      elseif iterator == 1 then
        versionTable.minor = tonumber(digit)
      elseif iterator == 2 then
        versionTable.patch = tonumber(digit)
      end

      iterator = iterator + 1
    end
  end

  function prerelease()
    local prereleaseName = prereleaseVersion:match("%a+") -- alpha
    local prereleaseNumber = prereleaseVersion:match("%d+") -- 1

    versionTable[prereleaseName] = prereleaseNumber

    --[[
      A value used to easily get the current prerelease version number, without
      having to search for "alpha" or "beta". eg:

        print(versionTable[versionTable.prerelease]) -- 1
    --]]
    versionTable.prerelease = prereleaseName
  end

  majorMinorPatch()

  if prereleaseVersion then
    prerelease()
  end

  return versionTable
end

--[[
  This convoluted function deciphers the server's semantic version number and
  returns if it's up to date or not.

  The complicated thing is, v0.5.0 is a greater version than v0.4.9, making
  lots of 'if' statements required to figure everything out.
--]]
function Version:LatestSemantic()
  local currentVersion = self:ConvertToTable(_G.version)
  local latestVersion

  if Data:Get("Server", "version") then
    latestVersion = self:ConvertToTable(Data:Get("Server", "version"))
  else
    -- If you forget to set the place version in a new game.
    warn("Latest semantic version does not exist in the \"version\" DataStore. Set to _G.version.")
    latestVersion = self:ConvertToTable(_G.version)
  end

  local majorUpdated
  local minorUpdated

  function compareMajor(current, latest)
    if current.major > latest.major then
      majorUpdated = true
      return true -- MAJOR was updated.
    elseif current.major == latest.major then
      return true -- MAJOR is the same as latest.
    else
      return false
    end
  end

  function compareMinor(current, latest)
    if current.minor < latest.minor and majorUpdated == true then
      minorUpdated = true
      return true -- MINOR decreased in value, MAJOR was updated.
    elseif current.minor > latest.minor then
      minorUpdated = true
      return true -- MINOR went up in value
    elseif current.minor == latest.minor then
      return true -- MINOR is the same as latest.
    else
      return false
    end
  end

  function comparePatch(current, latest)
    if current.patch < latest.patch and minorUpdated == true then
      return true -- PATCH decreased in value, MINOR was updated.
    elseif current.patch > latest.patch then
      return true -- PATCH is greater than latest.
    elseif current.patch == latest.patch then
      return true -- PATCH is the same as latest.
    else
      return false
    end
  end

  function comparePrerelease(current, latest)
    local pre = current.prerelease -- "alpha"

    if current[pre] >= latest[pre] then
      return true
    else
      return false
    end
  end

  function compareVersions(current, latest)
    local major = compareMajor(current, latest)
    local minor = compareMinor(current, latest)
    local patch = comparePatch(current, latest)
    local prerelease = comparePrerelease(current, latest)

    -- print(major, minor, patch, prerelease)

    if major and minor and patch then
      if prerelease then
        return true
      else
        return false
      end

      return true
    else
      return false
    end
  end

  return compareVersions(currentVersion, latestVersion)
end

--[[
  Compare the PlaceVersion value against the one on the server and return if
  the current one is up to date or not.

  (SO much easier than the semantic version number)
--]]
function Version:LatestPlace()
  local currentVersion = game.PlaceVersion
  local latestVersion

  if Data:Get("Server", "placeVersion") then
    latestVersion = Data:Get("Server", "placeVersion")
  else
    warn("Latest place version does not exist in the \"version\" DataStore. Set to game.PlaceVersion.")
    latestVersion = game.PlaceVersion
  end

  if currentVersion >= latestVersion then
    return true
  else
    return false
  end
end

--[[
  Pushes up the current Semantic and Place versions to the "Server" datastore if
  they are the same or greater than the ones stored.
--]]
function Version:UpdateStoredData()
  local latestSemanticVersion = self:LatestSemantic()
  local latestPlaceVersion = self:LatestPlace()

  if latestSemanticVersion then
    Data:put("Server", "version", _G.version)
  end

  if latestPlaceVersion then
    Data:put("Server", "placeVersion", game.PlaceVersion)
  end
end

function warn(message)
  game:GetService("TestService"):Warn(false, message)
end

return Version
