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

map("", "в", "d", opts)
map("", "н", "y", opts)
map("", "з", "p", opts)
map("", "Ж", ":", opts)
map("", "ш", "i", opts)
map("", "ф", "a", opts)
map("", "Ш", "I", opts)
map("", "Ф", "A", opts)
map("", "е", "t", opts)
map("", "а", "f", opts)
map("", "Е", "T", opts)
map("", "Ф", "F", opts)
map("", "с", "c", opts)
map("", "к", "r", opts)
map("", "ы", "s", opts)
map("", "Ы", "S", opts)
map("", "щ", "o", opts)
map("", "Щ", "O", opts)
map("", "п", "g", opts)
map("", "г", "u", opts)

map("n", "go", "o<Esc>", opts)
map("n", "gO", "O<Esc>", opts)

-- fast scrolling
map("n", "J", "9j", opts)
map("n", "K", "9k", opts)
map("v", "J", "9j", opts)
map("v", "K", "9k", opts)

map("n", "<S-Down>", "9<Down>", opts)
map("n", "<S-Up>", "9<Up>", opts)
map("v", "<S-Down>", "9<Down>", opts)
map("v", "<S-Up>", "9<Up>", opts)

map("", "<Down>", "g<Down>", opts)
map("", "<Up>", "g<Up>", opts)
map("", "j", "gj", opts)
map("", "k", "gk", opts)
map("", "о", "gj", opts)
map("", "л", "gk", opts)

-- mapping that opens .vimrc in a new tab for quick editing
map("n", "<Leader>ev", "<Cmd>tabe $MYVIMRC<CR>", opts)
-- mapping that sources the vimrc in the current filea doesn't work, should change all require calls to dofile
-- or clear all require cache and reimport
-- map('n', '<Leader>sv', '<Cmd>lua dofile(vim.fn.stdpath(\'config\')..\'/init.lua\')<CR>', { noremap = true, silent = false })

-- indent via Tab
-- map("n", "<Tab>", ">>_", opts)
-- map("n", "<S-Tab>", "<<_", opts)
-- map("v", "<Tab>", ">>_", opts)
-- map("v", "<S-Tab>", "<<_", opts)
-- map("i", "<Tab>", "\t", opts)
-- map("i", "<S-Tab>", "\b", opts)

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

map("n", "<Leader>od", "<Cmd>silent !open .<CR>", opts)

map("n", "<Leader>do", "<Cmd>DiffviewOpen<CR>", opts)

map("n", "<A-s>", "<Cmd>Neoformat | w<CR>", opts)

map("n", "<A-Up>", ":MoveLine(-1)<CR>", opts)
map("n", "<A-Down>", ":MoveLine(1)<CR>", opts)
map("v", "<A-Up>", ":MoveBlock(-1)<CR>", opts)
map("v", "<A-Down>", ":MoveBlock(1)<CR>", opts)

map("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
map("n", "<A-j>", ":MoveLine(1)<CR>", opts)
map("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
map("v", "<A-j>", ":MoveBlock(1)<CR>", opts)

map("", "gt", ":tabnext<CR>", opts)
map("", "gT", ":tabprevious<CR>", opts)
map("", "gq", ":tabclose<CR>", opts)

map("", "<Leader>go", "<Cmd>Gitui<CR>", opts)
map("", "<Leader>cs", "<Cmd>noh<CR>", opts)

map("", "<Space>", "<Leader>", { silent = true })

map("", "<Leader>m", "<Cmd>make<CR>", opts)
