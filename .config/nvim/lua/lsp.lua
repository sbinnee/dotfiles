vim.opt.completeopt = {"menuone", "noselect", "noinsert"}
-- lspconfig
-- require'lspconfig'.bashls.setup{}
-- require'lspconfig'.pylsp.setup{}
local util = require 'lspconfig.util'
local root_py = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
}
require'project_nvim'.setup{
  manual_mode = false,
  detection_methods = {'lsp'},
  silent_chdir = false,
  exclude_dirs = {"~/*"},
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- require'lspconfig'.denols.setup{
--   init_options = {
--     lint = true,
--   },
--   single_file_support = true,
-- }
-- require'lspconfig'.eslint.setup{
--   single_file_support = true,
-- }

require'lspconfig'.jedi_language_server.setup{
  root_dir = util.root_pattern(unpack(root_py)),
  single_file_support = true,
}
require'lint'.linters_by_ft = {
  python = {'mypy'}
}
-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<space>]', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
require('lspconfig').ruff_lsp.setup {
  on_attach = on_attach,
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  }
}

-- lua
require'lspconfig'.lua_ls.setup{
  on_attach=on_attach
}

-- rust
require'lspconfig'.rust_analyzer.setup {
    on_attach=on_attach
    -- settings = {
    --     ["rust-analyzer"] = {
    --       diagnostics = {
    --         enable = false;
    --       }
    --     }
    -- }
}

-- golang
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
  doc_lines = 0,
  -- floating_window_off_y = 30,
  floating_window_off_x = 15, -- adjust float windows x position.
  -- floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
  --   local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
  --   -- local pumheight = vim.o.pumheight
  --   local pumheight = 2
  --   local winline = vim.fn.winline() -- line number in the window
  --   local winheight = vim.fn.winheight(0)

  --   -- window top
  --   if winline - 1 < pumheight then
  --     return 2
  --     -- return pumheight
  --   end

  --   -- window bottom
  --   if winheight - winline < pumheight then
  --     return -pumheight
  --   end
  --   return -3
  -- end,
  handler_opts = {
    border = "single"
  },
  toggle_key = '<C-x>'
})

-- coq
vim.g.coq_settings = {
  auto_start = "shut-up",
  clients = {
    snippets = {
      enabled = false,
      warn = {},
    },
  },
  keymap = {
    jump_to_mark = ""
  },
}
-- local coq = require "coq"

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

require('gitsigns').setup {}

-- require('onedark').setup  {
--     -- Main options --
--     style = 'cool', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--     transparent = false,  -- Show/hide background
--     term_colors = true, -- Change terminal color as per the selected theme style
--     ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
--     -- toggle theme style ---
--     toggle_style_key = '<leader>ts', -- Default keybinding to toggle
--     toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

--     -- Change code style ---
--     -- Options are italic, bold, underline, none
--     -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
--     code_style = {
--         comments = 'italic',
--         keywords = 'none',
--         functions = 'none',
--         strings = 'none',
--         variables = 'none'
--     },

--     -- Custom Highlights --
--     colors = {}, -- Override default colors
--     highlights = {}, -- Override highlight groups

--     -- Plugins Config --
--     diagnostics = {
--         darker = false, -- darker colors for diagnostic
--         undercurl = true,   -- use undercurl instead of underline for diagnostics
--         background = true,    -- use background color for virtual text
--     },
-- }
-- require('onedark').load()

require("zen-mode").setup({
  window = {
    backdrop = 0.90, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 100, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      signcolumn = "no", -- disable signcolumn
      number = false, -- disable number column
      relativenumber = false, -- disable relative numbers
      cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      list = false, -- disable whitespace characters
      colorcolumn = "0",
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = false,
      font = "+4", -- font size increment
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
    vim.api.nvim_command('set textwidth=100')
    vim.api.nvim_command('set formatoptions+=t')
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
  end,
})
