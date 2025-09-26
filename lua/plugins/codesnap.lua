return {
    {
        "mistricky/codesnap.nvim",
        build = "make",
        opts = {
            save_path = "~/Downloads/codesnap.png",
            mac_window_bar = true,
            title = "CodeSnap.nvim",
            code_font_family = "CaskaydiaCove Nerd Font",
            watermark_font_family = "Pacifico",
            -- watermark = "CodeSnap.nvim",
            watermark = "",
            bg_theme = "default",
            has_breadcrumbs = true,
            breadcrumbs_separator = "/",
            bg_x_padding = 30,
            bg_y_padding = 20,
            bg_padding = 0, -- Remove padding and make transparent
        },
    },
}
