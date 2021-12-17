require("basics")
require("globals")
require("keymappings")
if not vim.g.vscode then
    require("plugins")
end
