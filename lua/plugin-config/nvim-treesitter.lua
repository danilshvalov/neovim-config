require("nvim-treesitter.configs").setup({
    -- will install treesitter for all available languages
    ensure_installed = "all",
    ignore_install = { "haskell" }, -- broken
    highlight = {
        enable = true,
        disable = { "html" },
        -- additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = false,
    },
    -- indent = {
    --     enable = true,
    -- },
    rainbow = {
        colors = {
            "#00a960",
            "#e6b422",
            "#7aa2f7",
            "#8080ff",
            "#0073a8",
            "#33ccff",
            "#8080ff",
        },
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    autopairs = { enable = true },
})
