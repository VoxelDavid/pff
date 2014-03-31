--[[
  This module is used to easily make calls to the data store service.

  Usage:

    -- Where this module is located in the game.
    local data = require(game.Workspace.DataModule)

    data:put("Server", "version", "v0.1.0")
    print(data:get("Server", "version")) -- "v0.1.0"

    data:delete("Server", "version")
    print(data:get("Server", "version")) -- "deleted"

  Namespaces/Scopes can be set as an optional last argument:

    data:put("Server", "version", "v0.1.0-alpha.1", "customNamespace")
    print(data:get("Server", "version")) -- "v0.1.0" (Assuming you used the earlier example, otherwise no value will appear.)
    print(data:get("Server", "version", "customNamespace")) -- "v0.1.0-alpha.1"

  If you want to understand how some aspects of this module works, then I
  encourage you to take a look at the following Wiki pages:

  - http://wiki.roblox.com/index.php?title=Module_scripts
  - http://wiki.roblox.com/index.php?title=Data_store
  - http://wiki.roblox.com/index.php?title=Methods
  - http://wiki.roblox.com/index.php?title=Boolean#Or
]]

local DataStore = game:GetService("DataStoreService")

local globalScope = "global" -- default scope

local Data = {
  -- Functions are named after the HTTP request methods. :)

  --[[
    Parameters:

    - self      {table}  Set automatically when the colon is used to call the function.
    - storeName {string} The name of the DataStore you want to access.
    - key       {string} The key name to be used with the value when inserting the data.
    - value     {any}    Accepts any value (Other than 'nil') to be applied as the value for 'key'.
    - scope     {string} Optional last argument to set the scope/namespace of the Data Store.
  ]]

  -- Creates a new key/value pair in the data store.
  post = function(self, storeName, key, value, scope)
    local scope = scope or globalScope
    local dataStore = DataStore:GetDataStore(storeName, scope)

    dataStore:SetAsync(key, value)
  end,

  -- Updates/creates a key/value pair in the data store.
  put = function(self, storeName, key, value, scope)
    local scope = scope or globalScope
    local dataStore = DataStore:GetDataStore(storeName, scope)

    function updateCallback()
      return value
    end

    dataStore:UpdateAsync(key, updateCallback)
  end,

  -- Returns the key from the data store for use in the game.
  get = function(self, storeName, key, scope)
    local scope = scope or globalScope
    local dataStore = DataStore:GetDataStore(storeName, scope)

    return dataStore:GetAsync(key)
  end,

  -- Sets the key's value to the string "deleted" to indicate
  -- that it's been removed.
  delete = function(self, storeName, key, scope)
    local scope = scope or globalScope

    self:post(storeName, key, "deleted", scope)
  end
}

return Data
