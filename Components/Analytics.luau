--[[

    For anyone wondering, this just sends a discord message when someone executed the script.
    We only log basic data such as roblox username, executor used and the game you are in.
    Sensetive data such as IP adresses or HWIDs are NOT logged and never will be.
    If you want proof of this, feel free to dm me on discord: peterj233.

]]--

local function CloneReference(Object)
    if DoorsMenuRemake.Environment.cloneref then
        return DoorsMenuRemake.Environment.cloneref(Object)
    else
        return Object
    end
end

local Services = setmetatable({}, {
    __index = function(self, Name)
        return CloneReference(game:GetService(Name))
    end
})

if DoorsMenuRemake.Environment.identifyexecutor and DoorsMenuRemake.Environment.request then
    local Player = Services.Players.LocalPlayer
    local Data = {
        Account = Player.Name,
        Executor = DoorsMenuRemake.Environment.identifyexecutor(),
        Executions = tonumber(DoorsMenuRemake.TotalExecutions),
        GameName = Services.MarketplaceService:GetProductInfo(game.PlaceId).Name,
        PlaceId = tostring(game.PlaceId)
    }

    task.spawn(function()
        pcall(function()
            DoorsMenuRemake.Environment.request({
                Url = "http://alpha-site.xyz:10578/send",
                Method = "POST",
                Headers = {
                    ["content-type"] = "application/json"
                },
                Body = Services.HttpService:JSONEncode(Data)
            })
        end)
    end)
end
