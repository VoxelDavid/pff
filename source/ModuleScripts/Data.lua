--[[
  This module is used to easily make calls to the data store service.

  ToDo:
  - Implement Scopes
]]

local DataStore = game:GetService("DataStoreService")

-- Creates a new key/value pair in the data store.
function create(storeName, key, value)
  local dataStore = DataStore:GetDataStore(storeName)
  dataStore:SetAsync(key, value)
end

-- Returns the key from the data store for use in the game.
function get(storeName, key)
  local dataStore = DataStore:GetDataStore(storeName)
  return dataStore:GetAsync(key)
end

return {
  POST = create,
  GET = get
}
