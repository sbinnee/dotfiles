"" neovim specific
" hightlight text when yanked
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}

" Enable true color
set termguicolors
set number relativenumber
" To display file path in window manager env
set title
" Indent a.k.a. tab
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set smartindent
" noswap/nobackup
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
" allow hidden buffer
set hidden
" emoji issue
set noemoji
" Show tab
set list
set listchars=tab:>\ ,trail:·,nbsp:+,precedes:«,extends:»
" set as default in nvim
syntax on
set incsearch
" ruler
set colorcolumn=81  " Ruler; mark above 80 as red
set textwidth=80
set formatoptions-=t
set conceallevel=0
let g:tex_conceal=''

autocmd FileType gitcommit setlocal tw=72 formatoptions+=t
autocmd FileType go setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
autocmd FileType tex setlocal tw=0 colorcolumn=0 tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType html setlocal tw=0 colorcolumn=0 tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType crontab setlocal tw=0 colorcolumn=0
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType xml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType lua setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType rst setlocal colorcolumn=89 textwidth=88
autocmd FileType markdown setlocal colorcolumn=89 textwidth=88
autocmd BufNewFile,BufRead,BufEnter ~/Notes/** setlocal tw=72 fo+=t
autocmd BufNewFile,BufRead,BufEnter *.goyo setlocal tw=80 fo+=t
" nohlsearch
map <silent> <leader>h :nohlsearch<CR>
nnoremap <M-z> :set wrap!<CR>
" defulat split direction
set splitbelow
set splitright
" moving split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Greatest remaps
" 1. yank like D or C
nnoremap Y y$
" 2. undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
" 3. move line
vnoremap <M-Down> :m '>+1<CR>gv=gv
vnoremap <M-Up> :m '<-2<CR>gv=gv
nnoremap <M-Down> :m .+1<CR>==
nnoremap <M-Up> :m .-2<CR>==

" Copy to clipboard
vmap <leader>y "+y

" Explore
"map <leader>lf :Texplore<CR>
"nnoremap <leader>f :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" Search&replace using . (Greg Hurrell)
nnoremap c* *Ncgn
"nnoremap S :%s//gc<Left><Left><Left>

" Spellchecker
map <leader>se :setlocal spell! spelllang=en_us<CR>
map <leader>sf :setlocal spell! spelllang=fr<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save. (Luke Smith)
" https://stackoverflow.com/questions/6496778/vim-run-autocmd-on-all-filetypes-except
fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    " if &ft =~ 'markdown' || &ft =~ 'html'
    if &ft =~ 'html'
        return
	endif
	%s/\s\+$//e
	%s/\n\+\%$//e
endfun
" autocmd BufWritePre * %s/\s\+$//e
" autocmd BufWritepre * %s/\n\+\%$//e
autocmd BufWritePre * call StripTrailingWhitespace()

" toggle mouse
function! ToggleMouse()
    if &mouse !~# 'ni'
        set mouse=ni
        echo 'mouse on'
    else
        set mouse=
        echo 'mouse off'
    endif
endfunction
map <leader>m :call ToggleMouse()<CR>

" Put date
nnoremap <leader>d :call PutDate()<CR>
function! PutDate()
	let l:dash = "    ------------------"
	let l:date = strftime('%Y-%m-%d %a')
	:put! =l:dash . \"\n    \| \" . l:date . \" \|\n\" . l:dash
endfunction

""""" --- vim-plug ---
" ```
" 	Minimalist Vim Plugin Manager
" 	Repo: https://github.com/junegunn/vim-plug
" ```
""" --- Requirements ---
" 	`pip install --user pynvim`
" 	`pip install --user -U msgpack`
""" --- Actual Plugged call ---
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
" Quickstart configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Fast as FUCK nvim completion.
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" lsp signature hint when you type
Plug 'ray-x/lsp_signature.nvim'
" An asynchronous linter plugin for Neovim
Plug 'mfussenegger/nvim-lint'
" The superior project management solution for neovim (:ProjectRoot)
Plug 'ahmedkhalf/project.nvim'
" A nicer Python indentation style for vim.
Plug 'hynek/vim-python-pep8-indent'
" Vim plugin to sort python imports using isort :Isort
Plug 'fisadev/vim-isort'
" fugitive.vim: A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
" All the lua functions I don't want to write twice
Plug 'nvim-lua/plenary.nvim'
" Super fast git decorations implemented purely in lua/teal.
Plug 'lewis6991/gitsigns.nvim'
" commentary.vim; [t.pope] comment stuff out
Plug 'tpope/vim-commentary'
" surround.vim; [t.pope] quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Lightline; A light and configurable statusline/tabline
Plug 'itchyny/lightline.vim'
" indentline; display the indention levels
Plug 'yggdroot/indentline'
" The fastest Neovim colorizer
Plug 'norcalli/nvim-colorizer.lua'
" vim-smoothie; scrolling nice and smooth
Plug 'psliwka/vim-smoothie'
" fzf; fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Scalpel; Fast within-file word replacement for Vim
Plug 'wincent/scalpel'
" VIM Table Mode for instant table creation.
Plug 'dhruvasagar/vim-table-mode'
" Distraction-free coding for Neovim
Plug 'folke/zen-mode.nvim'
" Markdown Vim Mode
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
" One dark and light colorscheme for neovim >= 0.5.0
Plug 'navarasu/onedark.nvim'
" Dracula dark theme for vim
Plug 'dracula/vim'
" seoul256.vim; Colorscheme by junegunn
Plug 'junegunn/seoul256.vim'
" Gruvbox; Retro groove color scheme for Vim
Plug 'morhetz/gruvbox'

""" --- Uninstalled ---
" " Polyglot
" Plug 'sheerun/vim-polyglot'
" " coq snippet
" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" " Auto completion plugin for nvim that written in Lua.
" Plug 'hrsh7th/nvim-compe'
" " COLORIZER; color colornames and codes
" Plug 'chrisbra/colorizer'
" " A light-weight lsp plugin based on neovim built-in lsp with highly a
" " performant UI.
" Plug 'glepnir/lspsaga.nvim'
" " Deoplate; asynchronous completion framework for
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" " Deoplete-jedi; auto-completion for Python;`pip install jedi`
" Plug 'zchee/deoplete-jedi'
" " jedi-vim; Awesome Python autocompletion with VIM
" Plug 'davidhalter/jedi-vim'
" " vim-go
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" " Denite features
" Plug 'Shougo/denite.nvim'
" " Nerdcommenter; intensely nerdy commenting powers
" "		>>>> Malware! Make quitting vim significantly slow
" Plug 'preservim/nerdcommenter'
" " Vim-css-color; Preview colours in source code while editing
" Plug 'ap/vim-css-color'
" " Neomake; Asynchronous linting and make framework for Neovim/Vim
" Plug 'neomake/neomake'
" " crtlp.vim; Fuzzy file, buffer, mru, tag, etc finder
" Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

""""" --- Plugin Settings ---
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

""" Lightline
set noshowmode

" indentline
let g:indentLine_color_gui = '#A4E57E'
" https://vi.stackexchange.com/questions/12520/markdown-in-neovim-which-plugin-sets-conceallevel-2
let g:indentLine_fileTypeExclude = ['markdown', 'json']

" fugitive
nnoremap <leader>fd :Gdiffsplit<CR>
nnoremap <leader>fs :Git<CR>
nnoremap <leader>fl :Gclog<CR>
" https://gist.github.com/aroben/d54d002269d9c39f0d5c89d910f7307e
autocmd VimEnter COMMIT_EDITMSG call OpenCommitMessageDiff()
function OpenCommitMessageDiff()
  try
    " Remove 'vert' if you want it horizontally split.
    :vert Git diff --cached
    " Fix-up tmp buffer
    set filetype=diff noswapfile nomodified readonly
    silent file [Changes\ to\ be\ committed]
    " " Put the diff on the left
    " wincmd r
  endtry
  " Get back to the commit message
  wincmd p
endfunction

""" COLORIZER
map <silent> <leader>C :ColorizerToggle<CR>
" let g:colorizer_auto_color = 1
" map <silent> <leader>C :ColorToggle<CR>

""" fzf
" https://github.com/junegunn/fzf#tips
nnoremap <C-P> :FZF<CR>
" let g:fzf_layout = { 'down': '20%' }
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

""" Scalpel
" Instead of default <Leader>e:
" nmap S <Plug>(Scalpel)
let g:ScalpelCommand='S'

""" ZenMode
nmap <leader>zm :ZenMode<CR>

""" --- Uninstalled ---
""" Nerdcommenter
" let g:NERDSpaceDelims = 1
""" Neomake
" let g:neomake_python_enabled_makers = ['pylint']
" call neomake#configure#automake('nrwi', 500)

""" --- Colorscheme ---
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
" " A bit modified molokai .config/nvim/colors/molokai.vim
" colorscheme molokai
" let g:seoul256_background = 235
" colorscheme seoul256
" colorscheme dracula
" colorscheme darkblue
" colorscheme monokai

" same as indentline
highlight Whitespace ctermfg=120 guifg=#a4e57e
" highlight Whitespace ctermfg=166 guifg=#d65d0e
highlight Comment cterm=italic gui=italic
" Transparent background
"highlight Normal ctermbg=NONE guibg=NONE
" Do some tricks to highlight only the number of line
set cursorline
highlight clear CursorLine
" Toggle background transparency
let t:is_transparent = 1
" https://jnrowe.github.io/articles/tips/Toggling_settings_in_vim.html
function! Toggle_transparent()
	if t:is_transparent == 0
		highlight Normal ctermbg=NONE guibg=NONE
		let t:is_transparent = 1
	else
		set background=dark
		set cursorline
		highlight clear CursorLine
		let t:is_transparent = 0
	endif
endfunction
nnoremap <leader>b :call Toggle_transparent()<CR>

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

""" lua
luafile ~/.config/nvim/lua/lsp.lua
au BufReadPost * lua require('lint').try_lint()
au BufWritePost * lua require('lint').try_lint()
" au InsertLeave * lua require('lint').try_lint()

nnoremap <silent> <leader>gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>gt    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>gR    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>ca    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>gf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>gr    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> [d            <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d            <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>wl    <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <silent> <space>n     <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <space>p     <cmd>lua vim.diagnostic.goto_prev()<CR>
" inoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>  " use lsp_signature instaed
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

""" Execution
nmap <leader>xp <cmd>!python %<CR>
