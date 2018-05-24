" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree',{ 'on':  'NERDTreeToggle' }
Plug 'weynhamz/vim-plugin-minibufexpl'
Plug 'scrooloose/nerdcommenter'
Plug 'Chiel92/vim-autoformat'
Plug 'luochen1990/rainbow'
Plug 'easymotion/vim-easymotion'
Plug 'jmcantrell/vim-virtualenv'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'vim-scripts/JavaScript-Indent'
" Plug 'jsfaint/gen_tags.vim'
" Plug 'majutsushi/tagbar'

"Plug 'vim-syntastic/syntastic'
"Plug 'davidhalter/jedi-vim'

Plug 'Valloric/YouCompleteMe'

" Initialize plugin system
call plug#end()

" Put your non-Plugin stuff after this line
"=============================== end of vim-Plug===========================

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
	" Prevent that the langmap option applies to characters that result from a
	" mapping.  If unset (default), this may break plugins (but it's backward
	" compatible).
	set langnoremap
endif

" ========================Config from amix[github/amix]===================
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nu
set autoread

let mapleader = ","
let g:mapleader = ","

" => Hotkey
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving and close
nmap <leader>w :w<cr>
cmap w!! w !sudo tee >/dev/null %
nmap <leader>q :q<cr>

" Move between Windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" F2 行号开关
"nnoremap <F2> :call HideNumber()<CR>
nnoremap <F2> :set number! number?<CR>

" F4 换行开关
nnoremap <F4> :set wrap! wrap?<CR>

" Quickly Run
"nnoremap <F5> <Esc>:w<CR>:!g++ -std=c++11 % -o /tmp/a.out && /tmp/a.out<CR>
nnoremap <F5> :call CompileAndRun()<CR>

" => Plugin 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open NERD Tree
map <C-n> :NERDTree<cr>
autocmd vimenter * if !argc() | NERDTree | endif

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 2
let g:ycm_confirm_extra_conf = 0
let g:ycm_warning_symbol = '>*'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_invoke_completion = ''
map <F9> :YcmCompleter FixIt<CR>

let g:virtualenv_directory = '~/.local'

" auto-format
let g:autoformat_verbosemode = 1
let g:formatdef_clangformat = "'clang-format -style=WebKit'"
noremap <F3> :Autoformat<CR>
"nnoremap <F3> <Esc>:w<CR>:!clang-format -style=WebKit -i %<CR><CR>

" rainbow
let g:rainbow_active = 1 
"0 if you want to enable it later via :RainbowToggle"

" tagbar
nmap <F8> :TagbarToggle<CR>

" syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0

" => VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu
set wildignore=*.o,*~,*.pyc
if has("win32")
	set wildignore+=*/.git/*
else
	set wildignore+=.git\*
endif

"set cmdheight = 2

set hid
set whichwrap+=h,l

set ignorecase
set smartcase

set lazyredraw

set magic

set showmatch

set noerrorbells
set novisualbell
set t_vb=
set tm=500
" 光标上下行至少保留的行数
set scrolloff=5

" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set termencoding=utf-8

" 如遇 Unicode > 255 的文本，不必等到空行再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B

" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowb
set noswapfile

" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4

set lbr
set tw=500

set ai
set si
set wrap

" => Others
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 让补全菜单行为与一般IDE一致
set completeopt=longest,menu
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"

" => Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 状态行显示的内容
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h%w
set statusline+=\ [%Y,%{strlen(&fenc)?&fenc:&enc},%{&ff}]
set statusline+=\ [CWD:%{getcwd()}]
set statusline+=\ \ [POS=%l,%v][%p%%]
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=\ %=[%{strftime(\"%d/%m/%y\ -\ %H:%M\")}]  

" => Helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	endif
	return ''
endfunction

function! CompileAndRun()
	exec "w"
	if &filetype == 'c'
		exec '!gcc % -o /tmp/%< && time /tmp/%<'
	elseif &filetype == 'cpp'
		exec '!g++ -std=c++11 % -o /tmp/%< && time /tmp/%<'
	elseif &filetype == 'python'
		exec '!time python %'
	elseif &filetype == 'lua'
		exec '!time lua %'
	endif
endfunction

function! HideNumber()
	if(&relativenumber == &number)
		set relativenumber! number!
	elseif(&number)
		set number!
	else
		set relativenumber!
	endif

	set number?
endfunction
