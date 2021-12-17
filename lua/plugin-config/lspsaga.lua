local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Rename symbol
map("n", "<F2>", '<Cmd>lua require("lspsaga.rename").rename()<CR>', opts)

-- Preview definition
map("n", ";d", '<Cmd>lua require("lspsaga.provider").preview_definition()<CR>', opts)

-- View signature
map("n", ";s", '<Cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)

-- Code action
map("n", ";a", '<Cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)

-- Multiply code action
map("v", ";a", ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)

-- Show hover
map("n", ";h", '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)

-- Go to the next problem
map("n", "gp", '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
map("n", "gn", '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)

map("n", "go", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)

-- Go to the previous problem

map("n", ";ld", '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>', opts)


map("n", "<A-t>", '<cmd>Lspsaga toggle_floaterm<CR>', opts)
map("t", "<A-t>", '<C-\\><C-n><cmd>Lspsaga toggle_floaterm<CR>', opts)
