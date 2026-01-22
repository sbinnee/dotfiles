local is_macos = vim.loop.os_uname().sysname == "Darwin"

vim.api.nvim_create_autocmd({"TextYankPost"}, {
  pattern = {"*"},
  callback = function()
    vim.highlight.on_yank {higroup='IncSearch', timeout=300, on_visual=true}
  end
})

-- vim.api.nvim_create_autocmd({"BufReadPost", "BufWritePost"}, {
--   pattern = {"*"},
--   callback = function(ev)
--     require('lint').try_lint()
--   end
-- })

local function strip_trailing_whitespace()
  vim.cmd[[
    %s/\s\+$//e
    %s/\n\+\%$//e
    %s/\r+$//e
    "%s/\+$//e
  ]]
end
-- Create a command to call this function
vim.api.nvim_create_user_command('StripTrailingWhitespace', strip_trailing_whitespace, {})
if not is_macos then
  vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*"},
    command = "StripTrailingWhitespace"
  })
end

-- Put date
local function put_date()
    -- Get the current date in YYYY-MM-DD Day format
    local date = os.date('%Y-%m-%d %a')
    -- Insert the date above the current line
    vim.api.nvim_put({"Date: " .. date}, "l", false, false)
end
-- Create a command to call this function
vim.api.nvim_create_user_command('PutDate', put_date, {})

local function put_claude()
  vim.api.nvim_put({"Co-Authored-By: Claude noreply@anthropic.com"}, "l", false, false)
end
vim.api.nvim_create_user_command('PutClaude', put_claude, {})


--[[
  OPTIONS
]]--
-- local o = vim.o -- vim options
-- local go = vim.go  -- global option, setglobal
-- local wo = vim.wo  -- window-scoped options
-- local bo = vim.bo  -- buffer-scoped options
-- local opt = vim.opt -- lua's map style
-- local opt_local = vim.opt_local -- local
-- local opt_global = vim.opt_gobal -- global

-- general
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- look
vim.opt.title = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = { 81, 89 }
vim.opt.textwidth = 80
--[REVIEW] set formatoptions-=t
--[REVIEW] set conceallevel=0
--[REVIEW] let g:tex_conceal=''
vim.opt.list = true
-- set listchars=tab:>\ ,trail:·,nbsp:+,precedes:«,extends:»
vim.opt.listchars = { tab = '>~', trail = '·' }
-- lightline
vim.opt.showmode = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- window split
vim.opt.splitbelow = true
vim.opt.splitright = true

--[[
  KEYMAPS
]]--
vim.keymap.set("n", "<leader>h", "<cmd>:nohlsearch<CR>")
if is_macos then
  vim.keymap.set("n", "<leader>z", "<cmd>:set wrap!<CR>")
else
  vim.keymap.set("n", "<M-Z>", "<cmd>:set wrap!<CR>")
end
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true })
-- Greatest remaps
-- 1. yank like D or C
vim.keymap.set("n", "Y", "y$", { noremap = true })
-- 2. undo break points
-- inoremap , ,<c-g>u
-- inoremap . .<c-g>u
-- inoremap ! !<c-g>u
-- inoremap ? ?<c-g>u
-- " 3. move line
-- vnoremap <M-Down> :m '>+1<CR>gv=gv
-- vnoremap <M-Up> :m '<-2<CR>gv=gv
-- nnoremap <M-Down> :m .+1<CR>==
-- nnoremap <M-Up> :m .-2<CR>==

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", "\"+y", { noremap = true })
-- Search&replace using . (Greg Hurrell)
--nnoremap c* *Ncgn
vim.keymap.set("n", "c*", "*Ncgn", { noremap = true })

-- Spellchecker
vim.keymap.set("n", "<leader>se", "<cmd>:setlocal spell! spelllang=en_us<CR>")
vim.keymap.set("n", "<leader>sf", "<cmd>:setlocal spell! spelllang=fr<CR>")

-- -- Mapping to call the put_date function
vim.keymap.set('n', '<leader>d', ':PutDate<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>xp', '<cmd>!python %<CR>')
vim.keymap.set('n', '<leader>xs', '<cmd>!sh %<CR>')


-- Creates keybinds (`;;v`, `;;d`, `;;s`, etc.) that wrap text blocks with
-- quotes/brackets/markdown syntax while preserving your current Vim mode.
--
-- Simple ver --
-- -- Insert mode: ;;v wraps word under cursor with backticks
-- vim.keymap.set('i', ';;v', function()
--   local word = vim.fn.expand('<cword>')
--   return '<Esc>viW<Esc>a`<Esc>Bi`<Esc>lEa'
-- end, { expr = true, desc = 'Wrap word in backticks' })
-- vim.keymap.set("n", ";;v", 'viW<Esc>a`<Esc>Bi`<Esc>lE')
--
local wrappers = {
  v = {'`', '`'},   -- backticks
  d = {'"', '"'},   -- double quotes
  s = {"'", "'"},   -- single quotes
  p = {'(', ')'},   -- parentheses
  b = {'[', ']'},   -- brackets
  c = {'{', '}'},   -- curly braces
  a = {'<', '>'},   -- angle brackets
  t = {'**', '**'}, -- markdown bold
  i = {'*', '*'},   -- markdown italic
}
for key, pair in pairs(wrappers) do
  local left, right = pair[1], pair[2]
  -- Insert mode: wrap and return to insert mode
  vim.keymap.set('i', ';;' .. key, function()
    return '<Esc>viW<Esc>a' .. right .. '<Esc>Bi' .. left .. '<Esc>lEa'
  end, { expr = true })
  -- Normal mode: wrap and stay in normal mode
  vim.keymap.set('n', ';;' .. key, 'viW<Esc>a' .. right .. '<Esc>Bi' .. left .. '<Esc>lE')
  -- Visual mode: wrap and return to normal mode
  vim.keymap.set('v', ';;' .. key, 'c' .. left .. right .. '<Esc>P')
end

--[[
  Plugins (vim-plug)
]]--
-- --- vim-plug ---
-- ```
--   Minimalist Vim Plugin Manager
--   Repo: https://github.com/junegunn/vim-plug
-- ```
-- --- Requirements ---
--   `pip install --user pynvim`
--   `pip install --user -U msgpack`
-- --- Actual Plugged call ---
-- Specify a directory for plugins
-- - For Neovim: stdpath('data') . '/plugged'
-- - Avoid using standard Vim directory names like 'plugin'

local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- Quickstart configurations for the Nvim LSP client
Plug('neovim/nvim-lspconfig')
-- Fast as FUCK nvim completion.
Plug('ms-jpq/coq_nvim', { ['branch'] = 'coq' })
-- lsp signature hint when you type
Plug('ray-x/lsp_signature.nvim')
-- An asynchronous linter plugin for Neovim
Plug('mfussenegger/nvim-lint')
-- The superior project management solution for neovim (:ProjectRoot)
Plug('sbinnee/project.nvim')
-- Python syntax highlighting for Vim
Plug('vim-python/python-syntax')
-- A nicer Python indentation style for vim.
Plug('hynek/vim-python-pep8-indent')
-- fugitive.vim: A Git wrapper so awesome, it should be illegal
Plug('tpope/vim-fugitive')
-- All the lua functions I don't want to write twice
Plug('nvim-lua/plenary.nvim')
-- Super fast git decorations implemented purely in lua/teal.
Plug('lewis6991/gitsigns.nvim')
-- commentary.vim; [t.pope] comment stuff out
Plug('tpope/vim-commentary')
-- surround.vim; [t.pope] quoting/parenthesizing made simple
Plug('tpope/vim-surround')
-- Lightline; A light and configurable statusline/tabline
Plug('itchyny/lightline.vim')
-- The fastest Neovim colorizer
Plug('norcalli/nvim-colorizer.lua')
-- vim-smoothie; scrolling nice and smooth
Plug('psliwka/vim-smoothie')
-- fzf; fuzzy finder
Plug('junegunn/fzf', { ['do'] = function() vim.fn['fzf#install()']() end })
Plug('junegunn/fzf.vim')
-- Scalpel; Fast within-file word replacement for Vim
Plug('wincent/scalpel')
-- VIM Table Mode for instant table creation.
Plug('dhruvasagar/vim-table-mode')
-- Distraction-free coding for Neovim
Plug('folke/zen-mode.nvim')
-- Markdown Vim Mode
Plug('godlygeek/tabular')
Plug('preservim/vim-markdown')
-- Lua port of the most famous vim colorscheme
Plug('ellisonleao/gruvbox.nvim')
-- cityscape A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
Plug('folke/tokyonight.nvim', { ['branch'] = 'main' })
--  Molokai colorscheme for Neovim.
Plug('UtkarshVerma/molokai.nvim', { ['branch'] = 'main' })
Plug('loctvl842/monokai-pro.nvim')
-- Nvim Treesitter configurations and abstraction layer
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = function() vim.fn[':TSUpdate']() end })
-- Show code context; Lightweight alternative to context.vim
Plug('nvim-treesitter/nvim-treesitter-context')
-- Dracula dark theme for vim
Plug('dracula/vim')
-- A Neovim plugin for CSV file editing.
Plug('hat0uma/csvview.nvim')
-- Async isort plugin for Vim + Neovim
Plug('brentyi/isort.vim')
-- A Filetype plugin for csv files
Plug('chrisbra/csv.vim')
-- Indent guides for Neovim
Plug('lukas-reineke/indent-blankline.nvim')
-- Markdown preview plugin for Neovim
-- build: (1) goto ~/.local/share/nvim/plugins/peek.nvim
-- (2) deno task --quiet build:fast
-- (3) Bind PeekOpen an PeekClose cmds.
Plug('toppair/peek.nvim')
Plug('junegunn/vim-easy-align')
Plug('windwp/nvim-ts-autotag')
--[[
-- Vim plugin to sort python imports using isort :Isort
Plug('fisadev/vim-isort')
-- indentline; display the indention levels
Plug('yggdroot/indentline')
--]]
vim.call('plug#end')

vim.keymap.set('n', '<leader>C', '<cmd>ColorizerToggle<CR>')
vim.keymap.set('n', '<leader>cf', '<cmd>Isort<CR>')
vim.keymap.set('n', '<leader>cd', '<cmd>%!ruff check --select D --fix-only --silent --stdin-filename=%<CR>')
vim.keymap.set('n', '<C-P>', '<cmd>:FZF<CR>')

require('gitsigns').setup {}
require('ibl').setup {}
require('zen-mode').setup {}
require('peek').setup {}

require('lsp')

vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

-- easy-align
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")

-- folding using treesitter
-- When it can't find folds, try :e
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99  -- open all
-- vim.opt.foldlevel = 99
-- vim.opt.foldnestmax = 4

-- """"" --- Plugin Settings ---
vim.cmd[[
  """ python-syntax
  let g:python_highlight_all = 1
  """ vim-markdown
  " disable header folding
  let g:vim_markdown_folding_disabled = 1
  " do not use conceal feature, the implementation is not so good
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_no_default_key_mappings = 1
  " disable math tex conceal feature
  let g:tex_conceal = ""
  let g:vim_markdown_math = 1
  let g:vim_markdown_conceal_code_blocks = 0
  " support front matter of various format
  let g:vim_markdown_frontmatter = 1  " for YAML format
  " let g:vim_markdown_toml_frontmatter = 1  " for TOML format
  " let g:vim_markdown_json_frontmatter = 1  " for JSON format

  """ vim-python-pep8-indent
  "let g:python_pep8_indent_hang_closing = 0
  let g:csv_no_conceal = 1
]]

-- " indentline
-- vim.cmd[[
--   let g:vim_json_conceal=0
--   " let g:markdown_syntax_conceal=0
-- ]]
-- let g:indentLine_color_gui = '#A4E57E'
-- " https://vi.stackexchange.com/questions/12520/markdown-in-neovim-which-plugin-sets-conceallevel-2
-- let g:indentLine_fileTypeExclude = ['markdown', 'json']

-- " fugitive
-- nnoremap <leader>fd :Gdiffsplit<CR>
-- nnoremap <leader>fs :Git<CR>
-- nnoremap <leader>fl :Gclog<CR>
-- vim.cmd[[
--   " https://gist.github.com/aroben/d54d002269d9c39f0d5c89d910f7307e
--   autocmd VimEnter COMMIT_EDITMSG call OpenCommitMessageDiff()
--   function OpenCommitMessageDiff()
--     try
--       " Remove 'vert' if you want it horizontally split.
--       :vert Git diff --cached
--       " Fix-up tmp buffer
--       set filetype=diff noswapfile nomodified readonly
--       silent file [Changes\ to\ be\ committed]
--       " " Put the diff on the left
--       " wincmd r
--     endtry
--     " Get back to the commit message
--     wincmd p
--   endfunction
-- ]]

vim.cmd[[
  " Select buffer
  function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
  endfunction
  function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
  endfunction
  nnoremap <silent> <Leader><Enter> :call fzf#run({
  \   'source':  reverse(<sid>buflist()),
  \   'sink':    function('<sid>bufopen'),
  \   'options': '+m',
  \   'down':    len(<sid>buflist()) + 2
  \ })<CR>
]]

vim.cmd[[
  " scrolloff
  " https://github.com/drzel/vim-scrolloff-fraction/blob/master/plugin/vim-scroll-off-fraction.vim
  let g:scrolloff_fraction = 0.20
  function! ScrollOffFraction(fraction)
      let l:visible_lines_in_active_window = winheight(win_getid())
      let &scrolloff = float2nr(l:visible_lines_in_active_window * a:fraction)
  endfunction
  augroup ScrolloffFraction
    autocmd!
    autocmd BufEnter,WinEnter,WinNew,VimResized *,*.*
          \ call ScrollOffFraction(g:scrolloff_fraction)
  augroup END
]]

vim.cmd[[
  " Lightline
  let g:lightline = {
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ],
        \   'right': [ [ 'lineinfo', 'percent' ],
        \              [ 'fileformat', 'fileencoding', 'filetype', 'linenumber' ] ]
        \ },
        \ 'component': {
        \   'lineinfo': '%3l/%L:%-2v%<',
        \ },
        \ 'component_function': {
        \   'gitfugitive': 'FugitiveStatusline',
        \   'gitbranch': 'FugitiveHead',
        \ },
        \ }
]]

vim.cmd.colorscheme('tokyonight')
