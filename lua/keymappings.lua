-- defaults
local opts = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap
-- TODO: disabled since trying out "clipboard = unnamedplus" option
-- copy
-- map('', '<C-c>', '"+y', opts)
-- paste
-- map('', '<C-v>', '"+p', opts)
-- cut
-- map('', '<C-x>', '"+d', opts)
-- paste in insert mode
-- map('i', '<C-v>', '<Esc>"+pa', opts)

-- fast scrolling
map("n", "K", "9j", opts)
map("n", "L", "9k", opts)
map("v", "K", "9j", opts)
map("v", "L", "9k", opts)

-- mapping that opens .vimrc in a new tab for quick editing
map("n", "<Leader>ev", "<Cmd>tabe $MYVIMRC<CR>", opts)
-- mapping that sources the vimrc in the current filea doesn't work, should change all require calls to dofile
-- or clear all require cache and reimport
-- map('n', '<Leader>sv', '<Cmd>lua dofile(vim.fn.stdpath(\'config\')..\'/init.lua\')<CR>', { noremap = true, silent = false })

-- indent via Tab
map("n", "<Tab>", ">>_", opts)
map("n", "<S-Tab>", "<<_", opts)
map("v", "<Tab>", ">>_", opts)
map("v", "<S-Tab>", "<<_", opts)
map("i", "<Tab>", "\t", opts)
map("i", "<S-Tab>", "\b", opts)

-- window movement
map("", "<C-w>j", "<C-w>h", opts)
map("", "<C-w>k", "<C-w>j", opts)
map("", "<C-w>l", "<C-w>k", opts)
map("", "<C-w>č", "<C-w>l", opts)

-- opening terminal with shortcut
map("", "<Leader>t", "<Cmd>silent !$TERM &<CR>", opts)

-- cd to file directory
map("", "<Leader>cd", "<Cmd>cd %:p:h<CR>", opts)
map("", "<Leader>cp", "<Cmd>silent !pwd | pbcopy<CR>", opts)

-- jumping back and forth
map("", "<C-K>", "<C-O>", opts)
map("", "<C-L>", "<C-I>", opts)

-- formatting
map("n", "<F3>", "<Cmd>Format<CR>", opts)

-- tree
map("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>", opts)
map("n", "<Leader>r", "<Cmd>NvimTreeRefresh<CR>", opts)

-- saving
map("n", "<D-s>", "<Cmd>w<CR>", opts)

map("n", "<C-A-Right>", "<Cmd>vertical resize -1<CR>", opts)
map("n", "<C-A-Left>", "<Cmd>vertical resize +1<CR>", opts)
map("n", "<C-A-Up>", "<Cmd>resize +1<CR>", opts)
map("n", "<C-A-Down>", "<Cmd>resize -1<CR>", opts)

map("n", "<C-k>r", "<Cmd>silent !open .<CR>", opts)

map("n", "<Leader>do", "<Cmd>DiffviewOpen<CR>", opts)

map("n", "<A-s>", "<Cmd>Neoformat | w<CR>", opts)

map("n", "<A-Up>", ":MoveLine(-1)<CR>", opts)
map("n", "<A-Down>", ":MoveLine(1)<CR>", opts)
map("v", "<A-Up>", ":MoveBlock(-1)<CR>", opts)
map("v", "<A-Down>", ":MoveBlock(1)<CR>", opts)

map("", "gt", ":tabnext<CR>", opts)
map("", "gT", ":tabprevious<CR>", opts)
map("", "gq", ":tabclose<CR>", opts)

map("", "<Leader>go", "<Cmd>Gitui<CR>", opts)
