--[[
  This module is used to easily make calls to the data store service.

  ToDo:
  - Implement Scopes
]]

local DataStore = game:GetService("DataStoreService")

-- Creates a new key/value pair in the data store.
function post(storeName, key, value)
  local dataStore = DataStore:GetDataStore(storeName)
  dataStore:SetAsync(key, value)
end

-- Updates/creates a key/value pair in the data store.
function put(storeName, key, value)
  local dataStore = DataStore:GetDataStore(storeName)

  function updateCallback()
    return value
  end

  return dataStore:UpdateAsync(key, updateCallback)
end

-- Returns the key from the data store for use in the game.
function get(storeName, key)
  local dataStore = DataStore:GetDataStore(storeName)
  return dataStore:GetAsync(key)
end

-- Sets the key's value to nil, as there is currently no way to
-- actually delete a key.
function delete(storeName, key)
  local deletedValue = "404"

  post(storeName, key, deletedValue)
end

return {
  -- Named after the HTTP request methods. :)
  POST = post,
  PUT = put,
  GET = get,
  DELETE = delete
}
