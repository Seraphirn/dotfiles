set nocompatible              " be iMproved, required
filetype off 
let mapleader=";"
let $VIMFILES='~/.vim'
"let NERDTreeIgnore=['^[A-B].*', '^[D-Z].*', '^Ca.*', '^Co.*', '^CT.*', '\~$']

set rtp+=$VIMFILES/bundle/Vundle.vim
call vundle#begin($VIMFILES.'/bundle/')

Plugin 'git://github.com/VundleVim/Vundle.vim'
Plugin 'git://github.com/tomasr/molokai'
Plugin 'git://github.com/scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'git://github.com/scrooloose/syntastic'
Plugin 'git://github.com/scrooloose/nerdcommenter'
Plugin 'git://github.com/kien/ctrlp.vim'
Plugin 'git://github.com/easymotion/vim-easymotion'
Plugin 'git://github.com/szw/vim-tags'
Plugin 'git://github.com/dkprice/vim-easygrep'
Plugin 'git://github.com/skwp/greplace.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'git://github.com/amiorin/vim-project'

Plugin 'git://github.com/godlygeek/tabular'
Plugin 'git://github.com/plasticboy/vim-markdown'
Plugin 'git://github.com/tpope/vim-repeat'
Plugin 'git://github.com/Houl/vim-repmo'
Plugin 'git://github.com/tpope/vim-surround'
Plugin 'git://github.com/christoomey/vim-tmux-navigator'

"Plugin 'git://github.com/szymonmaszke/vimpyter'
"Plugin 'git://github.com/goerz/jupytext.vim'
Plugin 'git://github.com/gabenespoli/vim-jupycent'

"Plugin 'git://github.com/szymonmaszke/vimpyter'

"Plugin 'git://github.com/mtscout6/syntastic-local-eslint.vim'

"Plugin 'garbas/vim-snipmate'            " Snippets manager
"Plugin 'MarcWeber/vim-addon-mw-utils'   " dependencies #1
"Plugin 'tomtom/tlib_vim'                " dependencies #2
"Plugin 'honza/vim-snippets'             " snippets repo
 
" --- Python ---
Plugin 'git://github.com/Vimjas/vim-python-pep8-indent'
"Plugin 'git://github.com/klen/python-mode'               " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
"Plugin 'git://github.com/davidhalter/jedi-vim'           " Jedi-vim autocomplete plugin
"Plugin 'mitsuhiko/vim-jinja'            " Jinja support for vim
"Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim

" --- PHP ----
"Plugin 'git://github.com/shawncplus/phpcomplete.vim.git'
"Plugin 'git://github.com/2072/php-indenting-for-vim'
"Plugin 'git://github.com/StanAngeloff/php.vim.git'

"-----Js---
Plugin 'git://github.com/mxw/vim-jsx'
"Plugin 'git://github.com/elzr/vim-json'
Plugin 'git://github.com/pangloss/vim-javascript'
"Plugin 'git://github.com/mtscout6/syntastic-local-eslint.vim'
"
Plugin 'git://github.com/leafgarland/typescript-vim'
Plugin 'git://github.com/peitalin/vim-jsx-typescript'
Plugin 'git://github.com/tell-k/vim-autopep8'


call vundle#end()            " required

"function! TabTitle()
    "let title = expand("%:p:t")
    "let t:title = exists("b:title") ? strpart(b:title,0,4) . '|' . title  : title
"endfunction
function! TabTitle()
    let title = expand("%:p:t")
    let t:title = title
endfunction

function! SetGuiTabLabel(var) abort
    set guitablabel=%{GuiTabLabel()}
endfunction

function! GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)

    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor

    " Append the number of windows in the tab page if more than one
    let wincount = tabpagewinnr(v:lnum, '$')
    if wincount > 1
        let label .= wincount
    endif
    if label != ''
        let label .= ' '
    endif

    " Append the buffer name
    return label . bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
endfunction


"autocmd TabEnter *.php,*.tpl.*.css,*.js :NERDTree | :winc p | :NERDTreeFind | :winc p


"autocmd BufReadPost *
"			\ if line("'\"") > 1 && line("'\"") <= line("$") |
"			\   exe "normal! g`\"" |
"			\ endif

" close nerdtree tabs and save session on close vim
"autocmd VimLeave * NERDTreeTabsClose
"autocmd VimLeave * if argc() == 0 | mksession! $VIMFILES/last.session | endif
"

"autocmd WinLeave * NERDTreeClose

" I don't want the docstring window to popup during completion
"autocmd FileType python setlocal completeopt-=preview

filetype plugin indent on

if has('gui_running')
	syntax on
	set background=dark
	colorscheme molokai
else
	syntax on
	set t_Co=256
	" mc like sheme
	colorscheme molokai
	"dont ask why - just need it on consoles
	"set background=light
	"set background=dark
endif

let NERDTreeWinSize=30
let g:nerdtree_tabs_open_on_gui_startup=0
let g:nerdtree_tabs_open_on_new_tab=0

"let php_folding = 1
"let php_noShortTags = 1
"let php_parent_error_close = 1
"let php_parent_error_open = 1

let g:EasyGrepReplaceWindowMode=2
let g:EasyGrepSearchCurrentBufferDir=0
let g:EasyGrepRecursive=1
let g:EasyGrepIgnoreCase=1
let g:EasyGrepCommand=1
let g:EasyGrepFilesToExclude=".svn,.git,*/tmp/*,*.so,*.swp,*.zip,*pycache*,*node_modules*,*pyvenv*,*build*,*dump*,*.js*,*.css*,*.svg"

let g:ctrlp_working_path_mode='a'
"let g:ctrlp_custom_ignore = '*(node_modeles|pyvenv).*'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*pycache*,*/node_modules/*,*/pyvenv/*,*/build/*,*dump*,*.log,*.xml

let NERDTreeIgnore=['\.pyc$', '\~$']

let g:NERDDefaultAlign = 'left'
let g:NERDTreeQuitOnOpen = 3

"let g:pdv_template_dir = $VIMFILES."/bundle/pdv/templates"

let g:airline_theme = 'base16_bright'
"let g:airline_inactive_collapse=1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#tab_nr_type = 1
"let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#show_tab_type = 0
"let g:airline#extensions#tabline#show_splits = 0
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#keymap_ignored_filetypes = ['vimfiler', 'nerdtree']
"let g:airline#extensions#tabline#show_close_button = 0
"let airline#extensions#tabline#ignore_bufadd_pat =
"            \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'

let g:airline_left_sep=''
let g:airline_right_sep=''

"let g:pymode_python = 'python'
"let g:jsx_ext_required = 0
"let g:jedi#completions_command = "<C-N>"


" Syntactic
let g:syntastic_mode_map = { 'mode': 'active',
                          \ 'active_filetypes': ['python'],
                          \ 'passive_filetypes': ['javascript'] }
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_loc_list_height = 4 

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

"let g:syntastic_python_checkers = ['prospector', 'mypy']
let g:syntastic_python_checkers = ['flake8', 'bandit']
let g:syntastic_php_checkers = ['php', 'phpcs']
autocmd FileType php let g:syntastic_php_phpcs_args = '--standard=' . getcwd() . '/.phpstandart.xml'
" E501 -  is for line lenght warning
"autocmd FileType py let g:syntastic_python_flake8_args = '--ignore=E501'
let g:syntastic_python_flake8_args = '--ignore=E501'
"let g:syntastic_python_flake8_ignore = 'E501'

let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
"let g:syntastic_javascript_eslint_exe = 'npm run lint --'
" -Syntactic
"let g:syntastic_ignore_files = ['kdp_attack_manager']

let g:vim_tags_project_tags_command='{CTAGS} -R {OPTIONS} --exclude=pyvenv --exclude="*.min.js" --exclude=node_modules --exclude=build --exclude=dist {DIRECTORY} 2>/dev/null'
let g:autopep8_aggressive=1
let g:autopep8_disable_show_diff=1

set ff=unix
set ffs=unix,dos
"set ffs=unix,dos
set fileencoding=utf-8
set encoding=utf-8
" Отображение кириллицы во внутренних сообщениях программы
" lan mes ru_RU.UTF-8
" Отображение кириллицы в меню
" source $VIMRUNTIME/delmenu.vim
" set langmenu=ru_RU.UTF-8
" source $VIMRUNTIME/menu.vim

set listchars=tab:.\ ,trail:~
set list
set number relativenumber
set incsearch
set nohlsearch

set tabstop=2
set shiftwidth=2
set softtabstop=2

autocmd BufRead,BufNewFile *.php setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4

set colorcolumn=120
autocmd Filetype python setlocal colorcolumn=80
autocmd Filetype php setlocal colorcolumn=100

set smarttab
set smartindent
set expandtab
set showcmd
set mouse=a
set so=10
set noautowrite
set timeout timeoutlen=2000 ttimeoutlen=100

"set sessionoptions=curdir,help,resize,winpos,winsize,tabpages
set guioptions=ia
set gdefault
set ignorecase
set laststatus=2
set guifont=:h13:cRUSSIAN
set guifont=Dejavu\ Sans\ Mono\ 13
"set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

"func! MyFoldText()
  "let count_lines = v:foldend - v:foldstart - 1
  "let line_start = substitute(getline(v:foldstart), '/\*\|\*/\|{{{\d\=', '', 'g')
  "let line_end = substitute(getline(v:foldend), '/\*\|\*/\|{{{\d\=', '', 'g')
  "return v:folddashes . line_start . '  ' . count_lines . " lines   " . line_end
"endfunction
"set foldmethod=manual
"set foldlevel=1
"set fillchars=vert:\|
"set foldtext=MyFoldText()
set nofoldenable

"set foldminlines=0
map <Leader> <Plug>(easymotion-prefix)
nmap <C-]> g<C-]>
nmap <C-p> :CtrlP getcwd()<CR>
nmap <A-f> :tab Grep<Space>
" updat CtrlP cache and update ctgs
nmap <Leader>re :CtrlPClearAllCache<CR>
nmap <Leader>tf :NERDTreeFind<CR>
nmap <Leader>z :1,1000bw<CR>
map <Leader>y "+y
map <Leader>p "+p
map <A-l> :tabn<CR>
map <A-h> :tabp<CR>
map <Leader>H :tabmove -1<CR>
map <Leader>L :tabmove +1<CR>
"map <Leader>h <C-w>h:vertical res 120<CR> 
"map <Leader>l <C-w>l:vertical res 120<CR>
nmap <leader>1 :tabn 1<CR>
nmap <leader>2 :tabn 2<CR>
nmap <leader>3 :tabn 3<CR>
nmap <leader>4 :tabn 4<CR>
nmap <leader>5 :tabn 5<CR>
nmap <leader>6 :tabn 6<CR>
nmap <leader>7 :tabn 7<CR>
nmap <leader>8 :tabn 8<CR>
nmap <leader>9 :tabn 9<CR>
nmap <leader>qa :%s/\s\+$//ge<CR>:%s/\ \+\t/\t/ge<CR>
nmap <leader>s :vertical res 120<CR>
nmap <leader>n :lnext<CR>
nmap <leader>N :lprevious<CR>
nmap <leader>lo :lopen 4<CR>
nmap <leader>lc :lclose<CR>

nmap <leader><leader>w :tabnew<CR>:Welcome<CR>
nmap <leader><leader>W :tabnew<CR>:Welcome<CR>

nmap <leader>st :SyntasticToggleMode<CR>
nmap <leader>sc :SyntasticCheck<CR>
nmap <leader>ts :SyntasticToggleMode<CR>
nmap <F2> :SyntasticCheck<CR>

" Autopep8 one line without fix line length
nmap <leader>ap :<C-u>call Autopep8("--ignore=E501 --range " . line(".") . " " . line("."))<CR>

" Autopep8 one line
nmap <leader>aP :<C-u>call Autopep8("--range " . line(".") . " " . line("."))<CR>

" Autopep8 selected lines without fix line length
xmap <leader>ap :<C-u>call Autopep8("--ignore=E501 --range " . line("'<") . " " . line("'>"))<CR>

" Autopep8 selected lines
xmap <leader>aP :<C-u>call Autopep8("--range " . line("'<") . " " . line("'>"))<CR>

" Autopep8 all file without fix line length
nmap <F3> :call Autopep8("--ignore=E501")<CR>

" Open .vimrc
nmap <leader><leader>v :tabedit $MYVIMRC<CR>

" Open terminal in directory of current open file
nmap <leader><leader>t :call system("ST_PATH=" . expand('%:p:h') . " " . $TERMINAL)<CR><CR>

" Open terminal in directory of current open file and start jupyter server if 
" has one
nmap <leader><leader>s :call system("ST_PATH=" . expand('%:p:h') . " ST_COM='make start-jupyter' " . $TERMINAL)<CR><CR>

command W write

abclear
iabbrev /** /**<CR><CR>/<UP>
iabbrev pdb import pdb; pdb.set_trace()
iabbrev p_r print '<pre>' . print_r(, true) . '</pre>'; exit;

if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif

" clear useless spaces
autocmd BufWrite *.py,*.php,*.html,*.js,*.txt,*.ipynb,*.md :%s/\s\+$//ge
" before tab too
autocmd BufWrite *.py,*.php,*.html,*.js,*.txt,*.ipynb,*.md :%s/\ \+\t/\t/ge

autocmd BufWritePost ~/projects/dwmblocks/blocks.h !cd ~/projects/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
