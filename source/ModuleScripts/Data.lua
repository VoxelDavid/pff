--[[
  This module is used to easily make calls to the data store service.

  Usage:

    local data = require(path.to.module)

    data.put("Server", "version", "v0.1.0")
    print(data.get("Server", "version")) -- "v0.1.0"

    data.delete("Server", "version")
    print(data.get("Server", "version")) -- "deleted"

  ToDo:
  - Implement Scopes
]]

local DataStore = game:GetService("DataStoreService")

local Data = {
  -- Functions are named after the HTTP request methods. :)

  -- Creates a new key/value pair in the data store.
  post = function(storeName, key, value)
    local dataStore = DataStore:GetDataStore(storeName)
    dataStore:SetAsync(key, value)
  end,

  -- Updates/creates a key/value pair in the data store.
  put = function(storeName, key, value)
    local dataStore = DataStore:GetDataStore(storeName)

    function updateCallback()
      return value
    end

    dataStore:UpdateAsync(key, updateCallback)
  end,

  -- Returns the key from the data store for use in the game.
  get = function(storeName, key)
    local dataStore = DataStore:GetDataStore(storeName)
    return dataStore:GetAsync(key)
  end,

  -- Sets the key's value to the string "deleted" to indicate
  -- that it's been removed.
  delete = function(storeName, key)
    post(storeName, key, "deleted")
  end
}

return Data
