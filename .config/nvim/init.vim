set number
set tabstop=4
set shiftwidth=4
" set expandtab

" moving split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" defulat split direction
set splitbelow
set splitright

" ruler
set colorcolumn=81 		" Ruler; mark above 80 as red

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
" Nerdcommenter
" 	Vim plugin for intensely nerdy commenting powers
Plug 'preservim/nerdcommenter'
" Lightline
" 	A light and configurable statusline/tabline plugin for Vim	
Plug 'itchyny/lightline.vim'
" COLORIZER
" 	A plugin to color colornames and codes
Plug 'chrisbra/colorizer'

""" --- Uninstalled ---
" " Vim-css-color
" " 	Preview colours in source code while editing
" Plug 'ap/vim-css-color'
" " Deoplete-jedi
" " 	Provide auto-completion for Python
" " 	`pip install jedi`
" Plug 'zchee/deoplete-jedi'
" " Neomake
" " 	Asynchronous linting and make framework for Neovim/Vim
" Plug 'neomake/neomake'
" " Gruvbox
" " 	Retro groove color scheme for Vim
" " Plug 'morhetz/gruvbox'
" " Auto-paris
" " 	Vim plugin, insert or delete brackets, parens, quotes in pair
" Plug 'jiangmiao/auto-pairs'
call plug#end()

""""" --- Plugin Settings ---
""" Autocompletion
let g:deoplete#enable_at_startup = 1

""" Nerdcommenter
let g:NERDSpaceDelims = 1

""" Lightline
set noshowmode

""" COLORIZER
" let g:colorizer_auto_color = 1

""" --- Uninstalled ---
""" Neomake
" let g:neomake_python_enabled_makers = ['pylint']
" call neomake#configure#automake('nrwi', 500)

""" Gruvbox
" colorscheme gruvbox
" set background=dark
" let g:gruvbox_contrast_dark = 'medium'
" let g:gruvbox_italic = 1
" let g:gruvbox_contrast_dark = 'hard'
