vim.o.completeopt = "menuone,noselect"

-- lspconfig
-- require'lspconfig'.bashls.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.gopls.setup{
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
    },
  },
}
-- lsp_signature.nvim plugin
require "lsp_signature".setup({
  bind = true,
  handler_opts = {
    border = "single"
  }
})

-- coq
local coq = require "coq"

-- https://elianiva.my.id/post/my-nvim-lsp-setup#diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    update_in_insert = false,
  }
)
vim.fn.sign_define('LspDiagnosticsSignError', { text = "", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = "", texthl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = "", texthl = "LspDiagnosticsDefaultHint" })

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  -- keymaps = {
  --   -- Default keymap options
  --   noremap = true,

  --   ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
  --   ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

  --   ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
  --   ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
  --   ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
  --   ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
  --   ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
  --   ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
  --   ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  --   ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
  --   ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
  --   ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

  --   -- Text objects
  --   ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
  --   ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  -- },
  watch_index = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  current_line_blame_formatter_opts = {
    relative_time = false
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
