" Enable true color
set termguicolors
set number relativenumber
" To display file path in window manager env
set title
" Indent a.k.a. tab
set tabstop=4 softtabstop=4
set shiftwidth=4
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
" set expandtab
set smartindent
" noswap/nobackup
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
" allow hidden buffer
set hidden
" set as default in nvim
syntax on
set incsearch
" ruler
set colorcolumn=81 		" Ruler; mark above 80 as red
set textwidth=80
set formatoptions-=t
autocmd FileType gitcommit setlocal tw=72
autocmd FileType gitcommet setlocal formatoptions-=t
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
" Explore
map <leader>lf :Texplore<CR>
nnoremap <leader>f :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
" Search&replace using . (Greg Hurrell)
"nnoremap c* *Ncgn
"nnoremap S :%s//gc<Left><Left><Left>
" Spellchecker
map <leader>se :setlocal spell! spelllang=en_us<CR>
map <leader>sf :setlocal spell! spelllang=fr<CR>
" Automatically deletes all trailing whitespace and newlines at end of file on save. (Luke Smith)
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e
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
" Deoplate; asynchronous completion framework for
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Deoplete-jedi; auto-completion for Python;`pip install jedi`
Plug 'zchee/deoplete-jedi'
" jedi-vim; Awesome Python autocompletion with VIM
Plug 'davidhalter/jedi-vim'
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
" seoul256.vim; Colorscheme by junegunn
Plug 'junegunn/seoul256.vim'
" Scalpel; Fast within-file word replacement for Vim
Plug 'wincent/scalpel'

""" --- Uninstalled ---
" " Denite features
" Plug 'Shougo/denite.nvim'
" " Nerdcommenter; intensely nerdy commenting powers
" "		>>>> Malware! Make quitting vim significantly slow
" Plug 'preservim/nerdcommenter'
" " Vim-css-color; Preview colours in source code while editing
" Plug 'ap/vim-css-color'
" " Neomake; Asynchronous linting and make framework for Neovim/Vim
" Plug 'neomake/neomake'
" " Gruvbox; Retro groove color scheme for Vim
" Plug 'morhetz/gruvbox'
" " crtlp.vim; Fuzzy file, buffer, mru, tag, etc finder
" Plug 'ctrlpvim/ctrlp.vim'
call plug#end()


""""" --- Plugin Settings ---
""" Autocompletion
""" jedi
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_command = "<leader>gd"
let g:jedi#usages_command = "gu"
let g:jedi#auto_close_doc = 1
" autocmd FileType python setlocal completeopt-=preview
""" deoplete
let g:deoplete#enable_at_startup = 1
" https://github.com/Shougo/deoplete.nvim/issues/1134#issuecomment-707438507
call deoplete#custom#option({
      \ 'auto_refresh_delay': 10,
      \ 'camel_case': v:true,
      \ 'skip_multibyte': v:true,
      \ 'auto_preview': v:true,
      \ })
call deoplete#custom#option('num_processes', 2)
inoremap <expr> <C-Space> deoplete#complete()

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

" Use <Leader>s instead of default <Leader>e:
nmap S <Plug>(Scalpel)

""" --- Uninstalled ---
""" Nerdcommenter
" let g:NERDSpaceDelims = 1
""" Neomake
" let g:neomake_python_enabled_makers = ['pylint']
" call neomake#configure#automake('nrwi', 500)

""" --- Colorscheme ---
" " A bit modified molokai .config/nvim/colors/molokai.vim
" colorscheme molokai
let g:seoul256_background = 235
colorscheme seoul256
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
