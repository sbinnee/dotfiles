vim.opt.completeopt = {"menuone", "noselect", "noinsert"}

local util = require('lspconfig.util')
local root_py = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
}

-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<space>]', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>gs', function()
    vim.ui.input(
        { prompt = 'Search workspace symbols: ' },
        function(input)
            if input then
                vim.lsp.buf.workspace_symbol(input)
            end
        end
    )
end, { desc = 'Search workspace symbols' })
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

require'project_nvim'.setup{
  manual_mode = false,
  detection_methods = { "lsp", "pattern" },
  patterns = { ".git", "pyproject.toml" },
  silent_chdir = false,
  -- exclude_dirs = {"~/*"},
}

vim.diagnostic.config({ virtual_text = true })

-- [python]
-- require'lspconfig'.pylsp.setup{}
-- require'lspconfig'.jedi_language_server.setup{}
  -- root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  -- root_dir = util.root_pattern(unpack(root_py)),
  -- single_file_support = true,
-- }

-- require'lspconfig'.basedpyright.setup{
--   settings = {
--     basedpyright = {
--       analysis = {
--         typeCheckingMode = "off",
--         diagnosticMode = "openFilesOnly",
--         inlayHints = {
--           callArgumentNames = true
--         },
--         autoImportCompletions = false,
--         exclude = { "**/*.ipynb", "**/node_modules", "**/__pycache__", "**/.ipynb_checkpoints", "**/.venv", "**/.git", "**/data" },
--         ignore = { "**/*.ipynb", "**/node_modules", "**/__pycache__", "**/.ipynb_checkpoints", "**/.venv", "**/.git", "**/data" },
--       }
--     }
--   }
-- }

vim.lsp.enable('basedpyright')
vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "off",
        diagnosticMode = "openFilesOnly",
        inlayHints = {
          callArgumentNames = true
        },
        autoImportCompletions = false,
        exclude = { "**/*.ipynb", "**/node_modules", "**/__pycache__", "**/.ipynb_checkpoints", "**/.venv", "**/.git", "**/data" },
        ignore = { "**/*.ipynb", "**/node_modules", "**/__pycache__", "**/.ipynb_checkpoints", "**/.venv", "**/.git", "**/data" },
      }
    }
  },
  on_attach = on_attach
})

vim.lsp.enable('ty')

-- require'lspconfig'.ruff.setup {
--   on_attach = on_attach,
-- }
-- require'lint'.linters_by_ft = {
--   python = { 'ruff' }
-- }

-- -- [lua]
-- require'lspconfig'.lua_ls.setup{
--   on_attach=on_attach
-- }

-- [rust]
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

-- [golang]
require'lspconfig'.gopls.setup{
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
    },
  },
}

-- [lsp_signature]
require "lsp_signature".setup({
  bind = true,
  doc_lines = 0,
  floating_window_off_x = 15, -- adjust float windows x position.
  floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
    local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
    local pumheight = 5
    -- local pumheight = vim.o.pumheight
    local winline = vim.fn.winline() -- line number in the window
    local winheight = vim.fn.winheight(0)

    -- window top
    if winline - 1 < pumheight then
      return 2 * pumheight
    end

    -- window bottom
    if winheight - winline < pumheight then
      return -pumheight
    end
    return 0
  end,
  handler_opts = {
    border = "single"
  },
  toggle_key = '<C-x>'
})

-- [coq]
vim.g.coq_settings = {
  auto_start = "shut-up",
  clients = {
    snippets = {
      enabled = false,
      warn = {},
    },
  },
  keymap = {
    jump_to_mark = "",
  },
}

-- -- https://elianiva.my.id/post/my-nvim-lsp-setup#diagnostic
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     signs = true,
--     update_in_insert = false,
--   }
-- )
-- vim.fn.sign_define('LspDiagnosticsSignError', { text = "", texthl = "LspDiagnosticsDefaultError" })
-- vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "", texthl = "LspDiagnosticsDefaultWarning" })
-- vim.fn.sign_define('LspDiagnosticsSignInformation', { text = "", texthl = "LspDiagnosticsDefaultInformation" })
-- vim.fn.sign_define('LspDiagnosticsSignHint', { text = "", texthl = "LspDiagnosticsDefaultHint" })

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
