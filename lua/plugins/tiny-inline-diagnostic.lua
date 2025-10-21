return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup({

                -- Style preset for diagnostic messages
                -- Available options: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
                preset = "modern",

                -- Set the background of the diagnostic to transparent
                transparent_bg = false,

                -- Set the background of the cursorline to transparent (only for the first diagnostic)
                transparent_cursorline = true,

                options = {
                    -- Events to attach diagnostics to buffers
                    overwrite_events = { "LspAttach", "BufEnter" },

                    -- Add messages to diagnostics when multiline diagnostics are enabled
                    -- If set to false, only signs will be displayed
                    add_messages = false,

                    -- Time (in milliseconds) to throttle updates while moving the cursor
                    -- Increase this value for better performance on slow computers
                    -- Set to 0 for immediate updates and better visual feedback
                    throttle = 0,

                    -- Minimum message length before wrapping to a new line
                    softwrap = 30,

                    -- Configuration for multiline diagnostics
                    -- Can be a boolean or a table with detailed options
                    multilines = {
                        -- Enable multiline diagnostic messages
                        enabled = true,

                        -- Always show messages on all lines for multiline diagnostics
                        always_show = true,

                        -- Trim whitespaces from the start/end of each line
                        trim_whitespaces = false,

                        -- Replace tabs with this many spaces in multiline diagnostics
                        tabstop = 4,
                    },

                    -- Manage how diagnostic messages handle overflow
                    overflow = {
                        -- Overflow handling mode:
                        -- "wrap" - Split long messages into multiple lines
                        -- "none" - Do not truncate messages
                        -- "oneline" - Keep the message on a single line, even if it's long
                        mode = "wrap",

                        -- Trigger wrapping this many characters earlier when mode == "wrap"
                        -- Increase if the last few characters of wrapped diagnostics are obscured
                        padding = 0,
                    },

                    -- Virtual text display configuration
                    virt_texts = {
                        -- Priority for virtual text display (higher values appear on top)
                        -- Increase if other plugins (like GitBlame) override diagnostics
                        priority = 2048,
                    },
                },

                -- List of filetypes to disable the plugin for
                disabled_ft = {},
            })
        end,
    },
}
