-- must be first require
pcall(require, "impatient")
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
vim.o.ttimeoutlen = 10

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

if not pcall(require, "packer") then
  print("Downloading packer.nvim...")
  print(vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim",
  }))
end

local packer = require("packer")

packer.add({
  "danilshvalov/keymap.nvim",
})

require("keymap").setup()
_G.map = require("keymap").map
map:new():set("<Space>", "<Leader>", { remap = true })
map:new():set("<C-g>", "2<C-g>")
map:new():ft("help"):set("q", vim.cmd.bd)

packer.add({
  "wbthomason/packer.nvim",
  branch = "main",
  config = function()
    local actions = require("packer.actions")
    map
      :new()
      :prefix("<leader>p", "+packer")
      :set("c", actions.clean, { desc = "Remove unused packages" })
      :set("i", actions.install, { desc = "Install packages" })
      :set("u", actions.update, { desc = "Update packages" })
  end,
})

packer.add({
  "ggandor/leap.nvim",
  config = function()
    require("leap").add_default_mappings()
  end,
})

packer.add({
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig/util")

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    local disable_format = function(client)
      local caps = client.server_capabilities
      caps.document_formatting = false
      caps.document_range_formatting = false
      caps.documentFormattingProvider = false
    end

    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = false,
    })

    local caps = vim.lsp.protocol.make_client_capabilities()
    caps.offsetEncoding = { "utf-16" }
    lspconfig.clangd.setup({
      cmd = {
        "clangd",
        "--background-index",
        "--compile-commands-dir",
        "build",
      },
      init_options = { compilationDatabasePath = "build" },
      root_dir = util.root_pattern("build/compile_commands.json"),
      capabilities = caps,
      on_attach = disable_format,
    })

    lspconfig.texlab.setup({ on_attach = disable_format })
    lspconfig.clojure_lsp.setup({})
    lspconfig.cmake.setup({ on_attach = disable_format })
    lspconfig.jdtls.setup({
      root_dir = util.root_pattern(".git", "pom.xml"),
      on_attach = disable_format,
    })
    lspconfig.pyright.setup({
      root_dir = util.root_pattern(".git"),
    })

    lspconfig.sumneko_lua.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "kit", "neorg" },
          },
        },
      },
    })

    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            enabled = true,
            command = "clippy",
          },
        },
      },
    })

    lspconfig.marksman.setup({})
  end,
})

packer.add({
  "nvim-telescope/telescope.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "smartpde/telescope-recent-files",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local ext = require("telescope").extensions
    local fb_actions = require("telescope").extensions.file_browser.actions

    map
      :new()
      :prefix("<leader>f", "+file")
      :set("f", builtin.find_files, { desc = "Find files" })
      :set("g", builtin.live_grep, { desc = "Grep files" })
      :set("r", ext.recent_files.pick, { desc = "Recent files" })
      :set("b", ext.file_browser.file_browser, { desc = "Browse files" })
      :set("p", builtin.resume, { desc = "Resume" })

    telescope.setup({
      defaults = require("telescope.themes").get_ivy({
        path_display = { truncate = 2 },
        preview = false,
        layout_config = {
          bottom_pane = {
            height = 0.3,
          },
        },
        file_ignore_patterns = { "node_modules/*", "%.git/*", "build/*" },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      }),
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden" },
          hidden = true,
          no_ignore = true,
        },
      },
      extensions = {
        file_browser = {
          initial_mode = "normal",
          hijack_netrw = true,
          quiet = true,
          mappings = {
            n = {
              ["-"] = fb_actions.goto_parent_dir,
              C = fb_actions.create,
              D = fb_actions.remove,
              Y = fb_actions.copy,
              R = fb_actions.rename,
              M = fb_actions.move,
              g = fb_actions.goto_parent_dir,
              e = fb_actions.goto_home_dir,
              w = fb_actions.goto_cwd,
              t = fb_actions.change_cwd,
              f = fb_actions.toggle_browser,
              h = fb_actions.toggle_hidden,
              s = fb_actions.toggle_all,
            },
          },
        },
        recent_files = {
          ignore_patterns = {},
        },
      },
    })

    local exts = {
      "ui-select",
      "file_browser",
      "recent_files",
    }

    for _, ext_name in ipairs(exts) do
      telescope.load_extension(ext_name)
    end
  end,
})

packer.add({
  "nvim-treesitter/nvim-treesitter",
  requires = "nvim-treesitter/playground",
  run = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    vim.o.foldmethod = "expr"
    vim.o.foldlevel = 20

    treesitter.setup({
      ensure_installed = {
        "cpp",
        "python",
        "json",
        "rust",
        "java",
        "lua",
        "html",
        "latex",
        "norg",
        -- "norg_meta",
        "markdown",
      },
      highlight = {
        enable = true,
        disable = { "html" },
        additional_vim_regex_highlighting = { "org" },
      },
      indent = {
        enable = true,
        disable = { "python" },
      },
      autopairs = {
        enable = true,
      },

      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    })
  end,
})

packer.add({
  "nvim-neorg/neorg",
  ft = "norg",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter",
  },
  after = "nvim-treesitter",
  config = function()
    map:new():prefix("<leader>n", "+norg"):ft("norg"):set("t", "<Cmd>Neorg tangle current-file<CR>")

    setup("neorg", {
      load = {
        ["core.defaults"] = {},
        ["core.norg.esupports.indent"] = {
          ["config"] = {
            ["indents"] = {
              ["heading1"] = {
                indent = 0,
              },
              ["heading2"] = {
                indent = 0,
              },
              ["heading3"] = {
                indent = 0,
              },
              ["heading4"] = {
                indent = 0,
              },
              ["heading5"] = {
                indent = 0,
              },
              ["heading6"] = {
                indent = 0,
              },
            },
            ["modifiers"] = {
              ["under-headings"] = function()
                return 0
              end,
            },
          },
        },
        ["core.norg.qol.toc"] = {},
        ["core.norg.dirman"] = {
          ["config"] = {
            ["workspaces"] = {
              defaults = "~/.notes",
            },
            autochdir = true,
            index = "index.norg",
          },
        },
        ["core.gtd.base"] = {
          ["config"] = {
            workspace = "defaults",
          },
        },
        ["core.presenter"] = {
          ["config"] = {
            zen_mode = "zen-mode",
          },
        },
        ["core.norg.completion"] = {
          ["config"] = {
            engine = "nvim-cmp",
          },
        },
        ["core.export"] = {},
        ["core.export.markdown"] = {
          ["config"] = {
            extensions = "all",
          },
        },
      },
    })

    local function source_norg()
      local ts = require("nvim-treesitter.ts_utils")
      local ts_neorg = neorg.modules.get_module("core.integrations.treesitter")

      local node = ts.get_node_at_cursor(0, true)
      local p = ts_neorg.find_parent(node, "^ranged_tag$")

      local code_block = ts_neorg.get_tag_info(p, true)
      if not code_block then
        vim.notify("Not inside a code block!")
        return
      end

      if code_block.name == "code" then
        code_block["parameters"] = vim.split(code_block["parameters"][1], " ")
        local ft = code_block.parameters[1]

        if ft ~= "lua" then
          return
        end

        local content = table.concat(code_block.content, "\n")

        local fn, err = load(content)
        if fn then
          fn()
        else
          print(err)
        end
      end
    end

    map:new():set("<leader>ne", source_norg)
  end,
})

packer.add({
  "jose-elias-alvarez/null-ls.nvim",
  after = "nvim-cmp",
  requires = { "nvim-lua/plenary.nvim", "lukas-reineke/lsp-format.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local builtins = null_ls.builtins
    local formatting = builtins.formatting

    local lsp_format = require("lsp-format")

    lsp_format.setup()
    map:new():set("<leader>tf", vim.cmd.FormatToggle)

    null_ls.setup({
      default_timeout = 5000,
      on_attach = lsp_format.on_attach,
      sources = {
        builtins.code_actions.gitsigns,
        formatting.stylua,
        formatting.markdownlint,
        formatting.prettier.with({ filetypes = { "java" } }),
        formatting.prettierd.with({
          filetypes = { "json", "javascript", "yaml" },
        }),
        formatting.clang_format,
        formatting.black,
        formatting.latexindent,
        formatting.taplo,
        formatting.fnlfmt,
        formatting.trim_whitespace,
      },
    })
  end,
})

packer.add({
  "numToStr/Comment.nvim",
  config = function()
    setup("Comment", {
      ignore = "^$",
      pre_hook = function()
        local Config = require("Comment.config"):get()

        if vim.bo.filetype == "norg" then
          Config.padding = false
          return "+%s+"
        end

        Config.padding = true
      end,
    })
  end,
})

packer.add({
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({
      style = "night",
      on_highlights = function(hl, c)
        hl.WinSeparator.fg = c.yellow
        hl.Comment.fg = c.dark5
      end,
    })
    vim.cmd.colorscheme("tokyonight-night")
  end,
})

packer.add({
  "nvim-lualine/lualine.nvim",
  requires = "folke/tokyonight.nvim",
  config = function()
    local lualine = require("lualine")

    local line_sections = {
      lualine_a = {
        {
          function()
            return " "
          end,
          padding = { right = 0 },
        },
      },
      lualine_b = { "mode" },
      lualine_c = {
        {
          function()
            return vim.o.iminsert == 1 and "ru" or "en"
          end,
          icon = "",
        },
        { "branch", icon = "" },
        "diagnostics",
        function()
          return "%="
        end,
        { "filename", file_status = true, path = 0 },
      },
      lualine_x = {
        {
          function()
            return vim.bo.shiftwidth
          end,
          icon = "הּ",
        },
        { "filetype" },
      },
      lualine_y = { "location" },

      lualine_z = {
        {
          function()
            return " "
          end,
          padding = { left = 0 },
        },
      },
    }

    vim.o.showmode = false

    lualine.setup({
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = "",
        section_separators = "",
      },
      sections = line_sections,
      tabline = {
        lualine_a = { "tabs" },
      },
    })

    vim.defer_fn(function()
      vim.o.showtabline = 1
    end, 0)

    kit.autocmd({
      "WinEnter",
      "BufEnter",
      "SessionLoadPost",
      "FileChangedShellPost",
      "VimResized",
      "Filetype",
      "CursorMoved",
      "CursorMovedI",
    }, {
      callback = function()
        vim.o.showtabline = 1
      end,
    })
  end,
})

packer.add({
  "danilshvalov/skeletor.nvim",
  cmd = "Skeletor",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    local skeletor = require("skeletor")
    local Job = require("plenary.job")

    skeletor.setup({
      templates = {
        substitutions = {},
      },
    })

    skeletor.define_template("latex", {
      title = "Latex math",
      substitutions = {
        ["__FILE-NAME__"] = "notes",
      },
    })

    skeletor.define_template("cpp-cmake", {
      title = "C++ CMake",
      substitutions = {
        ["__PROJECT-NAME__"] = function()
          return skeletor.read_input("Project name: ")
        end,
        ["__CMAKE-VERSION__"] = function()
          local lines = Job:new({ command = "cmake", args = { "--version" } }):sync()
          return lines[1]:match("(%d%d?%.%d%d?)")
        end,
      },
      after_creation = function(opts)
        Job:new({
          command = "cmake",
          args = {
            "-S",
            opts.cwd,
            "-B",
            opts.cwd .. "/build",
            "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
          },
          cwd = opts.cwd,
        }):start()
      end,
    })

    skeletor.define_template("cpp-conan", {
      title = "C++ Conan",
      substitutions = {
        ["__PROJECT-NAME__"] = function()
          return skeletor.read_input("Project name: ")
        end,
        ["__CMAKE-VERSION__"] = function()
          local lines = Job:new({ command = "cmake", args = { "--version" } }):sync()
          return lines[1]:match("(%d%d?%.%d%d?)")
        end,
      },
      after_creation = function(opts)
        Job:new({
          command = "cmake",
          args = {
            "-S",
            opts.cwd,
            "-B",
            opts.cwd .. "/build",
            "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
          },
          cwd = opts.cwd,
        }):start()
      end,
    })

    skeletor.define_template("nvim-plugin", {
      title = "Neovim plugin",
      license = "MIT",
      substitutions = {
        ["__USER-NAME__"] = "Tomas Anderson",
        ["__PROJECT-NAME__"] = function()
          return skeletor.read_input("Project name: ")
        end,
        ["__DATETIME__"] = function()
          return vim.fn.strftime("%Y-%m-%d_%H:%M:%S")
        end,
      },
      after_creation = function()
        vim.notify("Hello World!")
      end,
    })
  end,
})

packer.add({
  "hrsh7th/nvim-cmp",
  requires = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },
  after = "luasnip",
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local icons = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "⌘",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "廓",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }

    local mappings = {
      ["<C-n>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c", "s" }),
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c", "s" }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping({
        i = function(fallback)
          if cmp.get_selected_entry() then
            cmp.confirm()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end,
        s = function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end,
      }),
      ["<S-Tab>"] = cmp.mapping({
        i = function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
        s = function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
      }),
    }

    local sources = {
      "buffer",
      "path",
      "nvim_lsp",
      "nvim_lsp_signature_help",
      "neorg",
      "luasnip",
      "orgmode",
    }

    local priorities = {}

    for index, value in ipairs(sources) do
      priorities[index] = { name = value, priority = index }
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          return luasnip.lsp_expand(args.body)
        end,
      },
      mapping = mappings,
      sources = priorities,
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, vim_item)
          vim_item.menu = vim_item.kind
          vim_item.kind = icons[vim_item.kind]
          return vim_item
        end,
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
    })
  end,
})
packer.add({
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")

    wk.setup({
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
    })

    map
      :new({ mode = "nvo" })
      :set("H", "^", { desc = "Start of line" })
      :set("L", "$", { desc = "End of line" })

    map
      :new({ mode = "nv", expr = true })
      :set("k", "(v:count? 'k' : 'gk')")
      :set("j", "(v:count? 'j' : 'gj')")

    map
      :new()
      :prefix("<leader>o", "+open")
      :set("f", kit.wrap(vim.fn.system, "open ."), { desc = "Open in finder" })

    map
      :new()
      :prefix("<leader>d", "+dir")
      :set("c", kit.wrap(vim.cmd.cd, "%:p:h"), { desc = "Set cwd to current file directory" })
      :set("y", function()
        vim.fn.setreg("+", vim.fn.expand("%:p:h"))
      end, { desc = "Yank cwd" })

    wk.register({
      t = {
        v = { "<Cmd>Neorg gtd views<CR>", "GTD views" },
        c = { "<Cmd>Neorg gtd capture<CR>", "GTD capture" },
        e = { "<Cmd>Neorg gtd edit<CR>", "GTD edit" },
      },
    }, { prefix = "<leader>" })

    map:new():set("<Esc>", vim.cmd.noh)
  end,
})
packer.add({
  "L3MON4D3/LuaSnip",
  requires = "saadparwaiz1/cmp_luasnip",
  config = function()
    local ls = require("luasnip")
    local snipmate_load = require("luasnip.loaders.from_snipmate").load

    local load_snippets = function()
      snipmate_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
    end

    kit.create_cmd("ReloadSnippets", function()
      ls.cleanup()
      load_snippets()
    end)

    ls.config.setup({
      update_events = "InsertLeave,TextChanged,TextChangedI",
      region_check_events = "CursorMoved,CursorHold,InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
      store_selection_keys = "<Tab>",
      ft_func = function(...)
        local ft = require("luasnip.extras.filetype_functions").from_cursor_pos(...)
        if #ft ~= 0 then
          return ft
        end
        return vim.split(vim.bo.filetype, ".", true)
      end,
    })

    load_snippets()
  end,
})
packer.add({
  "windwp/nvim-autopairs",
  config = function()
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    local ignore_regexp = "[%w%.А-Я%а-яЁё%(%[%{%'%\"]"

    npairs.setup({
      enable_check_bracket_line = false,
      fast_wrap = {
        map = "<A-x>",
        pattern = string.gsub("[%'%\"%)%>%]%)%}%%s%^]", "%s+", ""),
      },
      ignored_next_char = string.gsub(ignore_regexp, "%s+", ""),
      disable_filetype = {},
    })

    npairs.add_rule(Rule("/*", "*/"))
    npairs.add_rule(Rule('r#"', '"#', "rust"))
    npairs.add_rule(Rule("\\{", "\\}"))
    npairs.add_rule(Rule("\\(", "\\)"))
    npairs.add_rule(Rule("\\[", "\\]"))

    npairs.add_rule(Rule("{", "};", "cpp"):with_pair(function(opts)
      return opts.line:match("struct%s+") ~= nil or opts.line:match("class%s+") ~= nil
    end))

    npairs.add_rule(Rule("<", ">", "cpp"):with_pair(function(opts)
      return opts.text:sub(opts.col - 1):match("[%w%d]+<") ~= nil
    end))

    local big_pairs = {
      { "[", "]" },
      { "{", "}" },
      { "(", ")" },
      { "|", "|" },
    }

    local big_kinds = { "big", "bigg", "Big", "Bigg" }

    for _, kind in ipairs(big_kinds) do
      for _, pair in pairs(big_pairs) do
        npairs.add_rule(
          Rule(
            string.format("\\%s%s", kind, pair[1]),
            string.format("\\%s%s", kind, pair[2]),
            "tex"
          )
        )
      end
    end
  end,
})
packer.add({ "lewis6991/impatient.nvim" })
packer.add({
  "dstein64/vim-startuptime",
  config = function()
    map:new():ft("startuptime"):set("q", vim.cmd.bd)
  end,
})
packer.add({
  "williamboman/mason.nvim",
  config = function()
    setup("mason")
  end,
})
packer.add({
  "williamboman/mason-lspconfig.nvim",
  config = function()
    setup("mason-lspconfig", {
      ensure_installed = {
        "clangd",
        "jdtls",
        "rust_analyzer",
        "sumneko_lua",
        "texlab",
        "pyright",
        "cmake",
        "marksman",
      },
      automatic_installation = false,
    })
  end,
})
packer.add({
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    local trouble = require("trouble")
    trouble.setup()

    map:new():set("<leader>xx", trouble.toggle, { desc = "Show code errors" })

    local open = function(name)
      return kit.wrap(trouble.open, name)
    end

    map
      :new({ prefix = "<leader>c" })
      :set("r", vim.lsp.buf.rename)
      :set("h", vim.diagnostic.open_float)
      :set("a", vim.lsp.buf.code_action)

    map
      :new()
      :prefix("g", "+goto")
      :set("d", open("lsp_definitions"), { desc = "Go definitions" })
      :set("D", vim.lsp.buf.declaration, { desc = "Go declaration" })
      :set("r", open("lsp_references"), { desc = "Go references" })
      :set("i", open("lsp_implementations"), { desc = "Go implementations" })
  end,
})
packer.add({
  "lewis6991/gitsigns.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    local gs = require("gitsigns")
    gs.setup({
      signs = {
        add = {
          hl = "GitSignsAdd",
          text = "│",
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
        change = {
          hl = "GitSignsChange",
          text = "│",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = {
          hl = "GitSignsDelete",
          text = "│",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = "│",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = "│",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        untracked = {
          hl = "GitSignsAdd",
          text = "│",
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
      },
    })

    local actions = require("gitsigns.actions")
    local cache = require("gitsigns.cache").cache
    local hunks = require("gitsigns.hunks")
    local manager = require("gitsigns.manager")

    local ns_id = vim.api.nvim_create_namespace("gitsigns_preview_inline")

    actions.preview_hunk_inline = function()
      local bufnr = vim.api.nvim_get_current_buf()

      local lnum = vim.api.nvim_win_get_cursor(0)[1]
      local hunk = hunks.find_hunk(lnum, cache[bufnr].hunks)

      if not hunk then
        return
      end

      manager.show_added(bufnr, ns_id, hunk)
      manager.show_deleted(bufnr, ns_id, hunk)
    end

    map
      :new({ prefix = "<leader>g" })
      :set("p", gs.prev_hunk, { desc = "Previous hunk" })
      :set("n", gs.next_hunk, { desc = "Next hunk" })
      :set("r", gs.reset_hunk, { desc = "Reset hunk" })
      :set("s", gs.stage_hunk, { desc = "Stage hunk" })
      :set("h", gs.preview_hunk_inline, { desc = "Preview hunk" })
      :set("c", function()
        vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
      end, { desc = "Clear hunk preview" })
  end,
})
packer.add({
  "akinsho/git-conflict.nvim",
  config = function()
    setup("git-conflict")
  end,
})
packer.add({
  "folke/neodev.nvim",
  config = function()
    require("neodev").setup()
  end,
})
packer.add({
  "windwp/nvim-ts-autotag",
  config = function()
    setup("nvim-ts-autotag")
  end,
})
packer.add({ "aklt/plantuml-syntax" })
packer.add({
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    setup("todo-comments", {
      signs = true,
      sign_priority = 1000,
      gui_style = {
        fg = "BOLD",
      },
      highlight = {
        comments_only = false,
        before = "",
        keyword = "fg",
        after = "",
        pattern = [[.*<(KEYWORDS)\s*]],
        exclude = { "log", "org" },
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    })

    kit.set_hl("Todo", { fg = "NONE", bg = "NONE" })
  end,
})
packer.add({
  "NvChad/nvim-colorizer.lua",
  config = function()
    setup("colorizer")
  end,
})
packer.add({
  "danymat/neogen",
  requires = "nvim-treesitter/nvim-treesitter",
  config = function()
    local neogen = require("neogen")
    neogen.setup({})

    map
      :new()
      :prefix("<leader>c", "+code")
      :set("g", neogen.generate, { desc = "Generate documentation" })
  end,
})
packer.add({
  "AckslD/nvim-FeMaco.lua",
  config = function()
    local femaco = require("femaco")
    local edit_code_block = require("femaco.edit").edit_code_block

    femaco.setup({
      prepare_buffer = function()
        vim.cmd.split()
        local buf = vim.api.nvim_create_buf(false, false)
        vim.api.nvim_win_set_buf(0, buf)
        return buf
      end,
      ensure_newline = function(base_filetype)
        return base_filetype == "norg" or base_filetype == "markdown"
      end,
    })

    map:new():prefix("<leader>c", "+code"):set("e", edit_code_block, { desc = "Edit code block" })
  end,
})
packer.add({
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  run = function()
    vim.fn["mkdp#util#install"]()
  end,
})
packer.add({
  "akinsho/toggleterm.nvim",
  config = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup({
      autochdir = true,
    })

    map
      :new()
      :prefix("<leader>t", "+toggle")
      :set("t", function()
        toggleterm.toggle(vim.v.count, nil, nil, "horizontal")
      end)
      :set("T", function()
        toggleterm.toggle(vim.v.count, nil, nil, "tab")
      end)

    map:new():mode("t"):set("<Esc><Esc>", "<C-\\><C-n>")
  end,
})
packer.add({
  "kylechui/nvim-surround",
  config = function()
    local get_input = function(prompt, default)
      local ok, result =
        pcall(vim.fn.input, { prompt = prompt, default = default, cancelreturn = vim.NIL })
      if ok and result ~= vim.NIL then
        return result
      end
    end

    local utils = require("nvim-surround.config")

    local find_env = function()
      local poses = utils.get_selections({
        char = "e",
        pattern = "\\begin{(%w-)}().-\\end{(%w-)}()",
      })

      poses.left.first_pos[2] = poses.left.first_pos[2] - 1
      poses.left.last_pos[2] = poses.left.last_pos[2] - 1
      poses.right.first_pos[2] = poses.right.first_pos[2] - 1
      poses.right.last_pos[2] = poses.right.last_pos[2] - 1

      return poses
    end

    require("nvim-surround").setup({
      surrounds = {
        ["e"] = {
          find = "\\begin{%w-}.-\\end{%w-}",
          change = {
            target = find_env,
            replacement = function()
              local element = get_input("New environment: ")
              if element then
                return { { element }, { element } }
              end
            end,
          },
        },
      },
    })
  end,
})
packer.add({
  "kevinhwang91/nvim-ufo",
  requires = "kevinhwang91/promise-async",
  config = function()
    require("ufo").setup({
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    })
  end,
})
packer.add({
  "echasnovski/mini.nvim",
  config = function()
    require("mini.align").setup()
  end,
})

packer.add({
  "famiu/bufdelete.nvim",
  config = function()
    local bd = require("bufdelete")

    map:new():set("ZX", kit.wrap(bd.bufdelete, 0))
    map:new():set("ZC", kit.wrap(bd.bufdelete, 0, true))
  end,
})

packer.add({
  "jakewvincent/mkdnflow.nvim",
  rocks = "luautf8",
  ft = "markdown",
  config = function()
    require("mkdnflow").setup({})
  end,
})

packer.add({
  "ThePrimeagen/harpoon",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("harpoon").setup()
    require("telescope").load_extension("harpoon")

    map
      :new()
      :prefix("<leader>m", "+mark")
      :set("a", function()
        require("harpoon.mark").add_file()
        vim.notify("Mark added")
      end, { desc = "Add mark" })
      :set("n", require("harpoon.ui").nav_next, { desc = "Next mark" })
      :set("p", require("harpoon.ui").nav_prev, { desc = "Previous mark" })
      :set("f", require("telescope").extensions.harpoon.marks, { desc = "Find mark" })
  end,
})

vim.o.spell = true
vim.o.spelllang = "en,ru"
vim.o.spellcapcheck = ""
vim.o.spelloptions = "camel"
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
    if node:type() == "enum_item" or node:type() == "generic_environment" then
      local cur_line = vim.fn.getline(".")
      if #cur_line:gsub("^%s*", "", 1) ~= 0 then
        vim.fn.append(vim.fn.line("."), string.rep(" ", vim.fn.indent(".")))
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
        cur_line = vim.fn.getline(vim.fn.line("."))
      end
      set_current_line(cur_line .. "\\item ")
      break
    end
    node = node:parent()
  end
end

map:new():mode("i"):set("<M-CR>", insert_item)

kit.create_cmd("Open", function(opts)
  kit.open_file(string.format('"%s"', vim.fn.expand(opts.args)))
end, {
  nargs = "?",
  complete = "file",
})

kit.autocmd("BufWinEnter", {
  pattern = { "*.pdf", "*.png", "*.jpg" },
  callback = function()
    kit.open_file("%")
    MiniBufremove.delete()
  end,
})

vim.o.keymap = "russian-jcukenwin"
vim.o.iminsert = 0

vim.keymap.set("", "<C-Space>", function()
  if vim.o.iminsert == 0 then
    vim.o.iminsert = 1
  else
    vim.o.iminsert = 0
  end
end)

map:new({ mode = "ic" }):set("<C-Space>", "<C-^>")

kit.open_file = function(path)
  vim.fn.system("open " .. vim.fn.expand(path))
end

kit.call_at_ft("lua", function()
  vim.o.shiftwidth = 2
  vim.o.tabstop = 2
  vim.o.softtabstop = 2
end)

kit.call_at_ft("tex", function()
  vim.o.concealcursor = "ni"
end)

kit.autocmd("BufWritePre", {
  group = kit.augroup("Mkdir"),
  callback = function(opts)
    if vim.bo.filetype == "NeogitCommitMessage" then
      return
    end

    local path = opts.match
    local dir = vim.fn.fnamemodify(opts.match, ":p:h")

    if vim.fn.isdirectory(dir) ~= 0 then
      vim.cmd.write(path)
      vim.cmd("silent doautocmd BufWritePost")
      return
    end

    local prompt = string.format("Directory '%s' does not exists; create? [Y/n]: ", dir)

    vim.notify(prompt)

    local answer = vim.fn.nr2char(vim.fn.getchar())

    if answer:lower() == "y" or answer == "\r" then
      vim.fn.mkdir(dir, "p")
      vim.cmd.write(path)
      vim.cmd("silent doautocmd BufWritePost")
    end
  end,
})

vim.o.diffopt = "internal,filler,closeoff,linematch:60,horizontal,foldcolumn:0"

vim.opt.fillchars:append("diff: ")
