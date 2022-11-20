-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/danilshvalov/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/danilshvalov/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/danilshvalov/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/danilshvalov/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/danilshvalov/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\nå\1\0\0\3\0\t\0\0186\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\0026\1\3\0009\1\4\0019\1\5\1\a\1\6\0X\1\4Ä+\1\1\0=\1\a\0'\1\b\0L\1\2\0+\1\2\0=\1\a\0K\0\1\0\t+%s+\fpadding\tnorg\rfiletype\abo\bvim\bget\19Comment.config\frequireH\1\0\5\0\5\0\a6\0\0\0'\2\1\0005\3\2\0003\4\3\0=\4\4\3B\0\3\1K\0\1\0\rpre_hook\0\1\0\1\vignore\a^$\fComment\nsetup\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\nb\0\0\6\1\a\0\f-\0\0\0005\2\5\0006\3\0\0009\3\1\0039\3\2\3'\5\3\0B\3\2\2'\4\4\0&\3\4\3=\3\6\2B\0\2\1K\0\1\0\1¿\npaths\1\0\0\14/snippets\vconfig\fstdpath\afn\bvim+\0\0\2\2\1\0\6-\0\0\0009\0\0\0B\0\1\1-\0\1\0B\0\1\1K\0\1\0\0¿\2¿\fcleanup¢\1\2\0\6\0\b\1\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0G\2\0\0A\0\0\2\21\1\0\0\b\1\0\0X\1\1ÄL\0\2\0006\1\3\0009\1\4\0016\3\3\0009\3\5\0039\3\6\3'\4\a\0+\5\2\0D\1\4\0\6.\rfiletype\abo\nsplit\bvim\20from_cursor_pos&luasnip.extras.filetype_functions\frequire\0¯\2\1\0\a\0\r\0\0226\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0013\2\4\0006\3\5\0'\5\6\0003\6\a\0B\3\3\0019\3\b\0009\3\t\0035\5\n\0003\6\v\0=\6\f\5B\3\2\1\18\3\2\0B\3\1\0012\0\0ÄK\0\1\0\fft_func\0\1\0\4\25store_selection_keys\n<Tab>\24delete_check_events\28TextChanged,InsertLeave\24region_check_events'CursorMoved,CursorHold,InsertEnter\18update_events)InsertLeave,TextChanged,TextChangedI\nsetup\vconfig\0\19ReloadSnippets\15create_cmd\0\tload\"luasnip.loaders.from_snipmate\fluasnip\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["git-conflict.nvim"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17git-conflict\nsetup\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/git-conflict.nvim",
    url = "https://github.com/akinsho/git-conflict.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nÏ\1\0\0\b\4\b\0!6\0\0\0009\0\1\0009\0\2\0B\0\1\0026\1\0\0009\1\1\0019\1\3\1)\3\0\0B\1\2\2:\1\1\1-\2\0\0009\2\4\2\18\4\1\0-\5\1\0008\5\0\0059\5\5\5B\2\3\2\14\0\2\0X\3\1ÄK\0\1\0-\3\2\0009\3\6\3\18\5\0\0-\6\3\0\18\a\2\0B\3\4\1-\3\2\0009\3\a\3\18\5\0\0-\6\3\0\18\a\2\0B\3\4\1K\0\1\0\3¿\2¿\4¿\5¿\17show_deleted\15show_added\nhunks\14find_hunk\24nvim_win_get_cursor\25nvim_get_current_buf\bapi\bvimN\0\0\6\1\3\0\t6\0\0\0009\0\1\0009\0\2\0)\2\0\0-\3\0\0)\4\0\0)\5ˇˇB\0\5\1K\0\1\0\5¿\29nvim_buf_clear_namespace\bapi\bvimÀ\t\1\0\f\0002\0S6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\16\0005\4\4\0005\5\3\0=\5\5\0045\5\6\0=\5\a\0045\5\b\0=\5\t\0045\5\n\0=\5\v\0045\5\f\0=\5\r\0045\5\14\0=\5\15\4=\4\17\3B\1\2\0016\1\0\0'\3\18\0B\1\2\0026\2\0\0'\4\19\0B\2\2\0029\2\20\0026\3\0\0'\5\21\0B\3\2\0026\4\0\0'\6\22\0B\4\2\0026\5\23\0009\5\24\0059\5\25\5'\a\26\0B\5\2\0023\6\28\0=\6\27\0016\6\29\0\18\b\6\0009\6\30\0065\t\31\0B\6\3\2\18\b\6\0009\6 \6'\t!\0009\n\"\0005\v#\0B\6\5\2\18\b\6\0009\6 \6'\t$\0009\n%\0005\v&\0B\6\5\2\18\b\6\0009\6 \6'\t'\0009\n(\0005\v)\0B\6\5\2\18\b\6\0009\6 \6'\t*\0009\n+\0005\v,\0B\6\5\2\18\b\6\0009\6 \6'\t-\0009\n\27\0005\v.\0B\6\5\2\18\b\6\0009\6 \6'\t/\0003\n0\0005\v1\0B\6\5\0012\0\0ÄK\0\1\0\1\0\1\tdesc\23Clear hunk preview\0\6c\1\0\1\tdesc\17Preview hunk\6h\1\0\1\tdesc\15Stage hunk\15stage_hunk\6s\1\0\1\tdesc\15Reset hunk\15reset_hunk\6r\1\0\1\tdesc\14Next hunk\14next_hunk\6n\1\0\1\tdesc\18Previous hunk\14prev_hunk\6p\bset\1\0\1\vprefix\14<leader>g\bnew\bmap\0\24preview_hunk_inline\28gitsigns_preview_inline\26nvim_create_namespace\bapi\bvim\21gitsigns.manager\19gitsigns.hunks\ncache\19gitsigns.cache\21gitsigns.actions\nsigns\1\0\0\14untracked\1\0\4\ahl\16GitSignsAdd\ttext\b‚îÇ\nnumhl\18GitSignsAddNr\vlinehl\18GitSignsAddLn\17changedelete\1\0\4\ahl\19GitSignsChange\ttext\b‚îÇ\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\14topdelete\1\0\4\ahl\19GitSignsDelete\ttext\b‚îÇ\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\vdelete\1\0\4\ahl\19GitSignsDelete\ttext\b‚îÇ\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\vchange\1\0\4\ahl\19GitSignsChange\ttext\b‚îÇ\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\badd\1\0\0\1\0\4\ahl\16GitSignsAdd\ttext\b‚îÇ\nnumhl\18GitSignsAddNr\vlinehl\18GitSignsAddLn\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["keymap.nvim"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/keymap.nvim",
    url = "https://github.com/danilshvalov/keymap.nvim"
  },
  ["lsp-format.nvim"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/lsp-format.nvim",
    url = "https://github.com/lukas-reineke/lsp-format.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 A\0\0\1\0\5\1\t6\0\0\0009\0\1\0009\0\2\0\t\0\0\0X\0\2Ä'\0\3\0X\1\1Ä'\0\4\0L\0\2\0\aen\aru\riminsert\6o\bvim\2\18\0\0\1\0\1\0\2'\0\0\0L\0\2\0\a%=)\0\0\1\0\3\0\0046\0\0\0009\0\1\0009\0\2\0L\0\2\0\15shiftwidth\abo\bvim\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 -\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\16showtabline\6o\bvim-\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\16showtabline\6o\bvim¢\6\1\0\a\0-\0F6\0\0\0'\2\1\0B\0\2\0025\1\6\0004\2\3\0005\3\4\0003\4\2\0>\4\1\0035\4\3\0=\4\5\3>\3\1\2=\2\a\0015\2\b\0=\2\t\0015\2\r\0005\3\v\0003\4\n\0>\4\1\3>\3\1\0025\3\f\0>\3\2\0023\3\14\0>\3\4\0025\3\15\0>\3\5\2=\2\16\0014\2\3\0005\3\18\0003\4\17\0>\4\1\3>\3\1\0025\3\19\0>\3\2\2=\2\20\0015\2\21\0=\2\22\0014\2\3\0005\3\25\0003\4\23\0>\4\1\0035\4\24\0=\4\5\3>\3\1\2=\2\26\0016\2\27\0009\2\28\2+\3\1\0=\3\29\0029\2\30\0005\4 \0005\5\31\0=\5!\4=\1\"\0045\5$\0005\6#\0=\6\a\5=\5%\4B\2\2\0016\2\27\0009\2&\0023\4'\0)\5\0\0B\2\3\0016\2(\0005\4)\0005\5+\0003\6*\0=\6,\5B\2\3\1K\0\1\0\rcallback\1\0\0\0\1\t\0\0\rWinEnter\rBufEnter\20SessionLoadPost\25FileChangedShellPost\15VimResized\rFiletype\16CursorMoved\17CursorMovedI\fautocmd\0\rdefer_fn\ftabline\1\0\0\1\2\0\0\ttabs\rsections\foptions\1\0\0\1\0\4\17globalstatus\2\23section_separators\5\ntheme\tauto\25component_separators\5\nsetup\rshowmode\6o\bvim\14lualine_z\1\0\0\1\0\1\tleft\3\0\0\14lualine_y\1\2\0\0\rlocation\14lualine_x\1\2\0\0\rfiletype\1\0\1\ticon\bÔ¨¥\0\14lualine_c\1\2\2\0\rfilename\16file_status\2\tpath\3\0\0\1\4\0\0\0\0\16diagnostics\1\2\1\0\vbranch\ticon\bÓú•\1\0\1\ticon\bÔûã\0\14lualine_b\1\2\0\0\tmode\14lualine_a\1\0\0\fpadding\1\0\0\1\0\1\nright\3\0\0\flualine\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    config = { "\27LJ\2\nÆ\1\0\0\5\0\5\0\a6\0\0\0'\2\1\0005\3\3\0005\4\2\0=\4\4\3B\0\3\1K\0\1\0\21ensure_installed\1\0\1\27automatic_installation\1\1\t\0\0\vclangd\njdtls\18rust_analyzer\16sumneko_lua\vtexlab\fpyright\ncmake\rmarksman\20mason-lspconfig\nsetup\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n#\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\nmason\nsetup\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["mini.nvim"] = {
    config = { "\27LJ\2\në\1\0\0\5\0\t\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\0016\0\4\0'\2\5\0'\3\6\0006\4\a\0009\4\b\4B\0\4\1K\0\1\0\vdelete\18MiniBufremove\aZX\5\tmaps\19mini.bufremove\nsetup\15mini.align\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  ["mkdnflow.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rmkdnflow\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/opt/mkdnflow.nvim",
    url = "https://github.com/jakewvincent/mkdnflow.nvim"
  },
  ["neodev.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vneodev\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  neogen = {
    config = { "\27LJ\2\n¡\1\0\0\a\0\f\0\0226\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0016\1\3\0\18\3\1\0009\1\4\1B\1\2\2\18\3\1\0009\1\5\1'\4\6\0'\5\a\0B\1\4\2\18\3\1\0009\1\b\1'\4\t\0009\5\n\0005\6\v\0B\1\5\1K\0\1\0\1\0\1\tdesc\27Generate documentation\rgenerate\6g\bset\n+code\14<leader>c\vprefix\bnew\bmap\nsetup\vneogen\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  neorg = {
    config = { "\27LJ\2\n\15\0\0\1\0\0\0\2)\0\0\0L\0\2\0ª\6\1\0\t\0003\0>6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\4\0'\2\5\0005\0031\0005\4\6\0004\5\0\0=\5\a\0045\5\27\0005\6\21\0005\a\t\0005\b\b\0=\b\n\a5\b\v\0=\b\f\a5\b\r\0=\b\14\a5\b\15\0=\b\16\a5\b\17\0=\b\18\a5\b\19\0=\b\20\a=\a\22\0065\a\24\0003\b\23\0=\b\25\a=\a\26\6=\6\28\5=\5\29\0044\5\0\0=\5\30\0045\5\"\0005\6 \0005\a\31\0=\a!\6=\6\28\5=\5#\0045\5%\0005\6$\0=\6\28\5=\5&\0045\5(\0005\6'\0=\6\28\5=\5)\0045\5+\0005\6*\0=\6\28\5=\5,\0044\5\0\0=\5-\0045\5/\0005\6.\0=\6\28\5=\0050\4=\0042\3B\0\3\1K\0\1\0\tload\1\0\0\25core.export.markdown\1\0\0\1\0\1\15extensions\ball\16core.export\25core.norg.completion\1\0\0\1\0\1\vengine\rnvim-cmp\19core.presenter\1\0\0\1\0\1\rzen_mode\rzen-mode\18core.gtd.base\1\0\0\1\0\1\14workspace\rdefaults\21core.norg.dirman\1\0\0\15workspaces\1\0\2\nindex\15index.norg\14autochdir\2\1\0\1\rdefaults\r~/.notes\22core.norg.qol.toc\31core.norg.esupports.indent\vconfig\1\0\0\14modifiers\19under-headings\1\0\0\0\findents\1\0\0\rheading6\1\0\1\vindent\3\0\rheading5\1\0\1\vindent\3\0\rheading4\1\0\1\vindent\3\0\rheading3\1\0\1\vindent\3\0\rheading2\1\0\1\vindent\3\0\rheading1\1\0\0\1\0\1\vindent\3\0\18core.defaults\1\0\0\nneorg\nsetup'<Cmd>Neorg tangle current-file<CR>\15<leader>nt\6n\tmaps\0" },
    load_after = {},
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/opt/neorg",
    url = "https://github.com/nvim-neorg/neorg"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n∏\4\0\0\f\0\"\0>6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0016\3\0\0'\5\4\0B\3\2\0029\4\5\3B\4\1\0016\4\6\0\18\6\4\0009\4\a\4B\4\2\2\18\6\4\0009\4\b\4'\a\t\0006\b\n\0009\b\v\b9\b\f\bB\4\4\0019\4\5\0005\6\r\0009\a\14\3=\a\14\0064\a\f\0009\b\15\0019\b\16\b>\b\1\a9\b\17\2>\b\2\a9\b\18\2>\b\3\a9\b\19\0029\b\20\b5\n\22\0005\v\21\0=\v\23\nB\b\2\2>\b\4\a9\b\24\0029\b\20\b5\n\26\0005\v\25\0=\v\23\nB\b\2\2>\b\5\a9\b\27\2>\b\6\a9\b\28\2>\b\a\a9\b\29\2>\b\b\a9\b\30\2>\b\t\a9\b\31\2>\b\n\a9\b \2>\b\v\a=\a!\6B\4\2\1K\0\1\0\fsources\20trim_whitespace\vfnlfmt\ntaplo\16latexindent\nblack\17clang_format\1\0\0\1\4\0\0\tjson\15javascript\tyaml\14prettierd\14filetypes\1\0\0\1\2\0\0\tjava\twith\rprettier\17markdownlint\vstylua\rgitsigns\17code_actions\14on_attach\1\0\1\20default_timeout\3à'\17FormatToggle\bcmd\bvim\15<leader>tf\bset\bnew\bmap\nsetup\15lsp-format\15formatting\rbuiltins\fnull-ls\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-FeMaco.lua"] = {
    config = { "\27LJ\2\n~\0\0\5\0\6\0\0176\0\0\0009\0\1\0009\0\2\0B\0\1\0016\0\0\0009\0\3\0009\0\4\0+\2\1\0+\3\1\0B\0\3\0026\1\0\0009\1\3\0019\1\5\1)\3\0\0\18\4\0\0B\1\3\1L\0\2\0\21nvim_win_set_buf\20nvim_create_buf\bapi\nsplit\bcmd\bvim5\0\1\2\0\2\0\b\6\0\0\0X\1\4Ä\6\0\1\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\rmarkdown\tnorgê\2\1\0\b\0\18\0\0306\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0019\2\4\0005\4\6\0003\5\5\0=\5\a\0043\5\b\0=\5\t\4B\2\2\0016\2\n\0\18\4\2\0009\2\v\2B\2\2\2\18\4\2\0009\2\f\2'\5\r\0'\6\14\0B\2\4\2\18\4\2\0009\2\15\2'\5\16\0\18\6\1\0005\a\17\0B\2\5\1K\0\1\0\1\0\1\tdesc\20Edit code block\6e\bset\n+code\14<leader>c\vprefix\bnew\bmap\19ensure_newline\0\19prepare_buffer\1\0\0\0\nsetup\20edit_code_block\16femaco.edit\vfemaco\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/nvim-FeMaco.lua",
    url = "https://github.com/AckslD/nvim-FeMaco.lua"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nm\0\1\5\0\4\0\0189\1\0\0\18\3\1\0009\1\1\1'\4\2\0B\1\3\2\v\1\0\0X\1\tÄ9\1\0\0\18\3\1\0009\1\1\1'\4\3\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\rclass%s+\14struct%s+\nmatch\tlined\0\1\5\0\5\1\0169\1\0\0\18\3\1\0009\1\1\0019\4\2\0\23\4\0\4B\1\3\2\18\3\1\0009\1\3\1'\4\4\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\r[%w%d]+<\nmatch\bcol\bsub\ttext\2›\6\1\0\25\0.\0y6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\2'\2\3\0009\3\4\0005\5\5\0005\6\6\0006\a\a\0009\a\b\a'\t\t\0'\n\n\0'\v\v\0B\a\4\2=\a\f\6=\6\r\0056\6\a\0009\6\b\6\18\b\2\0'\t\n\0'\n\v\0B\6\4\2=\6\14\0054\6\0\0=\6\15\5B\3\2\0019\3\16\0\18\5\1\0'\a\17\0'\b\18\0B\5\3\0A\3\0\0019\3\16\0\18\5\1\0'\a\19\0'\b\20\0'\t\21\0B\5\4\0A\3\0\0019\3\16\0\18\5\1\0'\a\22\0'\b\23\0B\5\3\0A\3\0\0019\3\16\0\18\5\1\0'\a\24\0'\b\25\0B\5\3\0A\3\0\0019\3\16\0\18\5\1\0'\a\26\0'\b\27\0B\5\3\0A\3\0\0019\3\16\0\18\5\1\0'\a\28\0'\b\29\0'\t\30\0B\5\4\2\18\a\5\0009\5\31\0053\b \0B\5\3\0A\3\0\0019\3\16\0\18\5\1\0'\a!\0'\b\"\0'\t\30\0B\5\4\2\18\a\5\0009\5\31\0053\b#\0B\5\3\0A\3\0\0014\3\5\0005\4$\0>\4\1\0035\4%\0>\4\2\0035\4&\0>\4\3\0035\4'\0>\4\4\0035\4(\0006\5)\0\18\a\4\0B\5\2\4X\b\23Ä6\n*\0\18\f\3\0B\n\2\4H\r\17Ä9\15\16\0\18\17\1\0006\19\a\0009\19+\19'\21,\0\18\22\t\0:\23\1\14B\19\4\0026\20\a\0009\20+\20'\22,\0\18\23\t\0:\24\2\14B\20\4\2'\21-\0B\17\4\0A\15\0\1F\r\3\3R\rÌ\127E\b\3\3R\bÁ\127K\0\1\0\btex\n\\%s%s\vformat\npairs\vipairs\1\5\0\0\bbig\tbigg\bBig\tBigg\1\3\0\0\6|\6|\1\3\0\0\6(\6)\1\3\0\0\6{\6}\1\3\0\0\6[\6]\0\6>\6<\0\14with_pair\bcpp\a};\6{\a\\]\a\\[\a\\)\a\\(\a\\}\a\\{\trust\a\"#\br#\"\a*/\a/*\radd_rule\21disable_filetype\22ignored_next_char\14fast_wrap\fpattern\5\b%s+\26[%'%\"%)%>%]%)%}%%s%^]\tgsub\vstring\1\0\1\bmap\n<A-x>\1\0\1\30enable_check_bracket_line\1\nsetup$[%w%.–ê-–Ø%–∞-—è–Å—ë%(%[%{%'%\"]\24nvim-autopairs.rule\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "null-ls.nvim" },
    config = { "\27LJ\2\nú\1\0\1\3\2\4\0\21-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\vÄ-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4Ä-\1\1\0009\1\3\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\1¿\19expand_or_jump\23expand_or_jumpable\fconfirm\23get_selected_entryO\0\1\4\1\2\0\14-\1\0\0009\1\0\1)\3\1\0B\1\2\2\15\0\1\0X\2\5Ä-\1\0\0009\1\1\1)\3\1\0B\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\1¿\tjump\rjumpableO\0\1\4\1\2\0\14-\1\0\0009\1\0\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\0\0009\1\1\1)\3ˇˇB\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\1¿\tjump\rjumpableO\0\1\4\1\2\0\14-\1\0\0009\1\0\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\0\0009\1\1\1)\3ˇˇB\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\1¿\tjump\rjumpable)\0\1\4\1\2\0\4-\1\0\0009\1\0\0019\3\1\0D\1\2\0\1¿\tbody\15lsp_expand/\0\2\4\1\2\0\a9\2\1\1=\2\0\1-\2\0\0009\3\1\0018\2\3\2=\2\1\1L\1\2\0\2¿\tkind\tmenuô\t\1\0\15\0:\0o6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0025\2\3\0005\3\a\0009\4\4\0009\6\4\0009\6\5\6B\6\1\0025\a\6\0B\4\3\2=\4\b\0039\4\4\0009\6\4\0009\6\t\6B\6\1\0025\a\n\0B\4\3\2=\4\v\0039\4\4\0009\6\4\0009\6\f\6B\6\1\0025\a\r\0B\4\3\2=\4\14\0039\4\4\0005\6\16\0009\a\4\0009\a\15\aB\a\1\2=\a\17\0069\a\4\0009\a\18\aB\a\1\2=\a\19\6B\4\2\2=\4\20\0039\4\4\0009\4\21\0045\6\22\0B\4\2\2=\4\23\0039\4\4\0005\6\25\0003\a\24\0=\a\17\0063\a\26\0=\a\27\6B\4\2\2=\4\28\0039\4\4\0005\6\30\0003\a\29\0=\a\17\0063\a\31\0=\a\27\6B\4\2\2=\4 \0035\4!\0004\5\0\0006\6\"\0\18\b\4\0B\6\2\4X\t\4Ä5\v#\0=\n$\v=\t%\v<\v\t\5E\t\3\3R\t˙\1279\6&\0005\b*\0005\t(\0003\n'\0=\n)\t=\t+\b=\3\4\b=\5,\b5\t.\0005\n-\0=\n/\t3\n0\0=\n1\t=\t2\bB\6\2\0019\6&\0009\0063\6'\b4\0005\t6\0009\n\4\0009\n5\n9\n3\nB\n\1\2=\n\4\t9\n7\0009\n,\n4\f\3\0005\r8\0>\r\1\f4\r\3\0005\0149\0>\14\1\rB\n\3\2=\n,\tB\6\3\0012\0\0ÄK\0\1\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\vconfig\1\0\0\vpreset\6:\fcmdline\15formatting\vformat\0\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsources\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\rpriority\tname\1\0\0\vipairs\1\b\0\0\vbuffer\tpath\rnvim_lsp\28nvim_lsp_signature_help\nneorg\fluasnip\forgmode\f<S-Tab>\0\1\0\0\0\n<Tab>\6s\0\1\0\0\0\t<CR>\1\0\1\vselect\1\fconfirm\n<C-e>\6c\nclose\6i\1\0\0\nabort\n<C-j>\1\4\0\0\6i\6c\6s\21select_next_item\n<C-k>\1\4\0\0\6i\6c\6s\21select_prev_item\n<C-n>\1\0\0\1\3\0\0\6i\6c\rcomplete\fmapping\1\0\25\rFunction\bÔûî\vFolder\bÔÅª\vMethod\bÔö¶\14Reference\bÔúÜ\tText\bÔÉâ\tFile\bÔúò\rConstant\bÔ£ø\nColor\bÔ£ó\vStruct\bÔ≠Ñ\fSnippet\bÔô∞\nEvent\bÔÉß\fKeyword\bÔ®ã\rOperator\bÔöî\tEnum\bÔÖù\18TypeParameter\5\nValue\bÔ¢ü\tUnit\bÔ•¨\rProperty\bÔ∞†\vModule\bÔ£í\14Interface\bÔÉ®\nClass\bÔ¥Ø\rVariable\bÔúõ\nField\bÔ∞†\16Constructor\b‚åò\15EnumMember\bÔÖù\fluasnip\bcmp\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\14colorizer\nsetup\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/NvChad/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nÑ\1\0\1\3\0\4\0\b9\1\0\0+\2\1\0=\2\1\1+\2\1\0=\2\2\1+\2\1\0=\2\3\1K\0\1\0\31documentFormattingProvider\30document_range_formatting\24document_formatting\24server_capabilities“\n\1\0\f\0@\0o6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\3\0009\2\4\0029\2\5\2\18\3\2\0'\5\6\0005\6\a\0B\3\3\1\18\3\2\0'\5\b\0005\6\t\0B\3\3\1\18\3\2\0'\5\n\0005\6\v\0B\3\3\1\18\3\2\0'\5\f\0005\6\r\0B\3\3\0013\3\14\0006\4\3\0009\4\15\0049\4\16\0045\6\17\0B\4\2\0016\4\3\0009\4\18\0049\4\19\0049\4\20\4B\4\1\0025\5\22\0=\5\21\0049\5\23\0009\5\24\0055\a\26\0005\b\25\0=\b\27\a5\b\28\0=\b\29\a9\b\30\1'\n\31\0B\b\2\2=\b \a=\4!\a=\3\"\aB\5\2\0019\5#\0009\5\24\0055\a$\0=\3\"\aB\5\2\0019\5%\0009\5\24\0054\a\0\0B\5\2\0019\5&\0009\5\24\0055\a'\0=\3\"\aB\5\2\0019\5(\0009\5\24\0055\a+\0009\b\30\1'\n)\0'\v*\0B\b\3\2=\b \a=\3\"\aB\5\2\0019\5,\0009\5\24\0055\a-\0009\b\30\1'\n)\0B\b\2\2=\b \aB\5\2\0019\5.\0009\5\24\0055\a6\0005\b4\0005\t2\0005\n0\0005\v/\0=\v1\n=\n3\t=\t5\b=\b7\aB\5\2\0019\0058\0009\5\24\0055\a>\0005\b<\0005\t:\0005\n9\0=\n;\t=\t=\b=\b7\aB\5\2\0019\5?\0009\5\24\0054\a\0\0B\5\2\1K\0\1\0\rmarksman\1\0\0\18rust-analyzer\1\0\0\16checkOnSave\1\0\0\1\0\2\fenabled\2\fcommand\vclippy\18rust_analyzer\rsettings\1\0\0\bLua\1\0\0\16diagnostics\1\0\0\fglobals\1\0\0\1\4\0\0\bvim\bkit\nneorg\16sumneko_lua\1\0\0\fpyright\1\0\0\fpom.xml\t.git\njdtls\1\0\0\ncmake\16clojure_lsp\1\0\0\vtexlab\14on_attach\17capabilities\rroot_dir build/compile_commands.json\17root_pattern\17init_options\1\0\1\28compilationDatabasePath\nbuild\bcmd\1\0\0\1\5\0\0\vclangd\23--background-index\27--compile-commands-dir\nbuild\nsetup\vclangd\1\2\0\0\vutf-16\19offsetEncoding\29make_client_capabilities\rprotocol\blsp\1\0\5\18severity_sort\1\21update_in_insert\1\14underline\2\nsigns\2\17virtual_text\2\vconfig\15diagnostic\0\1\0\2\vtexthl\27LspDiagnosticsSignHint\ttext\tÔ†¥ \27LspDiagnosticsSignHint\1\0\2\vtexthl\"LspDiagnosticsSignInformation\ttext\tÔÅö \"LspDiagnosticsSignInformation\1\0\2\vtexthl\30LspDiagnosticsSignWarning\ttext\tÔÅ± \30LspDiagnosticsSignWarning\1\0\2\vtexthl\28LspDiagnosticsSignError\ttext\tÔÅó \28LspDiagnosticsSignError\16sign_define\afn\bvim\19lspconfig/util\14lspconfig\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\nâ\1\0\2\a\0\t\0\0196\2\0\0006\4\1\0009\4\2\0049\4\3\0045\5\4\0=\0\5\5=\1\6\0056\6\1\0009\6\a\6=\6\b\5B\2\3\3\15\0\2\0X\4\5Ä6\4\1\0009\4\a\4\4\3\4\0X\4\1ÄL\3\2\0K\0\1\0\17cancelreturn\bNIL\fdefault\vprompt\1\0\0\ninput\afn\bvim\npcallÏ\1\0\0\3\1\6\1!-\0\0\0009\0\0\0005\2\1\0B\0\2\0029\1\2\0009\1\3\0019\2\2\0009\2\3\2:\2\2\2\23\2\0\2>\2\2\0019\1\2\0009\1\4\0019\2\2\0009\2\4\2:\2\2\2\23\2\0\2>\2\2\0019\1\5\0009\1\3\0019\2\5\0009\2\3\2:\2\2\2\23\2\0\2>\2\2\0019\1\5\0009\1\4\0019\2\5\0009\2\4\2:\2\2\2\23\2\0\2>\2\2\1L\0\2\0\1¿\nright\rlast_pos\14first_pos\tleft\1\0\2\tchar\6e\fpattern#\\begin{(%w-)}().-\\end{(%w-)}()\19get_selections\2S\0\0\3\1\1\0\14-\0\0\0'\2\0\0B\0\2\2\15\0\0\0X\1\bÄ4\1\3\0004\2\3\0>\0\1\2>\2\1\0014\2\3\0>\0\1\2>\2\2\1L\1\2\0K\0\1\0\0¿\22New environment: ·\1\1\0\n\0\16\0\0223\0\0\0006\1\1\0'\3\2\0B\1\2\0023\2\3\0006\3\1\0'\5\4\0B\3\2\0029\3\5\0035\5\14\0005\6\f\0005\a\6\0005\b\a\0=\2\b\b3\t\t\0=\t\n\b=\b\v\a=\a\r\6=\6\15\5B\3\2\0012\0\0ÄK\0\1\0\14surrounds\1\0\0\6e\1\0\0\vchange\16replacement\0\vtarget\1\0\0\1\0\1\tfind\27\\begin{%w-}.-\\end{%w-}\nsetup\18nvim-surround\0\25nvim-surround.config\frequire\0\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    after = { "neorg" },
    config = { "\27LJ\2\nÎ\5\0\0\6\0\28\0'6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\1'\2\5\0=\2\4\0016\1\2\0009\1\3\1'\2\a\0=\2\6\0016\1\2\0009\1\3\1)\2\20\0=\2\b\0019\1\t\0005\3\v\0005\4\n\0=\4\f\0035\4\r\0005\5\14\0=\5\15\0045\5\16\0=\5\17\4=\4\18\0035\4\19\0005\5\20\0=\5\15\4=\4\21\0035\4\22\0=\4\23\0035\4\24\0004\5\0\0=\5\15\0045\5\25\0=\5\26\4=\4\27\3B\1\2\1K\0\1\0\15playground\16keybindings\1\0\n\28toggle_language_display\6I\27toggle_anonymous_nodes\6a\30toggle_injected_languages\6t\21toggle_hl_groups\6i\24toggle_query_editor\6o\14show_help\6?\14goto_node\t<cr>\21unfocus_language\6F\19focus_language\6f\vupdate\6R\1\0\3\15updatetime\3\25\venable\2\20persist_queries\1\14autopairs\1\0\1\venable\2\vindent\1\2\0\0\vpython\1\0\1\venable\2\14highlight&additional_vim_regex_highlighting\1\2\0\0\borg\fdisable\1\2\0\0\thtml\1\0\1\venable\2\21ensure_installed\1\0\0\1\f\0\0\bcpp\vpython\tjson\trust\tjava\blua\thtml\nlatex\tnorg\14norg_meta\rmarkdown\nsetup\14foldlevel\texpr\15foldmethod\31nvim_treesitter#foldexpr()\rfoldexpr\6o\bvim\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20nvim-ts-autotag\nsetup\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ufo"] = {
    config = { "\27LJ\2\n%\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\15treesitter\vindentS\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\22provider_selector\1\0\0\0\nsetup\bufo\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/nvim-ufo",
    url = "https://github.com/kevinhwang91/nvim-ufo"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    config = { "\27LJ\2\n‹\2\0\0\a\0\20\0%6\0\0\0'\2\1\0B\0\2\0026\1\2\0\18\3\1\0009\1\3\1B\1\2\2\18\3\1\0009\1\4\1'\4\5\0'\5\6\0B\1\4\2\18\3\1\0009\1\a\1'\4\b\0009\5\t\0005\6\n\0B\1\5\2\18\3\1\0009\1\a\1'\4\v\0009\5\f\0005\6\r\0B\1\5\2\18\3\1\0009\1\a\1'\4\14\0009\5\15\0005\6\16\0B\1\5\2\18\3\1\0009\1\a\1'\4\17\0009\5\18\0005\6\19\0B\1\5\1K\0\1\0\1\0\1\tdesc\20Update packages\fcompile\6c\1\0\1\tdesc\20Update packages\vupdate\6u\1\0\1\tdesc\21Install packages\finstall\6i\1\0\1\tdesc\27Remove unused packages\nclean\6d\bset\f+packer\14<leader>p\vprefix\bnew\bmap\vpacker\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plantuml-syntax"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/plantuml-syntax",
    url = "https://github.com/aklt/plantuml-syntax"
  },
  playground = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["skeletor.nvim"] = {
    commands = { "Skeletor" },
    config = { "\27LJ\2\n3\0\0\3\1\2\0\4-\0\0\0009\0\0\0'\2\1\0D\0\2\0\0¿\19Project name: \15read_inputá\1\0\0\5\1\a\0\15-\0\0\0\18\2\0\0009\0\0\0005\3\1\0005\4\2\0=\4\3\3B\0\3\2\18\2\0\0009\0\4\0B\0\2\2:\1\1\0\18\3\1\0009\1\5\1'\4\6\0D\1\3\0\1¿\19(%d%d?%.%d%d?)\nmatch\tsync\targs\1\2\0\0\14--version\1\0\1\fcommand\ncmake\bnewØ\1\0\1\b\1\a\0\19-\1\0\0\18\3\1\0009\1\0\0015\4\1\0005\5\2\0009\6\3\0>\6\2\0059\6\3\0'\a\4\0&\6\a\6>\6\4\5=\5\5\0049\5\3\0=\5\3\4B\1\3\2\18\3\1\0009\1\6\1B\1\2\1K\0\1\0\1¿\nstart\targs\v/build\bcwd\1\6\0\0\a-S\0\a-B\0'-DCMAKE_EXPORT_COMPILE_COMMANDS=ON\1\0\1\fcommand\ncmake\bnew3\0\0\3\1\2\0\4-\0\0\0009\0\0\0'\2\1\0D\0\2\0\0¿\19Project name: \15read_input=\0\0\3\0\4\0\0056\0\0\0009\0\1\0009\0\2\0'\2\3\0D\0\2\0\22%Y-%m-%d_%H:%M:%S\rstrftime\afn\bvim3\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\17Hello World!\vnotify\bvimÒ\3\1\0\b\0\28\0-6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0005\4\6\0005\5\4\0004\6\0\0=\6\5\5=\5\a\4B\2\2\0019\2\b\0'\4\t\0005\5\n\0005\6\v\0=\6\5\5B\2\3\0019\2\b\0'\4\f\0005\5\r\0005\6\15\0003\a\14\0=\a\16\0063\a\17\0=\a\18\6=\6\5\0053\6\19\0=\6\20\5B\2\3\0019\2\b\0'\4\21\0005\5\22\0005\6\23\0003\a\24\0=\a\16\0063\a\25\0=\a\26\6=\6\5\0053\6\27\0=\6\20\5B\2\3\0012\0\0ÄK\0\1\0\0\17__DATETIME__\0\0\1\0\1\18__USER-NAME__\19Tomas Anderson\1\0\2\flicense\bMIT\ntitle\18Neovim plugin\16nvim-plugin\19after_creation\0\22__CMAKE-VERSION__\0\21__PROJECT-NAME__\1\0\0\0\1\0\1\ntitle\14C++ CMake\14cpp-cmake\1\0\1\18__FILE-NAME__\nnotes\1\0\1\ntitle\15Latex math\nlatex\20define_template\14templates\1\0\0\18substitutions\1\0\0\nsetup\16plenary.job\rskeletor\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/opt/skeletor.nvim",
    url = "https://github.com/danilshvalov/skeletor.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-recent-files"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/telescope-recent-files",
    url = "https://github.com/smartpde/telescope-recent-files"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nË\v\0\0\14\0\\\0ë\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\1\0B\3\2\0029\3\4\0036\4\0\0'\6\1\0B\4\2\0029\4\4\0049\4\5\0049\4\6\0046\5\a\0\18\a\5\0009\5\b\5B\5\2\2\18\a\5\0009\5\t\5'\b\n\0'\t\v\0B\5\4\2\18\a\5\0009\5\f\5'\b\r\0009\t\14\0025\n\15\0B\5\5\2\18\a\5\0009\5\f\5'\b\16\0009\t\17\0025\n\18\0B\5\5\2\18\a\5\0009\5\f\5'\b\19\0009\t\20\0039\t\21\t5\n\22\0B\5\5\2\18\a\5\0009\5\f\5'\b\23\0009\t\5\0039\t\5\t5\n\24\0B\5\5\2\18\a\5\0009\5\f\5'\b\25\0009\t\26\0025\n\27\0B\5\5\0019\5\28\0005\a4\0006\b\0\0'\n\29\0B\b\2\0029\b\30\b5\n \0005\v\31\0=\v!\n5\v#\0005\f\"\0=\f$\v=\v%\n5\v&\0=\v'\n5\v1\0005\f)\0009\r(\1=\r*\f9\r+\1=\r,\f9\r-\1=\r.\f9\r/\1=\r0\f=\f2\v=\v3\nB\b\2\2=\b5\a5\b9\0005\t7\0005\n6\0=\n8\t=\t\14\b=\b:\a5\bV\0005\t;\0005\nT\0005\v=\0009\f<\4=\f>\v9\f?\4=\f@\v9\fA\4=\fB\v9\fC\4=\fD\v9\fE\4=\fF\v9\fG\4=\fH\v9\f<\4=\f\16\v9\fI\4=\fJ\v9\fK\4=\fL\v9\fM\4=\fN\v9\fO\4=\f\r\v9\fP\4=\fQ\v9\fR\4=\fS\v=\vU\n=\n3\t=\t\5\b5\tW\0004\n\0\0=\nX\t=\t\20\b=\b\4\aB\5\2\0015\5Y\0006\6Z\0\18\b\5\0B\6\2\4X\t\3Ä9\v[\0\18\r\n\0B\v\2\1E\t\3\3R\t˚\127K\0\1\0\19load_extension\vipairs\1\4\0\0\14ui-select\17file_browser\17recent_files\20ignore_patterns\1\0\0\1\0\0\6n\1\0\0\6s\15toggle_all\6h\18toggle_hidden\19toggle_browser\6t\15change_cwd\6w\rgoto_cwd\6e\18goto_home_dir\6M\tmove\6R\vrename\6Y\tcopy\6D\vremove\6C\vcreate\6-\1\0\0\20goto_parent_dir\1\0\3\17initial_mode\vnormal\nquiet\2\17hijack_netrw\2\fpickers\1\0\0\17find_command\1\0\2\vhidden\2\14no_ignore\2\1\4\0\0\arg\f--files\r--hidden\rdefaults\1\0\0\rmappings\6i\1\0\0\n<C-k>\28move_selection_previous\n<C-j>\24move_selection_next\n<C-p>\23cycle_history_prev\n<C-n>\1\0\0\23cycle_history_next\25file_ignore_patterns\1\3\0\0\19node_modules/*\f%.git/*\18layout_config\16bottom_pane\1\0\0\1\0\1\vheight\4≥ÊÃô\3≥ÊÃ˛\3\17path_display\1\0\1\fpreview\1\1\0\1\rtruncate\3\2\fget_ivy\21telescope.themes\nsetup\1\0\1\tdesc\vResume\vresume\6p\1\0\1\tdesc\17Browse files\6b\1\0\1\tdesc\17Recent files\tpick\17recent_files\6r\1\0\1\tdesc\15Grep files\14live_grep\6g\1\0\1\tdesc\15Find files\15find_files\6f\bset\n+file\14<leader>f\vprefix\bnew\bmap\factions\17file_browser\15extensions\22telescope.builtin\22telescope.actions\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n∫\2\0\0\6\0\15\0\0186\0\0\0'\2\1\0005\3\2\0005\4\3\0=\4\4\0035\4\5\0005\5\6\0=\5\a\4=\4\b\0035\4\t\0=\4\n\3B\0\3\0016\0\v\0009\0\f\0'\2\r\0005\3\14\0B\0\3\1K\0\1\0\1\0\2\abg\tNONE\afg\tNONE\tTodo\vset_hl\bkit\vsearch\1\0\1\fpattern\19\\b(KEYWORDS)\\b\14highlight\fexclude\1\3\0\0\blog\borg\1\0\5\vbefore\5\fpattern\21.*<(KEYWORDS)\\s*\fkeyword\afg\nafter\5\18comments_only\1\14gui_style\1\0\1\afg\tBOLD\1\0\2\18sign_priority\3Ë\a\nsigns\2\18todo-comments\nsetup\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nò\2\0\0\t\0\17\0&6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\0016\1\4\0\18\3\1\0009\1\5\1B\1\2\2\18\3\1\0009\1\6\1'\4\a\0'\5\b\0B\1\4\2\18\3\1\0009\1\t\1'\4\n\0006\5\v\0009\5\f\0059\a\r\0)\b\0\0B\5\3\0A\1\2\0016\1\4\0\18\3\1\0009\1\5\1B\1\2\2\18\3\1\0009\1\14\1'\4\n\0B\1\3\2\18\3\1\0009\1\t\1'\4\15\0'\5\16\0B\1\4\1K\0\1\0\15<C-\\><C-n>\15<Esc><Esc>\tmode\vtoggle\twrap\bkit\6t\bset\f+toggle\14<leader>t\vprefix\bnew\bmap\1\0\1\14autochdir\2\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n/\0\1\5\1\3\0\0066\1\0\0009\1\1\1-\3\0\0009\3\2\3\18\4\0\0D\1\3\0\0¿\topen\twrap\bkit∑\5\1\0\t\0#\0X6\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\0016\1\3\0\18\3\1\0009\1\4\1B\1\2\2\18\3\1\0009\1\5\1'\4\6\0009\5\a\0005\6\b\0B\1\5\0013\1\t\0006\2\3\0\18\4\2\0009\2\4\0025\5\n\0B\2\3\2\18\4\2\0009\2\5\2'\5\v\0006\6\f\0009\6\r\0069\6\14\0069\6\15\6B\2\4\2\18\4\2\0009\2\5\2'\5\16\0006\6\f\0009\6\17\0069\6\18\6B\2\4\2\18\4\2\0009\2\5\2'\5\19\0006\6\f\0009\6\r\0069\6\14\0069\6\20\6B\2\4\0016\2\3\0\18\4\2\0009\2\4\2B\2\2\2\18\4\2\0009\2\21\2'\5\22\0'\6\23\0B\2\4\2\18\4\2\0009\2\5\2'\5\24\0\18\6\1\0'\b\25\0B\6\2\0025\a\26\0B\2\5\2\18\4\2\0009\2\5\2'\5\27\0006\6\f\0009\6\r\0069\6\14\0069\6\28\0065\a\29\0B\2\5\2\18\4\2\0009\2\5\2'\5\v\0\18\6\1\0'\b\30\0B\6\2\0025\a\31\0B\2\5\2\18\4\2\0009\2\5\2'\5 \0\18\6\1\0'\b!\0B\6\2\0025\a\"\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\tdesc\23Go implementations\24lsp_implementations\6i\1\0\1\tdesc\18Go references\19lsp_references\1\0\1\tdesc\19Go declaration\16declaration\6D\1\0\1\tdesc\19Go definitions\20lsp_definitions\6d\n+goto\6g\vprefix\16code_action\6a\15open_float\15diagnostic\6h\vrename\bbuf\blsp\bvim\6r\1\0\1\vprefix\14<leader>c\0\1\0\1\tdesc\21Show code errors\vtoggle\15<leader>xx\bset\bnew\bmap\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\nF\0\0\5\0\5\0\n6\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3B\3\1\0A\0\1\1K\0\1\0\vgetcwd\6+\vsetreg\afn\bvimˆ\a\1\0\t\0008\0r6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0005\5\3\0=\5\5\4=\4\a\3B\1\2\0016\1\b\0\18\3\1\0009\1\t\0015\4\n\0B\1\3\2\18\3\1\0009\1\v\1'\4\f\0'\5\r\0005\6\14\0B\1\5\2\18\3\1\0009\1\v\1'\4\15\0'\5\16\0005\6\17\0B\1\5\0016\1\b\0\18\3\1\0009\1\t\0015\4\18\0B\1\3\2\18\3\1\0009\1\v\1'\4\19\0'\5\20\0B\1\4\2\18\3\1\0009\1\v\1'\4\21\0'\5\22\0B\1\4\0016\1\b\0\18\3\1\0009\1\t\1B\1\2\2\18\3\1\0009\1\23\1'\4\24\0'\5\25\0B\1\4\2\18\3\1\0009\1\v\1'\4\26\0006\5\27\0009\5\28\0056\a\29\0009\a\30\a9\a\31\a'\b \0B\5\3\0025\6!\0B\1\5\0016\1\b\0\18\3\1\0009\1\t\1B\1\2\2\18\3\1\0009\1\23\1'\4\"\0'\5#\0B\1\4\2\18\3\1\0009\1\v\1'\4$\0006\5\27\0009\5\28\0056\a\29\0009\a%\a9\a&\a'\b'\0B\5\3\0025\6(\0B\1\5\2\18\3\1\0009\1\v\1'\4)\0003\5*\0005\6+\0B\1\5\0019\1,\0005\0033\0005\4.\0005\5-\0=\5/\0045\0050\0=\5$\0045\0051\0=\0052\4=\0044\0035\0045\0B\1\3\0016\1\b\0\18\3\1\0009\1\t\1B\1\2\2\18\3\1\0009\1\v\1'\0046\0006\5\29\0009\5%\0059\0057\5B\1\4\1K\0\1\0\bnoh\n<Esc>\1\0\1\vprefix\r<leader>\6t\1\0\0\6e\1\3\0\0\28<Cmd>Neorg gtd edit<CR>\rGTD edit\1\3\0\0\31<Cmd>Neorg gtd capture<CR>\16GTD capture\6v\1\0\0\1\3\0\0\29<Cmd>Neorg gtd views<CR>\14GTD views\rregister\1\0\1\tdesc\rYank cwd\0\6y\1\0\1\tdesc&Set cwd to current file directory\n%:p:h\acd\bcmd\6c\t+dir\14<leader>d\1\0\1\tdesc\19Open in finder\vopen .\vsystem\afn\bvim\twrap\bkit\6f\n+open\14<leader>o\vprefix\26(v:count? 'j' : 'gj')\6j\26(v:count? 'k' : 'gk')\6k\1\0\2\tmode\anv\texpr\2\1\0\1\tdesc\16End of line\6$\6L\1\0\1\tdesc\18Start of line\6^\6H\bset\1\0\1\tmode\bnvo\bnew\bmap\fplugins\1\0\0\rspelling\1\0\0\1\0\2\fenabled\2\16suggestions\3\20\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    config = { "\27LJ\2\n&\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\rzen-mode\nsetup\0" },
    loaded = true,
    path = "/Users/danilshvalov/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: packer.nvim
time([[Config for packer.nvim]], true)
try_loadstring("\27LJ\2\n‹\2\0\0\a\0\20\0%6\0\0\0'\2\1\0B\0\2\0026\1\2\0\18\3\1\0009\1\3\1B\1\2\2\18\3\1\0009\1\4\1'\4\5\0'\5\6\0B\1\4\2\18\3\1\0009\1\a\1'\4\b\0009\5\t\0005\6\n\0B\1\5\2\18\3\1\0009\1\a\1'\4\v\0009\5\f\0005\6\r\0B\1\5\2\18\3\1\0009\1\a\1'\4\14\0009\5\15\0005\6\16\0B\1\5\2\18\3\1\0009\1\a\1'\4\17\0009\5\18\0005\6\19\0B\1\5\1K\0\1\0\1\0\1\tdesc\20Update packages\fcompile\6c\1\0\1\tdesc\20Update packages\vupdate\6u\1\0\1\tdesc\21Install packages\finstall\6i\1\0\1\tdesc\27Remove unused packages\nclean\6d\bset\f+packer\14<leader>p\vprefix\bnew\bmap\vpacker\frequire\0", "config", "packer.nvim")
time([[Config for packer.nvim]], false)
-- Config for: mason-lspconfig.nvim
time([[Config for mason-lspconfig.nvim]], true)
try_loadstring("\27LJ\2\nÆ\1\0\0\5\0\5\0\a6\0\0\0'\2\1\0005\3\3\0005\4\2\0=\4\4\3B\0\3\1K\0\1\0\21ensure_installed\1\0\1\27automatic_installation\1\1\t\0\0\vclangd\njdtls\18rust_analyzer\16sumneko_lua\vtexlab\fpyright\ncmake\rmarksman\20mason-lspconfig\nsetup\0", "config", "mason-lspconfig.nvim")
time([[Config for mason-lspconfig.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\nÑ\1\0\1\3\0\4\0\b9\1\0\0+\2\1\0=\2\1\1+\2\1\0=\2\2\1+\2\1\0=\2\3\1K\0\1\0\31documentFormattingProvider\30document_range_formatting\24document_formatting\24server_capabilities“\n\1\0\f\0@\0o6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\3\0009\2\4\0029\2\5\2\18\3\2\0'\5\6\0005\6\a\0B\3\3\1\18\3\2\0'\5\b\0005\6\t\0B\3\3\1\18\3\2\0'\5\n\0005\6\v\0B\3\3\1\18\3\2\0'\5\f\0005\6\r\0B\3\3\0013\3\14\0006\4\3\0009\4\15\0049\4\16\0045\6\17\0B\4\2\0016\4\3\0009\4\18\0049\4\19\0049\4\20\4B\4\1\0025\5\22\0=\5\21\0049\5\23\0009\5\24\0055\a\26\0005\b\25\0=\b\27\a5\b\28\0=\b\29\a9\b\30\1'\n\31\0B\b\2\2=\b \a=\4!\a=\3\"\aB\5\2\0019\5#\0009\5\24\0055\a$\0=\3\"\aB\5\2\0019\5%\0009\5\24\0054\a\0\0B\5\2\0019\5&\0009\5\24\0055\a'\0=\3\"\aB\5\2\0019\5(\0009\5\24\0055\a+\0009\b\30\1'\n)\0'\v*\0B\b\3\2=\b \a=\3\"\aB\5\2\0019\5,\0009\5\24\0055\a-\0009\b\30\1'\n)\0B\b\2\2=\b \aB\5\2\0019\5.\0009\5\24\0055\a6\0005\b4\0005\t2\0005\n0\0005\v/\0=\v1\n=\n3\t=\t5\b=\b7\aB\5\2\0019\0058\0009\5\24\0055\a>\0005\b<\0005\t:\0005\n9\0=\n;\t=\t=\b=\b7\aB\5\2\0019\5?\0009\5\24\0054\a\0\0B\5\2\1K\0\1\0\rmarksman\1\0\0\18rust-analyzer\1\0\0\16checkOnSave\1\0\0\1\0\2\fenabled\2\fcommand\vclippy\18rust_analyzer\rsettings\1\0\0\bLua\1\0\0\16diagnostics\1\0\0\fglobals\1\0\0\1\4\0\0\bvim\bkit\nneorg\16sumneko_lua\1\0\0\fpyright\1\0\0\fpom.xml\t.git\njdtls\1\0\0\ncmake\16clojure_lsp\1\0\0\vtexlab\14on_attach\17capabilities\rroot_dir build/compile_commands.json\17root_pattern\17init_options\1\0\1\28compilationDatabasePath\nbuild\bcmd\1\0\0\1\5\0\0\vclangd\23--background-index\27--compile-commands-dir\nbuild\nsetup\vclangd\1\2\0\0\vutf-16\19offsetEncoding\29make_client_capabilities\rprotocol\blsp\1\0\5\18severity_sort\1\21update_in_insert\1\14underline\2\nsigns\2\17virtual_text\2\vconfig\15diagnostic\0\1\0\2\vtexthl\27LspDiagnosticsSignHint\ttext\tÔ†¥ \27LspDiagnosticsSignHint\1\0\2\vtexthl\"LspDiagnosticsSignInformation\ttext\tÔÅö \"LspDiagnosticsSignInformation\1\0\2\vtexthl\30LspDiagnosticsSignWarning\ttext\tÔÅ± \30LspDiagnosticsSignWarning\1\0\2\vtexthl\28LspDiagnosticsSignError\ttext\tÔÅó \28LspDiagnosticsSignError\16sign_define\afn\bvim\19lspconfig/util\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 A\0\0\1\0\5\1\t6\0\0\0009\0\1\0009\0\2\0\t\0\0\0X\0\2Ä'\0\3\0X\1\1Ä'\0\4\0L\0\2\0\aen\aru\riminsert\6o\bvim\2\18\0\0\1\0\1\0\2'\0\0\0L\0\2\0\a%=)\0\0\1\0\3\0\0046\0\0\0009\0\1\0009\0\2\0L\0\2\0\15shiftwidth\abo\bvim\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 -\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\16showtabline\6o\bvim-\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\16showtabline\6o\bvim¢\6\1\0\a\0-\0F6\0\0\0'\2\1\0B\0\2\0025\1\6\0004\2\3\0005\3\4\0003\4\2\0>\4\1\0035\4\3\0=\4\5\3>\3\1\2=\2\a\0015\2\b\0=\2\t\0015\2\r\0005\3\v\0003\4\n\0>\4\1\3>\3\1\0025\3\f\0>\3\2\0023\3\14\0>\3\4\0025\3\15\0>\3\5\2=\2\16\0014\2\3\0005\3\18\0003\4\17\0>\4\1\3>\3\1\0025\3\19\0>\3\2\2=\2\20\0015\2\21\0=\2\22\0014\2\3\0005\3\25\0003\4\23\0>\4\1\0035\4\24\0=\4\5\3>\3\1\2=\2\26\0016\2\27\0009\2\28\2+\3\1\0=\3\29\0029\2\30\0005\4 \0005\5\31\0=\5!\4=\1\"\0045\5$\0005\6#\0=\6\a\5=\5%\4B\2\2\0016\2\27\0009\2&\0023\4'\0)\5\0\0B\2\3\0016\2(\0005\4)\0005\5+\0003\6*\0=\6,\5B\2\3\1K\0\1\0\rcallback\1\0\0\0\1\t\0\0\rWinEnter\rBufEnter\20SessionLoadPost\25FileChangedShellPost\15VimResized\rFiletype\16CursorMoved\17CursorMovedI\fautocmd\0\rdefer_fn\ftabline\1\0\0\1\2\0\0\ttabs\rsections\foptions\1\0\0\1\0\4\17globalstatus\2\23section_separators\5\ntheme\tauto\25component_separators\5\nsetup\rshowmode\6o\bvim\14lualine_z\1\0\0\1\0\1\tleft\3\0\0\14lualine_y\1\2\0\0\rlocation\14lualine_x\1\2\0\0\rfiletype\1\0\1\ticon\bÔ¨¥\0\14lualine_c\1\2\2\0\rfilename\16file_status\2\tpath\3\0\0\1\4\0\0\0\0\16diagnostics\1\2\1\0\vbranch\ticon\bÓú•\1\0\1\ticon\bÔûã\0\14lualine_b\1\2\0\0\tmode\14lualine_a\1\0\0\fpadding\1\0\0\1\0\1\nright\3\0\0\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-ts-autotag
time([[Config for nvim-ts-autotag]], true)
try_loadstring("\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20nvim-ts-autotag\nsetup\0", "config", "nvim-ts-autotag")
time([[Config for nvim-ts-autotag]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\nå\1\0\0\3\0\t\0\0186\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\0026\1\3\0009\1\4\0019\1\5\1\a\1\6\0X\1\4Ä+\1\1\0=\1\a\0'\1\b\0L\1\2\0+\1\2\0=\1\a\0K\0\1\0\t+%s+\fpadding\tnorg\rfiletype\abo\bvim\bget\19Comment.config\frequireH\1\0\5\0\5\0\a6\0\0\0'\2\1\0005\3\2\0003\4\3\0=\4\4\3B\0\3\1K\0\1\0\rpre_hook\0\1\0\1\vignore\a^$\fComment\nsetup\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: zen-mode.nvim
time([[Config for zen-mode.nvim]], true)
try_loadstring("\27LJ\2\n&\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\rzen-mode\nsetup\0", "config", "zen-mode.nvim")
time([[Config for zen-mode.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nm\0\1\5\0\4\0\0189\1\0\0\18\3\1\0009\1\1\1'\4\2\0B\1\3\2\v\1\0\0X\1\tÄ9\1\0\0\18\3\1\0009\1\1\1'\4\3\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\rclass%s+\14struct%s+\nmatch\tlined\0\1\5\0\5\1\0169\1\0\0\18\3\1\0009\1\1\0019\4\2\0\23\4\0\4B\1\3\2\18\3\1\0009\1\3\1'\4\4\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\r[%w%d]+<\nmatch\bcol\bsub\ttext\2›\6\1\0\25\0.\0y6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\2'\2\3\0009\3\4\0005\5\5\0005\6\6\0006\a\a\0009\a\b\a'\t\t\0'\n\n\0'\v\v\0B\a\4\2=\a\f\6=\6\r\0056\6\a\0009\6\b\6\18\b\2\0'\t\n\0'\n\v\0B\6\4\2=\6\14\0054\6\0\0=\6\15\5B\3\2\0019\3\16\0\18\5\1\0'\a\17\0'\b\18\0B\5\3\0A\3\0\0019\3\16\0\18\5\1\0'\a\19\0'\b\20\0'\t\21\0B\5\4\0A\3\0\0019\3\16\0\18\5\1\0'\a\22\0'\b\23\0B\5\3\0A\3\0\0019\3\16\0\18\5\1\0'\a\24\0'\b\25\0B\5\3\0A\3\0\0019\3\16\0\18\5\1\0'\a\26\0'\b\27\0B\5\3\0A\3\0\0019\3\16\0\18\5\1\0'\a\28\0'\b\29\0'\t\30\0B\5\4\2\18\a\5\0009\5\31\0053\b \0B\5\3\0A\3\0\0019\3\16\0\18\5\1\0'\a!\0'\b\"\0'\t\30\0B\5\4\2\18\a\5\0009\5\31\0053\b#\0B\5\3\0A\3\0\0014\3\5\0005\4$\0>\4\1\0035\4%\0>\4\2\0035\4&\0>\4\3\0035\4'\0>\4\4\0035\4(\0006\5)\0\18\a\4\0B\5\2\4X\b\23Ä6\n*\0\18\f\3\0B\n\2\4H\r\17Ä9\15\16\0\18\17\1\0006\19\a\0009\19+\19'\21,\0\18\22\t\0:\23\1\14B\19\4\0026\20\a\0009\20+\20'\22,\0\18\23\t\0:\24\2\14B\20\4\2'\21-\0B\17\4\0A\15\0\1F\r\3\3R\rÌ\127E\b\3\3R\bÁ\127K\0\1\0\btex\n\\%s%s\vformat\npairs\vipairs\1\5\0\0\bbig\tbigg\bBig\tBigg\1\3\0\0\6|\6|\1\3\0\0\6(\6)\1\3\0\0\6{\6}\1\3\0\0\6[\6]\0\6>\6<\0\14with_pair\bcpp\a};\6{\a\\]\a\\[\a\\)\a\\(\a\\}\a\\{\trust\a\"#\br#\"\a*/\a/*\radd_rule\21disable_filetype\22ignored_next_char\14fast_wrap\fpattern\5\b%s+\26[%'%\"%)%>%]%)%}%%s%^]\tgsub\vstring\1\0\1\bmap\n<A-x>\1\0\1\30enable_check_bracket_line\1\nsetup$[%w%.–ê-–Ø%–∞-—è–Å—ë%(%[%{%'%\"]\24nvim-autopairs.rule\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n#\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\nmason\nsetup\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\nâ\1\0\2\a\0\t\0\0196\2\0\0006\4\1\0009\4\2\0049\4\3\0045\5\4\0=\0\5\5=\1\6\0056\6\1\0009\6\a\6=\6\b\5B\2\3\3\15\0\2\0X\4\5Ä6\4\1\0009\4\a\4\4\3\4\0X\4\1ÄL\3\2\0K\0\1\0\17cancelreturn\bNIL\fdefault\vprompt\1\0\0\ninput\afn\bvim\npcallÏ\1\0\0\3\1\6\1!-\0\0\0009\0\0\0005\2\1\0B\0\2\0029\1\2\0009\1\3\0019\2\2\0009\2\3\2:\2\2\2\23\2\0\2>\2\2\0019\1\2\0009\1\4\0019\2\2\0009\2\4\2:\2\2\2\23\2\0\2>\2\2\0019\1\5\0009\1\3\0019\2\5\0009\2\3\2:\2\2\2\23\2\0\2>\2\2\0019\1\5\0009\1\4\0019\2\5\0009\2\4\2:\2\2\2\23\2\0\2>\2\2\1L\0\2\0\1¿\nright\rlast_pos\14first_pos\tleft\1\0\2\tchar\6e\fpattern#\\begin{(%w-)}().-\\end{(%w-)}()\19get_selections\2S\0\0\3\1\1\0\14-\0\0\0'\2\0\0B\0\2\2\15\0\0\0X\1\bÄ4\1\3\0004\2\3\0>\0\1\2>\2\1\0014\2\3\0>\0\1\2>\2\2\1L\1\2\0K\0\1\0\0¿\22New environment: ·\1\1\0\n\0\16\0\0223\0\0\0006\1\1\0'\3\2\0B\1\2\0023\2\3\0006\3\1\0'\5\4\0B\3\2\0029\3\5\0035\5\14\0005\6\f\0005\a\6\0005\b\a\0=\2\b\b3\t\t\0=\t\n\b=\b\v\a=\a\r\6=\6\15\5B\3\2\0012\0\0ÄK\0\1\0\14surrounds\1\0\0\6e\1\0\0\vchange\16replacement\0\vtarget\1\0\0\1\0\1\tfind\27\\begin{%w-}.-\\end{%w-}\nsetup\18nvim-surround\0\25nvim-surround.config\frequire\0\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\nb\0\0\6\1\a\0\f-\0\0\0005\2\5\0006\3\0\0009\3\1\0039\3\2\3'\5\3\0B\3\2\2'\4\4\0&\3\4\3=\3\6\2B\0\2\1K\0\1\0\1¿\npaths\1\0\0\14/snippets\vconfig\fstdpath\afn\bvim+\0\0\2\2\1\0\6-\0\0\0009\0\0\0B\0\1\1-\0\1\0B\0\1\1K\0\1\0\0¿\2¿\fcleanup¢\1\2\0\6\0\b\1\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0G\2\0\0A\0\0\2\21\1\0\0\b\1\0\0X\1\1ÄL\0\2\0006\1\3\0009\1\4\0016\3\3\0009\3\5\0039\3\6\3'\4\a\0+\5\2\0D\1\4\0\6.\rfiletype\abo\nsplit\bvim\20from_cursor_pos&luasnip.extras.filetype_functions\frequire\0¯\2\1\0\a\0\r\0\0226\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0013\2\4\0006\3\5\0'\5\6\0003\6\a\0B\3\3\0019\3\b\0009\3\t\0035\5\n\0003\6\v\0=\6\f\5B\3\2\1\18\3\2\0B\3\1\0012\0\0ÄK\0\1\0\fft_func\0\1\0\4\25store_selection_keys\n<Tab>\24delete_check_events\28TextChanged,InsertLeave\24region_check_events'CursorMoved,CursorHold,InsertEnter\18update_events)InsertLeave,TextChanged,TextChangedI\nsetup\vconfig\0\19ReloadSnippets\15create_cmd\0\tload\"luasnip.loaders.from_snipmate\fluasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\14colorizer\nsetup\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: nvim-FeMaco.lua
time([[Config for nvim-FeMaco.lua]], true)
try_loadstring("\27LJ\2\n~\0\0\5\0\6\0\0176\0\0\0009\0\1\0009\0\2\0B\0\1\0016\0\0\0009\0\3\0009\0\4\0+\2\1\0+\3\1\0B\0\3\0026\1\0\0009\1\3\0019\1\5\1)\3\0\0\18\4\0\0B\1\3\1L\0\2\0\21nvim_win_set_buf\20nvim_create_buf\bapi\nsplit\bcmd\bvim5\0\1\2\0\2\0\b\6\0\0\0X\1\4Ä\6\0\1\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\rmarkdown\tnorgê\2\1\0\b\0\18\0\0306\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0019\2\4\0005\4\6\0003\5\5\0=\5\a\0043\5\b\0=\5\t\4B\2\2\0016\2\n\0\18\4\2\0009\2\v\2B\2\2\2\18\4\2\0009\2\f\2'\5\r\0'\6\14\0B\2\4\2\18\4\2\0009\2\15\2'\5\16\0\18\6\1\0005\a\17\0B\2\5\1K\0\1\0\1\0\1\tdesc\20Edit code block\6e\bset\n+code\14<leader>c\vprefix\bnew\bmap\19ensure_newline\0\19prepare_buffer\1\0\0\0\nsetup\20edit_code_block\16femaco.edit\vfemaco\frequire\0", "config", "nvim-FeMaco.lua")
time([[Config for nvim-FeMaco.lua]], false)
-- Config for: neogen
time([[Config for neogen]], true)
try_loadstring("\27LJ\2\n¡\1\0\0\a\0\f\0\0226\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0016\1\3\0\18\3\1\0009\1\4\1B\1\2\2\18\3\1\0009\1\5\1'\4\6\0'\5\a\0B\1\4\2\18\3\1\0009\1\b\1'\4\t\0009\5\n\0005\6\v\0B\1\5\1K\0\1\0\1\0\1\tdesc\27Generate documentation\rgenerate\6g\bset\n+code\14<leader>c\vprefix\bnew\bmap\nsetup\vneogen\frequire\0", "config", "neogen")
time([[Config for neogen]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nÏ\1\0\0\b\4\b\0!6\0\0\0009\0\1\0009\0\2\0B\0\1\0026\1\0\0009\1\1\0019\1\3\1)\3\0\0B\1\2\2:\1\1\1-\2\0\0009\2\4\2\18\4\1\0-\5\1\0008\5\0\0059\5\5\5B\2\3\2\14\0\2\0X\3\1ÄK\0\1\0-\3\2\0009\3\6\3\18\5\0\0-\6\3\0\18\a\2\0B\3\4\1-\3\2\0009\3\a\3\18\5\0\0-\6\3\0\18\a\2\0B\3\4\1K\0\1\0\3¿\2¿\4¿\5¿\17show_deleted\15show_added\nhunks\14find_hunk\24nvim_win_get_cursor\25nvim_get_current_buf\bapi\bvimN\0\0\6\1\3\0\t6\0\0\0009\0\1\0009\0\2\0)\2\0\0-\3\0\0)\4\0\0)\5ˇˇB\0\5\1K\0\1\0\5¿\29nvim_buf_clear_namespace\bapi\bvimÀ\t\1\0\f\0002\0S6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\16\0005\4\4\0005\5\3\0=\5\5\0045\5\6\0=\5\a\0045\5\b\0=\5\t\0045\5\n\0=\5\v\0045\5\f\0=\5\r\0045\5\14\0=\5\15\4=\4\17\3B\1\2\0016\1\0\0'\3\18\0B\1\2\0026\2\0\0'\4\19\0B\2\2\0029\2\20\0026\3\0\0'\5\21\0B\3\2\0026\4\0\0'\6\22\0B\4\2\0026\5\23\0009\5\24\0059\5\25\5'\a\26\0B\5\2\0023\6\28\0=\6\27\0016\6\29\0\18\b\6\0009\6\30\0065\t\31\0B\6\3\2\18\b\6\0009\6 \6'\t!\0009\n\"\0005\v#\0B\6\5\2\18\b\6\0009\6 \6'\t$\0009\n%\0005\v&\0B\6\5\2\18\b\6\0009\6 \6'\t'\0009\n(\0005\v)\0B\6\5\2\18\b\6\0009\6 \6'\t*\0009\n+\0005\v,\0B\6\5\2\18\b\6\0009\6 \6'\t-\0009\n\27\0005\v.\0B\6\5\2\18\b\6\0009\6 \6'\t/\0003\n0\0005\v1\0B\6\5\0012\0\0ÄK\0\1\0\1\0\1\tdesc\23Clear hunk preview\0\6c\1\0\1\tdesc\17Preview hunk\6h\1\0\1\tdesc\15Stage hunk\15stage_hunk\6s\1\0\1\tdesc\15Reset hunk\15reset_hunk\6r\1\0\1\tdesc\14Next hunk\14next_hunk\6n\1\0\1\tdesc\18Previous hunk\14prev_hunk\6p\bset\1\0\1\vprefix\14<leader>g\bnew\bmap\0\24preview_hunk_inline\28gitsigns_preview_inline\26nvim_create_namespace\bapi\bvim\21gitsigns.manager\19gitsigns.hunks\ncache\19gitsigns.cache\21gitsigns.actions\nsigns\1\0\0\14untracked\1\0\4\ahl\16GitSignsAdd\ttext\b‚îÇ\nnumhl\18GitSignsAddNr\vlinehl\18GitSignsAddLn\17changedelete\1\0\4\ahl\19GitSignsChange\ttext\b‚îÇ\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\14topdelete\1\0\4\ahl\19GitSignsDelete\ttext\b‚îÇ\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\vdelete\1\0\4\ahl\19GitSignsDelete\ttext\b‚îÇ\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\vchange\1\0\4\ahl\19GitSignsChange\ttext\b‚îÇ\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\badd\1\0\0\1\0\4\ahl\16GitSignsAdd\ttext\b‚îÇ\nnumhl\18GitSignsAddNr\vlinehl\18GitSignsAddLn\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n/\0\1\5\1\3\0\0066\1\0\0009\1\1\1-\3\0\0009\3\2\3\18\4\0\0D\1\3\0\0¿\topen\twrap\bkit∑\5\1\0\t\0#\0X6\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\0016\1\3\0\18\3\1\0009\1\4\1B\1\2\2\18\3\1\0009\1\5\1'\4\6\0009\5\a\0005\6\b\0B\1\5\0013\1\t\0006\2\3\0\18\4\2\0009\2\4\0025\5\n\0B\2\3\2\18\4\2\0009\2\5\2'\5\v\0006\6\f\0009\6\r\0069\6\14\0069\6\15\6B\2\4\2\18\4\2\0009\2\5\2'\5\16\0006\6\f\0009\6\17\0069\6\18\6B\2\4\2\18\4\2\0009\2\5\2'\5\19\0006\6\f\0009\6\r\0069\6\14\0069\6\20\6B\2\4\0016\2\3\0\18\4\2\0009\2\4\2B\2\2\2\18\4\2\0009\2\21\2'\5\22\0'\6\23\0B\2\4\2\18\4\2\0009\2\5\2'\5\24\0\18\6\1\0'\b\25\0B\6\2\0025\a\26\0B\2\5\2\18\4\2\0009\2\5\2'\5\27\0006\6\f\0009\6\r\0069\6\14\0069\6\28\0065\a\29\0B\2\5\2\18\4\2\0009\2\5\2'\5\v\0\18\6\1\0'\b\30\0B\6\2\0025\a\31\0B\2\5\2\18\4\2\0009\2\5\2'\5 \0\18\6\1\0'\b!\0B\6\2\0025\a\"\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\tdesc\23Go implementations\24lsp_implementations\6i\1\0\1\tdesc\18Go references\19lsp_references\1\0\1\tdesc\19Go declaration\16declaration\6D\1\0\1\tdesc\19Go definitions\20lsp_definitions\6d\n+goto\6g\vprefix\16code_action\6a\15open_float\15diagnostic\6h\vrename\bbuf\blsp\bvim\6r\1\0\1\vprefix\14<leader>c\0\1\0\1\tdesc\21Show code errors\vtoggle\15<leader>xx\bset\bnew\bmap\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nú\1\0\1\3\2\4\0\21-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\vÄ-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4Ä-\1\1\0009\1\3\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\1¿\19expand_or_jump\23expand_or_jumpable\fconfirm\23get_selected_entryO\0\1\4\1\2\0\14-\1\0\0009\1\0\1)\3\1\0B\1\2\2\15\0\1\0X\2\5Ä-\1\0\0009\1\1\1)\3\1\0B\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\1¿\tjump\rjumpableO\0\1\4\1\2\0\14-\1\0\0009\1\0\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\0\0009\1\1\1)\3ˇˇB\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\1¿\tjump\rjumpableO\0\1\4\1\2\0\14-\1\0\0009\1\0\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\0\0009\1\1\1)\3ˇˇB\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\1¿\tjump\rjumpable)\0\1\4\1\2\0\4-\1\0\0009\1\0\0019\3\1\0D\1\2\0\1¿\tbody\15lsp_expand/\0\2\4\1\2\0\a9\2\1\1=\2\0\1-\2\0\0009\3\1\0018\2\3\2=\2\1\1L\1\2\0\2¿\tkind\tmenuô\t\1\0\15\0:\0o6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0025\2\3\0005\3\a\0009\4\4\0009\6\4\0009\6\5\6B\6\1\0025\a\6\0B\4\3\2=\4\b\0039\4\4\0009\6\4\0009\6\t\6B\6\1\0025\a\n\0B\4\3\2=\4\v\0039\4\4\0009\6\4\0009\6\f\6B\6\1\0025\a\r\0B\4\3\2=\4\14\0039\4\4\0005\6\16\0009\a\4\0009\a\15\aB\a\1\2=\a\17\0069\a\4\0009\a\18\aB\a\1\2=\a\19\6B\4\2\2=\4\20\0039\4\4\0009\4\21\0045\6\22\0B\4\2\2=\4\23\0039\4\4\0005\6\25\0003\a\24\0=\a\17\0063\a\26\0=\a\27\6B\4\2\2=\4\28\0039\4\4\0005\6\30\0003\a\29\0=\a\17\0063\a\31\0=\a\27\6B\4\2\2=\4 \0035\4!\0004\5\0\0006\6\"\0\18\b\4\0B\6\2\4X\t\4Ä5\v#\0=\n$\v=\t%\v<\v\t\5E\t\3\3R\t˙\1279\6&\0005\b*\0005\t(\0003\n'\0=\n)\t=\t+\b=\3\4\b=\5,\b5\t.\0005\n-\0=\n/\t3\n0\0=\n1\t=\t2\bB\6\2\0019\6&\0009\0063\6'\b4\0005\t6\0009\n\4\0009\n5\n9\n3\nB\n\1\2=\n\4\t9\n7\0009\n,\n4\f\3\0005\r8\0>\r\1\f4\r\3\0005\0149\0>\14\1\rB\n\3\2=\n,\tB\6\3\0012\0\0ÄK\0\1\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\vconfig\1\0\0\vpreset\6:\fcmdline\15formatting\vformat\0\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsources\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\rpriority\tname\1\0\0\vipairs\1\b\0\0\vbuffer\tpath\rnvim_lsp\28nvim_lsp_signature_help\nneorg\fluasnip\forgmode\f<S-Tab>\0\1\0\0\0\n<Tab>\6s\0\1\0\0\0\t<CR>\1\0\1\vselect\1\fconfirm\n<C-e>\6c\nclose\6i\1\0\0\nabort\n<C-j>\1\4\0\0\6i\6c\6s\21select_next_item\n<C-k>\1\4\0\0\6i\6c\6s\21select_prev_item\n<C-n>\1\0\0\1\3\0\0\6i\6c\rcomplete\fmapping\1\0\25\rFunction\bÔûî\vFolder\bÔÅª\vMethod\bÔö¶\14Reference\bÔúÜ\tText\bÔÉâ\tFile\bÔúò\rConstant\bÔ£ø\nColor\bÔ£ó\vStruct\bÔ≠Ñ\fSnippet\bÔô∞\nEvent\bÔÉß\fKeyword\bÔ®ã\rOperator\bÔöî\tEnum\bÔÖù\18TypeParameter\5\nValue\bÔ¢ü\tUnit\bÔ•¨\rProperty\bÔ∞†\vModule\bÔ£í\14Interface\bÔÉ®\nClass\bÔ¥Ø\rVariable\bÔúõ\nField\bÔ∞†\16Constructor\b‚åò\15EnumMember\bÔÖù\fluasnip\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: git-conflict.nvim
time([[Config for git-conflict.nvim]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17git-conflict\nsetup\0", "config", "git-conflict.nvim")
time([[Config for git-conflict.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nò\2\0\0\t\0\17\0&6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\0016\1\4\0\18\3\1\0009\1\5\1B\1\2\2\18\3\1\0009\1\6\1'\4\a\0'\5\b\0B\1\4\2\18\3\1\0009\1\t\1'\4\n\0006\5\v\0009\5\f\0059\a\r\0)\b\0\0B\5\3\0A\1\2\0016\1\4\0\18\3\1\0009\1\5\1B\1\2\2\18\3\1\0009\1\14\1'\4\n\0B\1\3\2\18\3\1\0009\1\t\1'\4\15\0'\5\16\0B\1\4\1K\0\1\0\15<C-\\><C-n>\15<Esc><Esc>\tmode\vtoggle\twrap\bkit\6t\bset\f+toggle\14<leader>t\vprefix\bnew\bmap\1\0\1\14autochdir\2\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\nF\0\0\5\0\5\0\n6\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3B\3\1\0A\0\1\1K\0\1\0\vgetcwd\6+\vsetreg\afn\bvimˆ\a\1\0\t\0008\0r6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0005\5\3\0=\5\5\4=\4\a\3B\1\2\0016\1\b\0\18\3\1\0009\1\t\0015\4\n\0B\1\3\2\18\3\1\0009\1\v\1'\4\f\0'\5\r\0005\6\14\0B\1\5\2\18\3\1\0009\1\v\1'\4\15\0'\5\16\0005\6\17\0B\1\5\0016\1\b\0\18\3\1\0009\1\t\0015\4\18\0B\1\3\2\18\3\1\0009\1\v\1'\4\19\0'\5\20\0B\1\4\2\18\3\1\0009\1\v\1'\4\21\0'\5\22\0B\1\4\0016\1\b\0\18\3\1\0009\1\t\1B\1\2\2\18\3\1\0009\1\23\1'\4\24\0'\5\25\0B\1\4\2\18\3\1\0009\1\v\1'\4\26\0006\5\27\0009\5\28\0056\a\29\0009\a\30\a9\a\31\a'\b \0B\5\3\0025\6!\0B\1\5\0016\1\b\0\18\3\1\0009\1\t\1B\1\2\2\18\3\1\0009\1\23\1'\4\"\0'\5#\0B\1\4\2\18\3\1\0009\1\v\1'\4$\0006\5\27\0009\5\28\0056\a\29\0009\a%\a9\a&\a'\b'\0B\5\3\0025\6(\0B\1\5\2\18\3\1\0009\1\v\1'\4)\0003\5*\0005\6+\0B\1\5\0019\1,\0005\0033\0005\4.\0005\5-\0=\5/\0045\0050\0=\5$\0045\0051\0=\0052\4=\0044\0035\0045\0B\1\3\0016\1\b\0\18\3\1\0009\1\t\1B\1\2\2\18\3\1\0009\1\v\1'\0046\0006\5\29\0009\5%\0059\0057\5B\1\4\1K\0\1\0\bnoh\n<Esc>\1\0\1\vprefix\r<leader>\6t\1\0\0\6e\1\3\0\0\28<Cmd>Neorg gtd edit<CR>\rGTD edit\1\3\0\0\31<Cmd>Neorg gtd capture<CR>\16GTD capture\6v\1\0\0\1\3\0\0\29<Cmd>Neorg gtd views<CR>\14GTD views\rregister\1\0\1\tdesc\rYank cwd\0\6y\1\0\1\tdesc&Set cwd to current file directory\n%:p:h\acd\bcmd\6c\t+dir\14<leader>d\1\0\1\tdesc\19Open in finder\vopen .\vsystem\afn\bvim\twrap\bkit\6f\n+open\14<leader>o\vprefix\26(v:count? 'j' : 'gj')\6j\26(v:count? 'k' : 'gk')\6k\1\0\2\tmode\anv\texpr\2\1\0\1\tdesc\16End of line\6$\6L\1\0\1\tdesc\18Start of line\6^\6H\bset\1\0\1\tmode\bnvo\bnew\bmap\fplugins\1\0\0\rspelling\1\0\0\1\0\2\fenabled\2\16suggestions\3\20\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: neodev.nvim
time([[Config for neodev.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vneodev\frequire\0", "config", "neodev.nvim")
time([[Config for neodev.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n∫\2\0\0\6\0\15\0\0186\0\0\0'\2\1\0005\3\2\0005\4\3\0=\4\4\0035\4\5\0005\5\6\0=\5\a\4=\4\b\0035\4\t\0=\4\n\3B\0\3\0016\0\v\0009\0\f\0'\2\r\0005\3\14\0B\0\3\1K\0\1\0\1\0\2\abg\tNONE\afg\tNONE\tTodo\vset_hl\bkit\vsearch\1\0\1\fpattern\19\\b(KEYWORDS)\\b\14highlight\fexclude\1\3\0\0\blog\borg\1\0\5\vbefore\5\fpattern\21.*<(KEYWORDS)\\s*\fkeyword\afg\nafter\5\18comments_only\1\14gui_style\1\0\1\afg\tBOLD\1\0\2\18sign_priority\3Ë\a\nsigns\2\18todo-comments\nsetup\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: mini.nvim
time([[Config for mini.nvim]], true)
try_loadstring("\27LJ\2\në\1\0\0\5\0\t\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\0016\0\4\0'\2\5\0'\3\6\0006\4\a\0009\4\b\4B\0\4\1K\0\1\0\vdelete\18MiniBufremove\aZX\5\tmaps\19mini.bufremove\nsetup\15mini.align\frequire\0", "config", "mini.nvim")
time([[Config for mini.nvim]], false)
-- Config for: nvim-ufo
time([[Config for nvim-ufo]], true)
try_loadstring("\27LJ\2\n%\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\15treesitter\vindentS\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\22provider_selector\1\0\0\0\nsetup\bufo\frequire\0", "config", "nvim-ufo")
time([[Config for nvim-ufo]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nË\v\0\0\14\0\\\0ë\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\1\0B\3\2\0029\3\4\0036\4\0\0'\6\1\0B\4\2\0029\4\4\0049\4\5\0049\4\6\0046\5\a\0\18\a\5\0009\5\b\5B\5\2\2\18\a\5\0009\5\t\5'\b\n\0'\t\v\0B\5\4\2\18\a\5\0009\5\f\5'\b\r\0009\t\14\0025\n\15\0B\5\5\2\18\a\5\0009\5\f\5'\b\16\0009\t\17\0025\n\18\0B\5\5\2\18\a\5\0009\5\f\5'\b\19\0009\t\20\0039\t\21\t5\n\22\0B\5\5\2\18\a\5\0009\5\f\5'\b\23\0009\t\5\0039\t\5\t5\n\24\0B\5\5\2\18\a\5\0009\5\f\5'\b\25\0009\t\26\0025\n\27\0B\5\5\0019\5\28\0005\a4\0006\b\0\0'\n\29\0B\b\2\0029\b\30\b5\n \0005\v\31\0=\v!\n5\v#\0005\f\"\0=\f$\v=\v%\n5\v&\0=\v'\n5\v1\0005\f)\0009\r(\1=\r*\f9\r+\1=\r,\f9\r-\1=\r.\f9\r/\1=\r0\f=\f2\v=\v3\nB\b\2\2=\b5\a5\b9\0005\t7\0005\n6\0=\n8\t=\t\14\b=\b:\a5\bV\0005\t;\0005\nT\0005\v=\0009\f<\4=\f>\v9\f?\4=\f@\v9\fA\4=\fB\v9\fC\4=\fD\v9\fE\4=\fF\v9\fG\4=\fH\v9\f<\4=\f\16\v9\fI\4=\fJ\v9\fK\4=\fL\v9\fM\4=\fN\v9\fO\4=\f\r\v9\fP\4=\fQ\v9\fR\4=\fS\v=\vU\n=\n3\t=\t\5\b5\tW\0004\n\0\0=\nX\t=\t\20\b=\b\4\aB\5\2\0015\5Y\0006\6Z\0\18\b\5\0B\6\2\4X\t\3Ä9\v[\0\18\r\n\0B\v\2\1E\t\3\3R\t˚\127K\0\1\0\19load_extension\vipairs\1\4\0\0\14ui-select\17file_browser\17recent_files\20ignore_patterns\1\0\0\1\0\0\6n\1\0\0\6s\15toggle_all\6h\18toggle_hidden\19toggle_browser\6t\15change_cwd\6w\rgoto_cwd\6e\18goto_home_dir\6M\tmove\6R\vrename\6Y\tcopy\6D\vremove\6C\vcreate\6-\1\0\0\20goto_parent_dir\1\0\3\17initial_mode\vnormal\nquiet\2\17hijack_netrw\2\fpickers\1\0\0\17find_command\1\0\2\vhidden\2\14no_ignore\2\1\4\0\0\arg\f--files\r--hidden\rdefaults\1\0\0\rmappings\6i\1\0\0\n<C-k>\28move_selection_previous\n<C-j>\24move_selection_next\n<C-p>\23cycle_history_prev\n<C-n>\1\0\0\23cycle_history_next\25file_ignore_patterns\1\3\0\0\19node_modules/*\f%.git/*\18layout_config\16bottom_pane\1\0\0\1\0\1\vheight\4≥ÊÃô\3≥ÊÃ˛\3\17path_display\1\0\1\fpreview\1\1\0\1\rtruncate\3\2\fget_ivy\21telescope.themes\nsetup\1\0\1\tdesc\vResume\vresume\6p\1\0\1\tdesc\17Browse files\6b\1\0\1\tdesc\17Recent files\tpick\17recent_files\6r\1\0\1\tdesc\15Grep files\14live_grep\6g\1\0\1\tdesc\15Find files\15find_files\6f\bset\n+file\14<leader>f\vprefix\bnew\bmap\factions\17file_browser\15extensions\22telescope.builtin\22telescope.actions\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÎ\5\0\0\6\0\28\0'6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\1'\2\5\0=\2\4\0016\1\2\0009\1\3\1'\2\a\0=\2\6\0016\1\2\0009\1\3\1)\2\20\0=\2\b\0019\1\t\0005\3\v\0005\4\n\0=\4\f\0035\4\r\0005\5\14\0=\5\15\0045\5\16\0=\5\17\4=\4\18\0035\4\19\0005\5\20\0=\5\15\4=\4\21\0035\4\22\0=\4\23\0035\4\24\0004\5\0\0=\5\15\0045\5\25\0=\5\26\4=\4\27\3B\1\2\1K\0\1\0\15playground\16keybindings\1\0\n\28toggle_language_display\6I\27toggle_anonymous_nodes\6a\30toggle_injected_languages\6t\21toggle_hl_groups\6i\24toggle_query_editor\6o\14show_help\6?\14goto_node\t<cr>\21unfocus_language\6F\19focus_language\6f\vupdate\6R\1\0\3\15updatetime\3\25\venable\2\20persist_queries\1\14autopairs\1\0\1\venable\2\vindent\1\2\0\0\vpython\1\0\1\venable\2\14highlight&additional_vim_regex_highlighting\1\2\0\0\borg\fdisable\1\2\0\0\thtml\1\0\1\venable\2\21ensure_installed\1\0\0\1\f\0\0\bcpp\vpython\tjson\trust\tjava\blua\thtml\nlatex\tnorg\14norg_meta\rmarkdown\nsetup\14foldlevel\texpr\15foldmethod\31nvim_treesitter#foldexpr()\rfoldexpr\6o\bvim\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd null-ls.nvim ]]

-- Config for: null-ls.nvim
try_loadstring("\27LJ\2\n∏\4\0\0\f\0\"\0>6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0016\3\0\0'\5\4\0B\3\2\0029\4\5\3B\4\1\0016\4\6\0\18\6\4\0009\4\a\4B\4\2\2\18\6\4\0009\4\b\4'\a\t\0006\b\n\0009\b\v\b9\b\f\bB\4\4\0019\4\5\0005\6\r\0009\a\14\3=\a\14\0064\a\f\0009\b\15\0019\b\16\b>\b\1\a9\b\17\2>\b\2\a9\b\18\2>\b\3\a9\b\19\0029\b\20\b5\n\22\0005\v\21\0=\v\23\nB\b\2\2>\b\4\a9\b\24\0029\b\20\b5\n\26\0005\v\25\0=\v\23\nB\b\2\2>\b\5\a9\b\27\2>\b\6\a9\b\28\2>\b\a\a9\b\29\2>\b\b\a9\b\30\2>\b\t\a9\b\31\2>\b\n\a9\b \2>\b\v\a=\a!\6B\4\2\1K\0\1\0\fsources\20trim_whitespace\vfnlfmt\ntaplo\16latexindent\nblack\17clang_format\1\0\0\1\4\0\0\tjson\15javascript\tyaml\14prettierd\14filetypes\1\0\0\1\2\0\0\tjava\twith\rprettier\17markdownlint\vstylua\rgitsigns\17code_actions\14on_attach\1\0\1\20default_timeout\3à'\17FormatToggle\bcmd\bvim\15<leader>tf\bset\bnew\bmap\nsetup\15lsp-format\15formatting\rbuiltins\fnull-ls\frequire\0", "config", "null-ls.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Skeletor lua require("packer.load")({'skeletor.nvim'}, { cmd = "Skeletor", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim', 'mkdnflow.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType norg ++once lua require("packer.load")({'neorg'}, { ft = "norg" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/danilshvalov/.local/share/nvim/site/pack/packer/opt/neorg/ftdetect/norg.vim]], true)
vim.cmd [[source /Users/danilshvalov/.local/share/nvim/site/pack/packer/opt/neorg/ftdetect/norg.vim]]
time([[Sourcing ftdetect script at: /Users/danilshvalov/.local/share/nvim/site/pack/packer/opt/neorg/ftdetect/norg.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
