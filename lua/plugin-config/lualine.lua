require('lualine').setup {
    options = {theme = 'dracula'},
    sections = {
        lualine_x = {"%F"},
        lualine_y = {"os.date('%a %d.%m.%Y %H:%M')"}
    }
}
