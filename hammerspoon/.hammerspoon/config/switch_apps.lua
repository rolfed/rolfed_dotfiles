-- ~/.hammerspoon/init.lua

-- Create a new modal for app switching
lpocal appSwitchModal = hs.hotkey.modal.new("alt", "a")
local appList = hs.application.runningApplications()  -- Cache of running applications
local currentIndex = 1  -- Track the current app index

-- Filter to only include user-facing applications
local function userFacingApps()
    local apps = {}
    for _, app in ipairs(hs.application.runningApplications()) do
        if app:kind() == 1 and not app:isHidden() then  -- Kind 1 means user-facing
            table.insert(apps, app)
        end
    end
    return apps
end

-- Update appList with user-facing applications
appList = userFacingApps()

-- Function to switch to the application at the current index
local function switchToApp(index)
    if appList[index] then
        appList[index]:activate()
    end
end

-- Define navigation within the modal
appSwitchModal:bind("", "v", function()
    currentIndex = (currentIndex % #appList) + 1  -- Move to the next app
    switchToApp(currentIndex)
end)

appSwitchModal:bind("", "h", function()
    currentIndex = ((currentIndex - 2) % #appList) + 1  -- Move to the previous app
    switchToApp(currentIndex)
end)

appSwitchModal:bind("", "j", function()
    currentIndex = (currentIndex % #appList) + 1  -- Move to the next app
    switchToApp(currentIndex)
end)

appSwitchModal:bind("", "k", function()
    currentIndex = ((currentIndex - 2) % #appList) + 1  -- Move to the previous app
    switchToApp(currentIndex)
end)

appSwitchModal:bind("", "l", function()
    currentIndex = (currentIndex % #appList) + 1  -- Move to the next app
    switchToApp(currentIndex)
end)

-- Show an indicator when entering the modal
appSwitchModal.entered = function()
    hs.alert.show("App Switch Mode: v (next), h/j/k/l to navigate")
    appList = userFacingApps()  -- Refresh app list when entering
    currentIndex = 1  -- Start from the first app
    switchToApp(currentIndex)
end

-- Hide the indicator when exiting the modal
appSwitchModal.exited = function()
    hs.alert.closeAll()
end

-- Exit the modal when any key is pressed outside the bindings
appSwitchModal:bind("", "escape", function() appSwitchModal:exit() end)

