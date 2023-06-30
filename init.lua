vim.loader.enable()

require("kit.core")

_G.setup = function(name, opts)
  return require(name).setup(opts)
end

-- disable any backup
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

vim.o.autoread = true

vim.o.shell = "/bin/zsh -l"

vim.o.shada = "!,'10000,<50,s10,h"

-- enable undo after closing vim
vim.o.undofile = true

vim.o.termguicolors = true

-- enable line to control text width
vim.o.colorcolumn = "79,119"

-- vim.o.textwidth = 79

-- show tabs
vim.o.list = true
vim.opt.listchars = {
  tab = ">-",
}

vim.o.lazyredraw = false
-- vim.o.ttimeoutlen = 10

vim.o.wrap = true
vim.o.breakindent = true
vim.o.lbr = true
vim.o.history = 10000
vim.o.updatetime = 100
vim.o.mouse = "nv"
vim.o.completeopt = "menuone,preview,noinsert"

vim.o.pumheight = 5
vim.o.hidden = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.clipboard = "unnamedplus"

-- enable cursor line highlight
vim.o.cursorline = true

vim.o.cinoptions = vim.o.cinoptions .. "L0"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "git@github.com:folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

_G.map = setmetatable({}, {
  __index = function(_, key)
    return require("keymap").map[key]
  end,
})

require("lazy").setup("plugins", {
  ui = {
    size = { width = 1, height = 1 },
  },
  colorscheme = { "nano-theme" },
  change_detection = {
    notify = false,
  },
})

map:set("<leader>l", vim.cmd.Lazy)

vim.o.spell = true
vim.o.spelllang = "en,ru"
vim.o.spellcapcheck = ""
vim.o.spelloptions = "camel"
vim.o.spellsuggest = "best,7"
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.smarttab = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.scrolloff = 10
vim.o.sidescrolloff = 20
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true

kit.autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 150,
    })
  end,
})

local ts_utils = require("nvim-treesitter.ts_utils")

local function set_current_line(new_line)
  vim.fn.setline(".", new_line)
  local pos = vim.fn.getpos(".")
  -- the third value is the columns
  pos[3] = vim.fn.col("$")
  vim.fn.setpos(".", pos)
end

local function insert_item()
  if vim.bo.filetype ~= "tex" then
    return
  end

  local node = ts_utils.get_node_at_cursor()

  while node do
    local first_line = vim.split(vim.treesitter.get_node_text(node, 0), "\n")[1]
    if node:type() == "generic_environment" then
      local cur_line = vim.fn.getline(".")
      if #cur_line:gsub("^%s*", "", 1) ~= 0 then
        vim.fn.append(vim.fn.line("."), string.rep(" ", vim.fn.indent(".")))
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
        cur_line = vim.fn.getline(vim.fn.line("."))
      end
      if first_line:match("table") then
        set_current_line(cur_line .. "\\hline")
      elseif first_line:match("itemize") or first_line:match("enumerate") then
        set_current_line(cur_line .. "\\item ")
      end
      break
    end
    node = node:parent()
  end
end

map:mode("i"):set("<M-CR>", insert_item)

kit.create_cmd("Open", function(opts)
  kit.open_file(string.format('"%s"', vim.fn.expand(opts.args)))
end, {
  nargs = "?",
  complete = "file",
})

kit.autocmd("BufWinEnter", {
  pattern = { "*.pdf", "*.png", "*.jpg", "*.heic" },
  callback = function()
    kit.open_file("%")
    MiniBufremove.delete()
  end,
})

kit.open_file = function(path)
  vim.fn.system("open " .. vim.fn.expand(path))
end

vim.o.diffopt = "internal,filler,closeoff,linematch:60,horizontal,foldcolumn:0"

vim.opt.fillchars:append("diff: ")

map:mode({ "i", "n", "t" }):set("<A-j>", vim.cmd.bnext):set("<A-k>", vim.cmd.bprev)

kit.autocmd("BufWinEnter", {
  desc = "return cursor to where it was last time closing the file",
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

kit.autocmd("TermOpen", {
  callback = function()
    vim.wo.spell = false
  end,
})

-- require("langmapper").automapping({ global = true, buffer = true })

local ns_id = vim.api.nvim_create_namespace("orgmode.ui.indent")

local indent_per_level = { 0 }
-- for i = 1, 10 do
--   table.insert(indent_per_level, i * (i + 1) / 2 - 1)
-- end

for i = 1, 10 do
  -- table.insert(indent_per_level, (i - 1) * 2)
  -- table.insert(indent_per_level, (i - 1) * 3)
  table.insert(indent_per_level, i + 1)
end

function _G.toggle_indent(start_line, end_line)
  end_line = math.min(end_line, vim.fn.line("$") - 1)

  local old_extmarks = vim.api.nvim_buf_get_extmarks(
    0,
    ns_id,
    { start_line, 0 },
    { end_line, 0 },
    { type = "virt_text" }
  )
  for _, ext in ipairs(old_extmarks) do
    vim.api.nvim_buf_del_extmark(0, ns_id, ext[1])
  end

  for i = start_line, end_line do
    local headline = require("orgmode.treesitter.headline").from_cursor({ i + 1, 1 })
    if headline and headline.headline then
      local ok, level = pcall(headline.level, headline)
      if ok then
        local row, _, _ = headline.headline:start()

        local indent
        if row == i then
          indent = level - 1
        else
          indent = level * 2
        end

        if indent and indent > 0 then
          vim.api.nvim_buf_set_extmark(0, ns_id, i, 0, {
            virt_text = { { string.rep(" ", indent) } },
            virt_text_pos = "inline",
            right_gravity = false,
            virt_text_hide = true,
            priority = 1,
          })
        end
      end
    end
  end
end

function _G.make_comment(str)
  return vim.bo.commentstring:gsub("%%s", str)
end
