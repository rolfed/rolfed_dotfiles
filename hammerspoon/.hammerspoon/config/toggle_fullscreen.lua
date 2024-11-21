local M = {} -- Create a module table

-- Table to store the original window frame size
local orignalFrames = {}

-- Function to toggle full screen
function M.action()
    -- Set animation duration to zero
    hs.window.animationDuration = 0;
    -- Get the focused window
    local win = hs.window.filter.new():getWindows(hs.window.filter.sortByFocusedLast)[1]

    if win then
        local winId = win:id()

        if orignalFrames[winId] then
            -- if the window is already maximized, restore the orignal frame
            win:setFrame(orignalFrames[winId])
            orignalFrames[winId] = nil -- Clear the saved frame after restoring
        else
            -- Save the original frame
            orignalFrames[winId] = win:frame()

            -- Maximize the window
            local screen = win:screen()
            local max = screen:frame()
            win:setFrame(max)
        end
    else
        hs.alert.show("No active window detected")
    end
end

return M -- return the module table
