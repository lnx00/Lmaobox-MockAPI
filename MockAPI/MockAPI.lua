local mockagne = require("MockAPI.mockagne")

local function Log(message)
    print(string.format("[MockAPI] %s", message))
end

-- Constants
dofile("MockAPI/Globals")
dofile("MockAPI/Enums")

-- Classes
dofile("MockAPI/Classes/Vector3.lua")
dofile("MockAPI/Classes/EulerAngles.lua")

-- Libraries
callbacks = mockagne.getMock("Callbacks")
client = mockagne.getMock("Client")
clientstate = mockagne.getMock("Clientstate")
draw = mockagne.getMock("Draw")
engine = mockagne.getMock("Engine")
entities = mockagne.getMock("Entities")
filesystem = mockagne.getMock("FileSystem")
gamecoordinator = mockagne.getMock("GameCoordinator")
gamerules = mockagne.getMock("GameRules")
globals = mockagne.getMock("Globals")
gui = mockagne.getMock("GUI")
input = mockagne.getMock("Input")
inventory = mockagne.getMock("Inventory")
itemschema = mockagne.getMock("ItemSchema")
materials = mockagne.getMock("Materials")
party = mockagne.getMock("Party")
playerlist = mockagne.getMock("PlayerList")
steam = mockagne.getMock("Steam")

---@class MockAPI
---@field callbacks table<string, table<string, fun(...)>>
local MockAPI = {
    callbacks = {}
}

function MockAPI:InvokeCallback(id, ...)
    if self.callbacks[id] == nil then
        return
    end

    for _, callback in pairs(self.callbacks[id]) do
        callback(...)
    end
end

function callbacks.Register(id, name, callback)
    if MockAPI.callbacks[id] == nil then
        MockAPI.callbacks[id] = {}
    end

    MockAPI.callbacks[id][name] = callback
    Log("Registered callback " .. name .. " for " .. id)
end

function callbacks.Unregister(id, name)
    if MockAPI.callbacks[id] == nil then
        return
    end

    MockAPI.callbacks[id][name] = nil
    Log("Unregistered callback " .. name .. " for " .. id)
end

return MockAPI
