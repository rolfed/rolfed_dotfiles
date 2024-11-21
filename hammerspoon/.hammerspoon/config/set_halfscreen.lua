local M = {} -- Create a module table

function M.action(position)
    local win = hs.window.filter.new():getWindows(hs.window.filter.sortByFocusedLast)[1]

    if win then
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        -- Set the window to either the left or right half of the screen
        if position == "left" then
            f.x = max.x
            f.y = max.y
            f.w = max.w / 2
            f.h = max.h
        elseif position == "right" then
            f.x = max.x + (max.w / 2)
            f.y = max.y
            f.w = max.w / 2
            f.h = max.h
        end

        win:setFrame(f)
    else
        hs.alert.show("No active window detected")
    end
end

return M

