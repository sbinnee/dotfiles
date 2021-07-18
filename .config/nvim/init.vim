" Enable true color
set termguicolors
set number relativenumber
" To display file path in window manager env
set title
" Indent a.k.a. tab
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
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
set colorcolumn=81 		" Ruler; mark above 80 as red
set textwidth=80
set formatoptions-=t
let g:tex_conceal=''
autocmd FileType gitcommit setlocal tw=72
autocmd FileType gitcommet setlocal formatoptions-=t
autocmd FileType tex setlocal tw=0 colorcolumn=0 tabstop=2 shiftwidth=2
autocmd FileType html setlocal tw=0 colorcolumn=0 tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType xml setlocal tabstop=2 shiftwidth=2
autocmd FileType lua setlocal tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead,BufEnter ~/Notes/** setlocal tw=72 fo+=t
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
" Vertical new split view
nnoremap <leader>sv :vert sview<CR>
" " Tab https://vi.stackexchange.com/questions/19675/cycle-through-autocomplete-menu-using-tab
" inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
"
vmap <leader>y "+y
" Explore
map <leader>lf :Texplore<CR>
nnoremap <leader>f :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
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

" Put date
nnoremap <leader>d :call PutDate()<CR>
function! PutDate()
	let l:dash = "\t\t------------------"
	let l:date = strftime('%Y-%m-%d %a')
	:put! =l:dash . \"\n\t\t\| \" . l:date . \" \| \n\" . l:dash
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
" Auto completion plugin for nvim that written in Lua.
Plug 'hrsh7th/nvim-compe'
" lsp signature hint when you type
Plug 'ray-x/lsp_signature.nvim'
" commentary.vim; [t.pope] comment stuff out
Plug 'tpope/vim-commentary'
" surround.vim; [t.pope] quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Lightline; A light and configurable statusline/tabline
Plug 'itchyny/lightline.vim'
" indentline; display the indention levels
Plug 'yggdroot/indentline'
" COLORIZER; color colornames and codes
Plug 'chrisbra/colorizer'
" vim-smoothie; scrolling nice and smooth
Plug 'psliwka/vim-smoothie'
" fzf; fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Dracula dark theme for vim
Plug 'dracula/vim'
" seoul256.vim; Colorscheme by junegunn
Plug 'junegunn/seoul256.vim'
" Gruvbox; Retro groove color scheme for Vim
Plug 'morhetz/gruvbox'
" Scalpel; Fast within-file word replacement for Vim
Plug 'wincent/scalpel'

""" --- Uninstalled ---
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
""" Lightline
set noshowmode
"
" indentline
let g:indentLine_color_gui = '#A4E57E'
" https://vi.stackexchange.com/questions/12520/markdown-in-neovim-which-plugin-sets-conceallevel-2
let g:indentLine_fileTypeExclude = ['markdown', 'json']

""" COLORIZER
" let g:colorizer_auto_color = 1
map <silent> <leader>C :ColorToggle<CR>

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

""" --- Uninstalled ---
""" Nerdcommenter
" let g:NERDSpaceDelims = 1
""" Neomake
" let g:neomake_python_enabled_makers = ['pylint']
" call neomake#configure#automake('nrwi', 500)

""" --- Colorscheme ---
" " A bit modified molokai .config/nvim/colors/molokai.vim
" colorscheme molokai
" let g:seoul256_background = 235
" colorscheme seoul256
colorscheme gruvbox
"colorscheme dracula

" colorscheme darkblue
" colorscheme monokai

" Transparent background
highlight Normal ctermbg=NONE guibg=NONE
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
      \             [ 'readonly', 'absolutepath', 'modified' ] ],
      \   'right': [ [ 'lineinfo', 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'linenumber' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l/%L:%-2v%<',
      \ },
      \ }

""" Autocompletion
luafile ~/.config/nvim/lua/lsp.lua
nnoremap <silent> <leader>gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
inoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
