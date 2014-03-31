--[[
  This module is used to easily make calls to the data store service.

  Usage:

    local data = require(path.to.module)

    data.put("Server", "version", "v0.1.0")
    print(data.get("Server", "version")) -- "v0.1.0"

    data.delete("Server", "version")
    print(data.get("Server", "version")) -- "deleted"

  Namespaces/Scopes can be set as an optional last argument:

    data.put("Server", "version", "v0.1.0-alpha.1", "customNamespace")
    print(data.get("Server", "version")) -- "v0.1.0" (Assuming you used the earlier example, otherwise no value will appear.)
    print(data.get("Server", "version", "customNamespace")) -- "v0.1.0-alpha.1"
]]

local DataStore = game:GetService("DataStoreService")

local globalScope = "global" -- default scope

local Data = {
  -- Functions are named after the HTTP request methods. :)

  -- Creates a new key/value pair in the data store.
  post = function(storeName, key, value, scope)
    local scope = scope or globalScope
    local dataStore = DataStore:GetDataStore(storeName, scope)

    dataStore:SetAsync(key, value)
  end,

  -- Updates/creates a key/value pair in the data store.
  put = function(storeName, key, value, scope)
    local scope = scope or globalScope
    local dataStore = DataStore:GetDataStore(storeName, scope)

    function updateCallback()
      return value
    end

    dataStore:UpdateAsync(key, updateCallback)
  end,

  -- Returns the key from the data store for use in the game.
  get = function(storeName, key, scope)
    local scope = scope or globalScope
    local dataStore = DataStore:GetDataStore(storeName, scope)

    return dataStore:GetAsync(key)
  end,

  -- Sets the key's value to the string "deleted" to indicate
  -- that it's been removed.
  delete = function(storeName, key, scope)
    local scope = scope or globalScope

    post(storeName, key, "deleted", scope)
  end
}

return Data
