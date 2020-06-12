" Enable true color
set termguicolors
set number relativenumber

set title

" Indent a.k.a. tab
set tabstop=4
set shiftwidth=4
" set expandtab

" Automatic text wrapping
" Disable text wrapping in most case
" Works only in comment h:fo-table fo+=c
set textwidth=80
set formatoptions-=t
autocmd FileType gitcommit setlocal tw=72
autocmd FileType gitcommet setlocal formatoptions-=t

" moving split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <M-z> :set wrap!<CR>

" Replace (Luke's)
nnoremap S :%s//gc<Left><Left><Left>

" defulat split direction
set splitbelow
set splitright

" ruler
set colorcolumn=81 		" Ruler; mark above 80 as red

" Spellchecker
map <leader>se :setlocal spell! spelllang=en_us<CR>
map <leader>sf :setlocal spell! spelllang=fr<CR>

" nohlsearch
map <leader>h :nohlsearch<CR>

" Explore
map <leader>lf :Texplore<CR>

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
" Deoplate
" 	Provide an extensible and asynchronous completion framework for
" 	neovim/Vim8
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Deoplete-jedi
" 	Provide auto-completion for Python
" 	`pip install jedi`
Plug 'zchee/deoplete-jedi'
" commentary.vim
" 	[t.pope] commentary.vim: comment stuff out
Plug 'tpope/vim-commentary'
" surround.vim
" 	[t.pope] surround vim: quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Lightline
" 	A light and configurable statusline/tabline plugin for Vim	
Plug 'itchyny/lightline.vim'
" COLORIZER
" 	A plugin to color colornames and codes
Plug 'chrisbra/colorizer'
" indentline
" 	A vim plugin to display the indention levels with thin vertical lines
Plug 'yggdroot/indentline'

""" --- Uninstalled ---
" " seoul256.vim
" " 	Colorscheme by junegunn
" Plug 'junegunn/seoul256.vim'
" " Nerdcommenter
" " 	Vim plugin for intensely nerdy commenting powers
" "		>>>> Malware! Make quitting vim significantly slow
" Plug 'preservim/nerdcommenter'
" " Vim-css-color
" " 	Preview colours in source code while editing
" Plug 'ap/vim-css-color'
" " Neomake
" " 	Asynchronous linting and make framework for Neovim/Vim
" Plug 'neomake/neomake'
" " Gruvbox
" " 	Retro groove color scheme for Vim
" " Plug 'morhetz/gruvbox'
" " Auto-paris
" " 	Vim plugin, insert or delete brackets, parens, quotes in pair
" Plug 'jiangmiao/auto-pairs'
" " crtlp.vim
" " 	Active fork of kien/ctrlp.vim--Fuzzy file, buffer, mru, tag, etc finder
" Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

""""" --- Plugin Settings ---
""" Autocompletion
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('auto_complete', v:false)
" call deoplete#custom#option({
" \ 'auto_complete': v:false,
" \ 'sources': {
" \ 'py': ['buffer','file'],
" \ }
" \ })
" inoremap <expr> <C-n> deoplete#complete()
inoremap <expr> <C-Space> deoplete#complete()

" call deoplete#custom#option('auto_complete_delay', 200)
" call deoplete#custom#option({
" \ 'refresh_always': v:false, 
" \ 'auto_complete_delay': 200,
" \ })
" call deoplete#custom#var('enable_buffer_path', v:false)


""" Lightline
set noshowmode

""" COLORIZER
" let g:colorizer_auto_color = 1
map <leader>C :ColorToggle<CR>

""" --- Uninstalled ---
"""" Nerdcommenter
" let g:NERDSpaceDelims = 1

""" crtlp.vim
" let g:ctrlp_user_command = 'find %s -maxdepth 3 -type f'

""" Neomake
" let g:neomake_python_enabled_makers = ['pylint']
" call neomake#configure#automake('nrwi', 500)

""" Gruvbox
" colorscheme gruvbox
" set background=dark
" let g:gruvbox_contrast_dark = 'medium'
" let g:gruvbox_italic = 1
" let g:gruvbox_contrast_dark = 'hard'


colorscheme molokai
" colorscheme seoul256

highlight Normal ctermbg=NONE guibg=NONE
" Do some tricks to highlight only the number of line
set cursorline
highlight clear CursorLine

" indentline
let g:indentLine_color_gui = '#A4E57E'
" https://vi.stackexchange.com/questions/12520/markdown-in-neovim-which-plugin-sets-conceallevel-2
let g:indentLine_fileTypeExclude = ['markdown']
