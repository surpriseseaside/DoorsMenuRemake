return function(Window)
    local LatestChangelog = {
        "22/6/2026",
        "<font color='rgb(0, 255, 0)'>+ Added EXPERIMENTAL New Object Hanlder, Should Reduce Lag when Opening Doors</font>",
		"<font color='rgb(0, 255, 0)'>+ Fixed Auto Heartbeat Minigame</font>",
		"<font color='rgb(0, 255, 0)'>+ Fixed Door Reach Voiding You at Seek</font>",
		"<font color='rgb(0, 255, 0)'>+ Other Bug Fixes</font>",
    }

    local function CloneReference(Object)
        if DoorsMenuRemake and DoorsMenuRemake.Environment.cloneref then
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

    local Library = DoorsMenuRemake.Interface.Library
    local SaveManager = DoorsMenuRemake.Interface.SaveManager
    local ThemeManager = DoorsMenuRemake.Interface.ThemeManager

    local Toggles = Library.Toggles
    local Options = Library.Options

    local LocalPlayer = Services.Players.LocalPlayer
    local InfoTab = Window:AddTab("Info", "user")

    local User = InfoTab:AddLeftGroupbox("User Info")

    local ImageSize = Enum.ThumbnailSize.Size420x420
    local ImageType = Enum.ThumbnailType.HeadShot

    local Content = Services.Players:GetUserThumbnailAsync(LocalPlayer.UserId, ImageType, ImageSize)

    User:AddImage("UserIcon", {
        Image = Content
    })

    User:AddLabel("ID: " .. LocalPlayer.Name, true)
    User:AddLabel("Total Executions: " .. (DoorsMenuRemake.TotalExecutions and DoorsMenuRemake.TotalExecutions or "N/A"), true)

    local Changelog = InfoTab:AddRightGroupbox("Changelog")
    for Index, Change in pairs(LatestChangelog) do
        Changelog:AddLabel(Change, true)
    end

    local Name, Version = DoorsMenuRemake.Environment.identifyexecutor()
    local Executor = InfoTab:AddRightGroupbox("Executor Info")
    Executor:AddLabel("Name: " .. Name, true)
	Executor:AddLabel("Version: " .. (Version and Version or "N/A"), true)
    Executor:AddDivider()
    Executor:AddLabel("Test Result: ", true)

    for Index, Result in pairs(DoorsMenuRemake.Environment.Results) do
		-- fix for veloshitty 💔
		Result = Result:gsub("<", "(")
		Result = Result:gsub(">", ")")
		
        Executor:AddLabel(Result, true)
    end

    local Community = InfoTab:AddLeftGroupbox("Community")
    Community:AddButton("Copy Discord Invite", function()
	    toclipboard("https://dsc.gg/DoorsMenuRemakehub")
	    Library:Notify("Discord invite copied.")
    end)
end