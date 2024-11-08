local toggleFullScreen = require("config/toggle_fullscreen");
local halfscreen = require("config/set_halfscreen");

local winModal = hs.hotkey.modal.new("alt", "w")

-- Bind the toggle full screen function to a hotkey
hs.hotkey.bind({ "alt", "ctr" }, "z", toggleFullScreen.action)

-- Half screen right 
winModal:bind("", "l", function()
    halfscreen.action("right")
    hs.timer.doAfter(0.1, function() winModal:exit() end)
end)

winModal:bind("", "h", function()
    halfscreen.action("left")
    hs.timer.doAfter(0.1, function() winModal:exit() end)
end)

-- Show a temp notification to indicate the modal is active
winModal.entered = function()
    hs.alert.show("Position Window: h = left, l = right")
end

winModal.exited = function()
    hs.alert.closeAll()
end
