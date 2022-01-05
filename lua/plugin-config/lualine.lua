local function read_battery_value()
    local handle = io.popen("pmset -g batt")
    local raw_battery_value = handle:read("*a")
    handle:close()

    local battery_value = string.match(raw_battery_value, "%d+%%")
    return "Batt: " .. battery_value .. "%"
end

local function read_datetime() return os.date('%a %d.%m %H:%M') end

local function get_tabsize()
    local tabsize = tostring(vim.o.shiftwidth)
    return "Tab: " .. tabsize
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'dracula',
        component_separators = {left = '|', right = '|'},
        always_divide_middle = false,
        section_separators = {left = '', right = ''}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            'branch', 'diff', {'diagnostics', sources = {'nvim_diagnostic'}}
        },
        lualine_x = {'encoding', get_tabsize},
        lualine_y = {read_battery_value, read_datetime},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {'filename'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

local timer = vim.loop.new_timer()
local function redraw_tabline() vim.api.nvim_command(":redrawtabline") end

timer:start(0, 1000, vim.schedule_wrap(redraw_tabline))
