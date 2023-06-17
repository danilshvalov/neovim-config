-- NOTE: remove after neovim 0.10 release
if not vim.fs.joinpath then
  function vim.fs.joinpath(...)
    return (table.concat({ ... }, "/"):gsub("//+", "/"))
  end
end

return {
  {
    "danilshvalov/keymap.nvim",
    priority = 1000,
    lazy = false,
    init = function()
      map:ft("help"):set("q", vim.cmd.bd)
      map:set("<Space>", "<Leader>", { remap = true })
      map:set("<C-g>", "2<C-g>")

      map
        :mode("nvo")
        :set("H", "^", { desc = "Start of line" })
        :set("L", "$", { desc = "End of line" })

      map:prefix("<leader>t", "+toggle"):set("w", function()
        vim.wo.wrap = not vim.wo.wrap
      end, { desc = "Toggle wrap" })

      map
        :new({ mode = "nv", expr = true })
        :set("k", "(v:count? 'k' : 'gk')")
        :set("j", "(v:count? 'j' : 'gj')")

      map
        :prefix("<leader>o", "+open")
        :set("f", kit.wrap(vim.fn.system, "open ."), { desc = "Open in finder" })

      map
        :prefix("<leader>d", "+dir")
        :set("c", kit.wrap(vim.cmd.cd, "%:p:h"), { desc = "Set cwd to current file directory" })
        :set("y", function()
          vim.fn.setreg("+", vim.fn.expand("%:p:h"))
        end, { desc = "Yank cwd" })

      map:set("<Esc>", vim.cmd.noh)
    end,
  },
  {
    "willothy/flatten.nvim",
    lazy = false,
    priority = 1001,
    config = function()
      require("flatten").setup({
        window = {
          open = "alternate",
          focus = "first",
        },
      })
    end,
  },
  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 10000,
    config = function()
      local langmapper = require("langmapper")
      langmapper.setup({
        hack_keymap = true,
      })
      langmapper.hack_get_keymap()

      vim.cmd.cabbrev("ц w")
      vim.cmd.cabbrev("й q")
      vim.cmd.cabbrev("цй wq")

      local function escape(str)
        local escape_chars = [[;,."|\]]
        return vim.fn.escape(str, escape_chars)
      end

      local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
      local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
      local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
      local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

      vim.opt.langmap = vim.fn.join({
        escape(ru_shift) .. ";" .. escape(en_shift),
        escape(ru) .. ";" .. escape(en),
      }, ",")

      map:set("Y", "y$")
    end,
  },
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    config = function()
      require("leap.util")["get-input"] = function()
        local ok, ch = pcall(vim.fn.getcharstr)
        if ok and ch ~= vim.api.nvim_replace_termcodes("<esc>", true, false, true) then
          return require("langmapper.utils").translate_keycode(ch, "default", "ru")
        end
      end

      map:mode("nvo"):set("s", function()
        require("leap").leap({ target_windows = { vim.fn.win_getid() } })
      end)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = "mfussenegger/nvim-jdtls",
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig/util")

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
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
          "--compile-commands-dir=build",
          "--query-driver=*gcc*",
          "-j=8",
          "--completion-style=detailed",
          "--clang-tidy",
          "--all-scopes-completion",
        },
        -- init_options = { compilationDatabasePath = "build" },
        -- root_dir = util.root_pattern("build/compile_commands.json"),
        capabilities = caps,
        on_attach = disable_format,
      })

      lspconfig.csharp_ls.setup({ on_attach = disable_format })

      lspconfig.texlab.setup({ on_attach = disable_format })
      lspconfig.clojure_lsp.setup({})
      lspconfig.cmake.setup({ on_attach = disable_format })
      -- lspconfig.jdtls.setup({
      --   root_dir = util.root_pattern(".git", "pom.xml", "settings.gradle"),
      --   on_attach = disable_format,
      -- })
      lspconfig.pyright.setup({
        root_dir = util.root_pattern(".git"),
      })

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim", "kit" },
            },
            telemetry = {
              enable = false,
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
      lspconfig.sqlls.setup({})
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
        color_icons = true,
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "smartpde/telescope-recent-files",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      local ext = require("telescope").extensions

      -- map
      --   :prefix("<leader>f", "+file")
      --   :set("f", builtin.find_files, { desc = "Find files" })
      --   :set("g", builtin.live_grep, { desc = "Grep files" })
      --   :set("r", ext.recent_files.pick, { desc = "Recent files" })
      --   -- :set("b", ext.file_browser.file_browser, { desc = "Browse files" })
      --   :set(
      --     "p",
      --     builtin.resume,
      --     { desc = "Resume" }
      --   )

      telescope.setup({
        defaults = require("telescope.themes").get_ivy({
          path_display = { truncate = 2 },
          preview = false,
          layout_config = {
            bottom_pane = {
              height = 0.3,
            },
          },
          file_ignore_patterns = {
            "node_modules/*",
            "%.git/*",
            "^build.*/",
            "^third_party",
            "^%.cache/",
            "%.pgdata/*",
            "%.ccache/*",
            ".*%.o$",
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-f>"] = actions.to_fuzzy_refine,
            },
          },
        }),
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
          },
          git_status = {
            use_git_root = false,
          },
        },
        extensions = {
          recent_files = {
            ignore_patterns = {},
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      local exts = {
        "ui-select",
        "recent_files",
      }

      for _, ext_name in ipairs(exts) do
        telescope.load_extension(ext_name)
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "nvim-treesitter/playground",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      local treesitter = require("nvim-treesitter.configs")

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.doxygen = {
        install_info = {
          url = "~/projects/tree-sitter-doxygen", -- local path or git repo
          files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
          -- optional entries:
          branch = "main", -- default branch in case of git repo if different from master
          generate_requires_npm = false, -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
        },
        -- filetype = "doxygen", -- if filetype does not match the parser name
      }

      -- vim.treesitter.language.register("cpp", "doxygen")

      -- require("nvim-treesitter.indent").comment_parsers.doxygen = true

      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99

      treesitter.setup({
        ensure_installed = {
          "cpp",
          "python",
          "json",
          "http",
          "rust",
          "java",
          "lua",
          "html",
          "latex",
          "org",
          "markdown",
          "markdown_inline",
        },
        highlight = {
          enable = true,
          disable = { "html" },
          additional_vim_regex_highlighting = { "org" },
        },
        indent = {
          enable = true,
          disable = { "python", "cpp", "java" },
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
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "lukas-reineke/lsp-format.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local builtins = null_ls.builtins
      local formatting = builtins.formatting

      local lsp_format = require("lsp-format")

      lsp_format.setup()
      map:set("<leader>tf", vim.cmd.FormatToggle)

      null_ls.setup({
        default_timeout = 5000,
        on_attach = lsp_format.on_attach,
        sources = {
          builtins.code_actions.gitsigns,
          formatting.stylua,
          formatting.markdownlint,
          formatting.prettier.with({ filetypes = { "java" } }),
          formatting.prettierd.with({
            filetypes = { "json", "javascript", "markdown" },
          }),
          formatting.yamlfmt,
          formatting.clang_format,
          formatting.black,
          formatting.latexindent,
          formatting.taplo,
          formatting.fnlfmt,
          formatting.csharpier,
          formatting.trim_whitespace.with({
            disabled_filetypes = { "snippets" },
          }),
          null_ls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "postgres" },
          }),
          formatting.sqlfluff.with({
            extra_args = { "--dialect", "postgres" },
          }),
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local lualine = require("lualine")
      local colors = require("tokyonight.colors").setup()

      local symbols = {
        modified = "**",
        readwrite = "RW",
        readonly = "RO",
      }

      local function modified_color()
        return {
          fg = colors.black,
          bg = vim.bo.modified and colors.yellow or colors.blue,
        }
      end

      local line_sections = {
        lualine_a = {
          {
            function()
              if vim.bo.modified then
                return symbols.modified
              elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                return symbols.readonly
              else
                return symbols.readwrite
              end
            end,
            color = modified_color,
          },
        },
        lualine_b = {},
        lualine_c = {
          { "filename", file_status = false, path = 0 },
          { "branch", icon = "" },
          "diagnostics",
          function()
            -- HACK: disable show tabline when count of tabs less then 2
            vim.o.showtabline = 1
            return ""
          end,
        },
        lualine_x = {
          {
            function()
              return vim.bo.shiftwidth
            end,
            icon = "󰌒",
          },
          { "filetype" },
        },
        lualine_y = {},
        lualine_z = {
          {
            function()
              local line = vim.fn.line(".")
              local col = vim.fn.virtcol(".")
              return string.format("%d:%d", line, col)
            end,
            color = modified_color,
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
    end,
  },
  -- {
  --   "dcampos/nvim-snippy",
  --   dependencies = "dcampos/cmp-snippy",
  -- },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local ls = require("luasnip")

      local icons = {
        Text = "",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰅲",
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
            elseif ls.expand_or_jumpable() then
              ls.expand_or_jump()
            else
              fallback()
            end
          end,
          s = function(fallback)
            if ls.jumpable(1) then
              ls.jump(1)
            else
              fallback()
            end
          end,
        }),
        ["<S-Tab>"] = cmp.mapping({
          i = function(fallback)
            if ls.jumpable(-1) then
              ls.jump(-1)
            else
              fallback()
            end
          end,
          s = function(fallback)
            if ls.jumpable(-1) then
              ls.jump(-1)
            else
              fallback()
            end
          end,
        }),
      }

      local sources = {
        {
          name = "buffer",
          option = {
            keyword_pattern = [[\k\+]],
          },
        },
        {
          name = "path",
          option = {
            trigger_characters = { " ", ".", "#", "-" },
          },
        },
        "nvim_lsp",
        -- "nvim_lsp_signature_help",
        "luasnip",
        "orgmode",
      }

      local priorities = {}

      for index, value in ipairs(sources) do
        if type(value) == "table" then
          value.priority = index
          priorities[index] = value
        else
          priorities[index] = { name = value, priority = index }
        end
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            return ls.lsp_expand(args.body)
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
        completion = {
          keyword_pattern = [[\k\+]],
        },
      })

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
        completion = {
          keyword_pattern = [[\k\+]],
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      local lmu = require("langmapper.utils")
      local view = require("which-key.view")
      local execute = view.execute

      -- wrap `execute()` and translate sequence back
      view.execute = function(prefix_i, mode, buf)
        -- Translate back to English characters
        local new_prefix_i = lmu.translate_keycode(prefix_i, "default", "ru")
        if vim.fn.strchars(new_prefix_i) == vim.fn.strchars(prefix_i) then
          prefix_i = new_prefix_i
        end
        execute(prefix_i, mode, buf)
      end

      local wk = require("which-key")

      wk.setup({
        plugins = {
          spelling = {
            enabled = true,
            suggestions = 10,
          },
        },
        window = {
          border = "single",
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      local cond = require("nvim-autopairs.conds")
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

      npairs.add_rule(Rule('"', "", "tex"))

      npairs.add_rule(Rule("{", "};", "cpp"):with_pair(function(opts)
        return opts.line:match("struct%s+") ~= nil or opts.line:match("class%s+") ~= nil
      end))

      npairs.add_rules({
        Rule("<", ">"):with_pair(cond.before_regex("[%w<]+")):with_move(function(opts)
          return opts.char == ">"
        end),
      })

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
  },
  -- {
  --   "williamboman/mason.nvim",
  --   config = function()
  --     setup("mason")
  --   end,
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   config = function()
  --     setup("mason-lspconfig", {
  --       ensure_installed = {
  --         "clangd",
  --         "jdtls",
  --         "rust_analyzer",
  --         "lua_ls",
  --         "texlab",
  --         "pyright",
  --         "cmake",
  --         "marksman",
  --       },
  --       automatic_installation = false,
  --     })
  --   end,
  -- },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
      local trouble = kit.require_on_exported_call("trouble")

      local open = function(name)
        return kit.wrap(trouble.open, name)
      end

      map
        :prefix("<leader>x")
        :set("q", open("quickfix"))
        :set("x", open("workspace_diagnostics"), { desc = "Show code errors" })

      map
        :new({ prefix = "<leader>c" })
        :set("r", vim.lsp.buf.rename)
        :set("h", vim.diagnostic.open_float)
        :set("a", vim.lsp.buf.code_action)

      map
        :prefix("g", "+goto")
        :set("d", open("lsp_definitions"), { desc = "Go definitions" })
        :set("D", vim.lsp.buf.declaration, { desc = "Go declaration" })
        :set("r", open("lsp_references"), { desc = "Go references" })
        :set("i", open("lsp_implementations"), { desc = "Go implementations" })
        :set("n", vim.diagnostic.goto_next, { desc = "Go next error" })
        :set("p", vim.diagnostic.goto_prev, { desc = "Go prev error" })
    end,
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local gs = require("gitsigns")
      gs.setup({
        signs = {
          add = {
            text = "┃",
          },
          change = {
            text = "┃",
          },
          delete = {
            text = "┃",
          },
          topdelete = {
            text = "┃",
          },
          changedelete = {
            text = "┃",
          },
          untracked = {
            text = "┃",
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
  },
  {
    "akinsho/git-conflict.nvim",
    config = function()
      setup("git-conflict")
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        ft_ignore = { "NvimTree" },
        segments = {
          { text = { builtin.foldfunc } },
          {
            sign = {
              name = { ".*" },
              maxwidth = 1,
              colwidth = 1,
            },
          },
          {
            sign = {
              name = { "Diagnostic" },
              maxwidth = 1,
              colwidth = 2,
            },
          },
          { text = { builtin.lnumfunc } },
          {
            text = {
              " ",
            },
          },
        },
      })
    end,
  },
  {
    "folke/neodev.nvim",
    ft = "lua",
    config = function()
      require("neodev").setup()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "markdown" },
    config = function()
      setup("nvim-ts-autotag")
    end,
  },
  {
    "aklt/plantuml-syntax",
    ft = "plantuml",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      signs = true,
      sign_priority = 1000,
      gui_style = {
        fg = "BOLD",
      },
      highlight = {
        comments_only = false,
        keyword = "fg",
        after = "",
        pattern = [[.*<(KEYWORDS)(\(.*\))?[: ]\s*]],
        exclude = { "log", "org" },
      },
      search = {
        pattern = [[\b(KEYWORDS)(\(.*\))?[: ]\s*]],
      },
    },
  },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      local ccc = require("ccc")

      ccc.setup({
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
      })
    end,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    init = function()
      local neogen = kit.require_on_exported_call("neogen")

      map
        :prefix("<leader>c", "+code")
        :set("g", neogen.generate, { desc = "Generate documentation" })
    end,
    config = function()
      local i = require("neogen.types.template").item

      require("neogen").setup({
        languages = {
          cpp = {
            template = {
              annotation_convention = "custom",
              custom = {
                { nil, "/// @file", { no_results = true, type = { "file" } } },
                {
                  nil,
                  "/// @brief $1",
                  { no_results = true, type = { "func", "file", "class" } },
                },
                { nil, "", { no_results = true, type = { "file" } } },

                { i.ClassName, "/// @class %s", { type = { "class" } } },
                { i.Type, "/// @typedef %s", { type = { "type" } } },
                { nil, "/// @brief $1", { type = { "func", "class", "type" } } },
                { i.Tparam, "/// @tparam %s $1" },
                { i.Parameter, "/// @param %s $1" },
                { i.Return, "/// @return $1" },
              },
            },
          },
        },
      })
    end,
  },
  {
    "AckslD/nvim-FeMaco.lua",
    ft = { "markdown" },
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
          return base_filetype == "markdown"
        end,
      })

      map:prefix("<leader>c", "+code"):set("e", edit_code_block, { desc = "Edit code block" })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    init = function()
      map
        :prefix("<leader>t", "+toggle")
        :set("t", function()
          require("toggleterm").toggle(vim.v.count, nil, nil, "horizontal")
        end)
        :set("T", function()
          require("toggleterm").toggle(vim.v.count, nil, nil, "tab")
        end)

      map:mode("t"):set("<Esc><Esc>", "<C-\\><C-n>")
    end,
    config = function()
      local toggleterm = require("toggleterm")
      local Terminal = require("toggleterm.terminal").Terminal

      toggleterm.setup({
        autochdir = true,
        shade_terminals = false,
        persist_mode = false,
        persist_size = false,
        auto_scroll = false,
        start_in_insert = false,
        on_open = function()
          vim.cmd.startinsert()
        end,
      })

      local origin_set_ft_options = Terminal.__set_ft_options
      function Terminal:__set_ft_options()
        origin_set_ft_options(self)
        vim.bo.buflisted = true
      end
    end,
  },
  {
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

      local function get_env_selections()
        local poses = utils.get_selections({
          char = "e",
          pattern = "\\begin{(%w-)}().-\\end{(%w-)}()",
        })

        if poses then
          poses.left.first_pos[2] = poses.left.first_pos[2] - 1
          poses.left.last_pos[2] = poses.left.last_pos[2] - 1
          poses.right.first_pos[2] = poses.right.first_pos[2] - 1
          poses.right.last_pos[2] = poses.right.last_pos[2] - 1
          return poses
        end
      end

      require("nvim-surround").setup({
        surrounds = {
          ["e"] = {
            find = "\\begin{%w-}.-\\end{%w-}",
            change = {
              target = get_env_selections,
              replacement = function()
                local poses = get_env_selections()
                local old_env = vim.api.nvim_buf_get_text(
                  0,
                  poses.left.first_pos[1] - 1,
                  poses.left.first_pos[2] - 1,
                  poses.left.last_pos[1] - 1,
                  poses.left.last_pos[2],
                  {}
                )[1]

                local element = get_input("New environment: ", old_env)
                if element then
                  return { { element }, { element } }
                end
              end,
            },
          },
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.align").setup()

      require("mini.comment").setup({
        options = {
          ignore_blank_line = true,
        },
      })

      local bufremove = require("mini.bufremove")
      bufremove.setup()
      map:set("ZX", bufremove.delete)
    end,
  },
  {
    "nvim-orgmode/orgmode",
    dependencies = "danilshvalov/org-modern.nvim",
    config = function()
      local VirtualIndent = require("virtual-indent")

      local Menu = require("org-modern.menu")
      -- local PrettySymbols = require("org-modern.pretty-symbols")
      -- PrettySymbols:new():attach()

      local ns_id = vim.api.nvim_create_namespace("orgmode.ui.indent")
      local Headline = require("orgmode.treesitter.headline")

      local function get_indent_size(line)
        local headline = Headline.from_cursor({ line + 1, 1 })

        if headline then
          local level = headline:level()
          local headline_line, _, _ = headline.headline:start()

          if headline_line == line then
            return level - 1
          else
            return level * 2
          end
        end

        return 0
      end

      local function delete_old_extmarks(buffer, start_line, end_line)
        local old_extmarks = vim.api.nvim_buf_get_extmarks(
          buffer,
          ns_id,
          { start_line, 0 },
          { end_line, 0 },
          { type = "virt_text" }
        )
        for _, ext in ipairs(old_extmarks) do
          vim.api.nvim_buf_del_extmark(buffer, ns_id, ext[1])
        end
      end

      local org_dir = vim.fs.normalize("~/org")

      require("orgmode").setup_ts_grammar()
      require("orgmode").setup({
        org_agenda_files = vim.fs.joinpath(org_dir, "*"),
        org_indent_mode = "noindent",
        org_hide_emphasis_markers = true,
        org_log_done = false,
        org_agenda_skip_scheduled_if_done = true,
        org_agenda_skip_deadline_if_done = true,
        org_blank_before_new_entry = { heading = false, plain_list_item = false },
        journal = {
          directory = "~/org/journal/",
          file_format = "%Y-%m-%d.org",
          date = {
            prefix = "* ",
            format = "%A %d.%m.%Y\n",
          },
          time = {
            prefix = "** ",
            format = "%H:%M ",
          },
        },
        ui = {
          menu = {
            handler = function(data)
              Menu:new():open(data)
            end,
          },
        },
      })

      map:prefix("<leader>o"):set("i", function()
        vim.cmd.edit(vim.fs.joinpath(org_dir, "index.org"))
      end)

      kit.autocmd("FileType", {
        pattern = "*.org",
        callback = function()
          VirtualIndent:new({}):attach()
        end,
      })

      -- local Journal = require("orgmode.journal")
      -- local Journal = require("journal")
      -- map:prefix("<Leader>o"):set("j", Journal.menu)
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        on_highlights = function(highlights, colors)
          highlights.WinSeparator = { fg = colors.yellow }
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup({})
      map:set("ga.", "<cmd>TextCaseOpenTelescope<CR>")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")

      ls.setup({
        update_events = { "TextChanged", "TextChangedI", "CursorMoved", "CursorMovedI" },
        region_check_events = { "CursorMoved", "CursorMovedI" },
        delete_check_events = { "TextChanged", "TextChangedI" },
      })

      require("luasnip.loaders.from_lua").lazy_load()
    end,
  },
  {
    "danilshvalov/skeletor.nvim",
    config = function()
      require("skeletor").setup()
    end,
  },
  {
    "aserowy/tmux.nvim",
    config = function()
      local tmux = require("tmux")

      tmux.setup({
        copy_sync = {
          redirect_to_clipboard = true,
        },
        resize = {
          enable_default_keybindings = false,
        },
      })

      map
        :set("<C-a>h", tmux.move_left)
        :set("<C-a>j", tmux.move_bottom)
        :set("<C-a>k", tmux.move_top)
        :set("<C-a>l", tmux.move_right)
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({
        view = {
          width = "25%",
          side = "right",
          signcolumn = "yes",
        },
        renderer = {
          indent_markers = {
            enable = true,
          },
        },
      })

      local api = require("nvim-tree.api")
      map:prefix("<leader>t"):set("e", api.tree.toggle)
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local fzf = require("fzf-lua")

      fzf.setup({
        winopts = {
          height = 0.3,
          row = vim.o.lines - 14,
          width = vim.o.columns,
          border = "none",
          preview = {
            hidden = "hidden",
          },
        },
        fzf_colors = {
          ["fg"] = { "fg", "CursorLine" },
          ["bg"] = { "bg", "Normal" },
          ["hl"] = { "fg", "Comment" },
          ["fg+"] = { "fg", "Normal" },
          ["bg+"] = { "bg", "Visual" },
          ["hl+"] = { "fg", "Statement" },
          ["info"] = { "fg", "PreProc" },
          ["prompt"] = { "fg", "Conditional" },
          ["pointer"] = { "fg", "Exception" },
          ["marker"] = { "fg", "Keyword" },
          ["spinner"] = { "fg", "Label" },
          ["header"] = { "fg", "Comment" },
          ["gutter"] = { "bg", "Normal" },
        },
      })

      map:ft("fzf"):set("<Esc>", vim.cmd.quit):set("q", vim.cmd.quit)

      map
        :prefix("<leader>f", "+file")
        :set("f", fzf.files, { desc = "Find files" })
        :set("g", fzf.live_grep, { desc = "Grep files" })
        :set("r", fzf.oldfiles, { desc = "Recent files" })
    end,
  },
}
