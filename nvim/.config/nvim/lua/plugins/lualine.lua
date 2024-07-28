return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            local harpoon = require("harpoon.mark")

            local function truncate_branch_name(branch)
                if not branch or branch == "" then
                    return ""
                end

                -- Match the branch name to the specified format
                local user, ticket_number, description = string.match(branch, "^(%w+)/(%w+)%-(%d+)")

                -- If the branch name matches the format, display {user}/{ticket_number}/{description}, otherwise display the full branch name
                if ticket_number then
                    return user .. "/" .. ticket_number .. "/" .. description
                else
                    return branch
                end
            end

            local function harpoon_component()
                local total_marks = harpoon.get_length()

                if total_marks == 0 then
                    return ""
                end

                local current_mark = "—"

                local mark_idx = harpoon.get_current_index()
                if mark_idx ~= nil then
                    current_mark = tostring(mark_idx)
                end

                return string.format("󱡅 %s/%d", current_mark, total_marks)
            end

            local function show_macro_recording()
                local recording_register = vim.fn.reg_recording()
                if recording_register == "" then
                    return ""
                else
                    return "Recording @" .. recording_register
                end
            end

            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                    globalstatus = true,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "█", right = "█" },
                },
                sections = {
                    lualine_b = {
                        { "branch", icon = "", fmt = truncate_branch_name },
                        "diff",
                        "diagnostics",
                        harpoon_component,
                        { "macro-recording", fmt = show_macro_recording },
                    },
                    lualine_c = {
                        { "filename", path = 1 },
                    },
                    lualine_x = {
                        "filetype",
                    },
                },
            })
        end,
    },
}
