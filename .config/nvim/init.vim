let mapleader=";"
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" Plug 'git://github.com/VundleVim/Vundle.vim'
Plug 'tomasr/molokai'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim'
Plug 'easymotion/vim-easymotion'

Plug 'dkprice/vim-easygrep'
Plug 'skwp/greplace.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'amiorin/vim-project'
Plug 'bkad/CamelCaseMotion'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'Houl/vim-repmo'
Plug 'tpope/vim-surround'
"Plug 'gabenespoli/vim-jupycent'
"Plug 'tell-k/vim-autopep8'
Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) }}

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale' " Линтинг и форматирование
Plug 'antoinemadec/FixCursorHold.nvim'
"Plug 'puremourning/vimspector'
Plug 'vim-ctrlspace/vim-ctrlspace'
"Plug 'bagrat/vim-buffet'
"Plug 'yaegassy/coc-ruff', {'do': 'yarn install --frozen-lockfile'}

Plug 't9md/vim-choosewin'

"Plug 'fatih/vim-go'
"Plug 'ki11errabbit/vim-colemak-dh'
call plug#end()

" ------------------------------------------VIM commong settings-------------------------------------
" Set titile of window of vim
set title
" Hide usless toolbars and menues. a means that visual selections may be
" copiend using standart terminal commands
"set go=a
" Enabling mouse support for all modes
set mouse=a
" Stop hightlite search
set nohlsearch
" Use global keyboard clipboard in vim
set clipboard+=unnamedplus
" Show current mode you are in
set showmode
" Disable show of position of text cursor in left corner
set noruler
" Disable laststatus
set laststatus=0
" User unix-based EOL symbol on file write
set fileformat=unix
" User unix- and dos-based EOL symbol for reading file
set fileformats=unix,dos
" Encoding always utf-8
set fileencoding=utf-8
set encoding=utf-8
set hidden
" Do not put text to any register when using command c
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc
" Ensure to work in nomopatible with old vim version mode
set nocompatible
" Enabling filetype detection with indent and plugin suport
filetype plugin indent on
" Enable syntax highlight
syntax on
" Set molokai colorscheme
colorscheme gruvbox
"colorscheme molokai
"colorscheme afterglow
"colorscheme PaperColor
"colorscheme purify
" Set color groups and font
if has('gui_running')
  set background=dark
  set guifont=:h12:cRUSSIAN
  set guifont=Monospace\ 12
else
  set t_Co=256
endif
" ------- Firenvim settings ---------"
"if exists('g:started_by_firenvim')
  "set guifont=Monospace:h11
  "set noshowmode
  "set noruler
"endif

function! SetLinesForFirefox(timer)
    set lines+=3
endfunction

function! OnUIEnter(event) abort
  if 'Firenvim' ==# get(get(nvim_get_chan_info(a:event.chan), 'client', {}), 'name', '')
    set guifont=Monospace:h11
    call timer_start(100, function("SetLinesForFirefox"))
  endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

" Show relative line number on left and absolute line number for current line
set number
" Enable command line autocompletion:
set wildmode=longest,list,full
" Ignore those files in wildcard
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*pycache*,*/node_modules/*,*/pyvenv/*,*/venv/*,*/build/*,*dump*,*.log,*.xml

" Set some autowrap text options for comments
set formatoptions=cqjro
" Set textwitdh options and visible indicators
set colorcolumn=101 textwidth=101
autocmd Filetype python setlocal colorcolumn=101 textwidth=101
autocmd Filetype php setlocal colorcolumn=101 textwidth=101
" Splits open at the bottom and right
set splitbelow splitright
" See tabs and trail spaces to DELETE THIS SHIT
set list
set listchars=tab:.\ ,trail:~
"While typing a search command, show where the pattern
set incsearch
"Set tab settings
set tabstop=4 shiftwidth=4 softtabstop=4 smarttab smartindent expandtab
autocmd BufRead,BufNewFile *.php,python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.js setlocal tabstop=2 shiftwidth=2 softtabstop=2
" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5
" Show (partial) command in the last line of the screen
set showcmd
" Write the contents of the file, if it has been modified, on each :next, :rewind, :last, :first, :previous,
" :stop, :suspend, :tag, :!, :make, CTRL-] and CTRL-^ command
set noautowrite
" Set timeouts for entering commands in normal mod
set timeout timeoutlen=2000 ttimeoutlen=100
" When on, the ':substitute' flag 'g' is default on.
set gdefault
" ignorecase by default
set ignorecase
" Fold options
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"set nofoldenable
" ------------Firenvim - for firefox ------
let g:firenvim_config = { 
    \ 'localSettings': {
        \ '.*': {
            \ 'priority': 0,
            \ 'takeover': 'never',
        \ },
    \ }
\ }

" ---------NerdTree options---------
let NERDTreeWinSize=30
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeQuitOnOpen = 3
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer=1
if has('nvim')
  let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
else
  let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
endif
nmap <Leader>tt :NERDTreeToggle<CR>
nmap <Leader>tf :NERDTreeFind<CR>
nmap <Leader>df :NERDTreeFind<CR>

" ----------NerdCommenter-----------
let NERDDefaultAlign = 'left'

" ---------EasyGrep settings---------
let g:EasyGrepReplaceWindowMode=2
let g:EasyGrepSearchCurrentBufferDir=0
let g:EasyGrepRecursive=1
let g:EasyGrepIgnoreCase=1
let g:EasyGrepCommand=1
let g:EasyGrepFilesToExclude=".svn,.git,*/tmp/*,*.so,*.swp,*.zip,*pycache*,*node_modules*,*pyvenv*,*build*,*dump*,*.js*,*.css*,*.svg,*notebooks*,.ipynb,release_agents,.md,.txt,*/venv/"
"nnoremap <leader>V <c-W>s<c-W>T:execute 'Grep ' . expand('<cword>')<CR>
nnoremap <leader>V <c-W>s<c-W>T:execute 'vimgrep ' . expand('<cword>') . ' **/*.py \| copen 6'<CR>

" ---------CtrlP settings---------
let g:ctrlp_working_path_mode='a'
nmap <c-p> :CtrlP getcwd()<CR>
"nmap <Leader>re :CtrlPClearAllCache<CR>:TagsGenerate!<CR>
nmap <Leader>re :CtrlPClearAllCache<CR>:GutentagsUpdate!<CR>

" ---------Airline setting---------
let g:airline_theme = 'onedark'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#whitespace#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = 'Ξ'
let g:airline_symbols.colnr = ''
let g:airline_exclude_preview = 1

" ------------Ctrlspace---------
" hide tabline
"set showtabline=0
"let g:CtrlSpaceEnableFilesCache = 1
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceDefaultMappingKey = "<C-space> "
let g:CtrlSpaceSearchTiming = 1
"let g:CtrlSpaceKeys = { "Buffer": { "a": "PrintFooBar" } }

" ---------COC.nvim Autocompition------------
" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" keywords for scroll doc float window
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

" Coc extensions
" asdfgqwertzxcvbhjkl;'nnm,./j
"
let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-markdownlint', 'coc-go']
"autocmd FileType python let b:coc_root_patterns = ['.git', '.env', '.flake8']  " add .env to test folder

" --------- ALE --------
let g:ale_linters = {'python': ['ruff'], 'sql': ['sqlfluff']}
"let g:ale_linters = {'python': ['ruff']}



" --------- Vimspector -----------
"let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = ['debugpy']

"nmap <F5> <Plug>VimspectorContinue
"nmap <F3> <Plug>VimspectorStop
"nmap <leader><F3> :VimspectorReset<CR>
"nmap <F4> <Plug>VimspectorRestart
"nmap <F6> <Plug>VimspectorPause

"nmap <F9> <Plug>VimspectorToggleBreakpoint
"nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
"nmap <F8> <Plug>VimspectorAddFunctionBreakpoint
"nmap <leader><F8> <Plug>VimspectorRunToCursor

nmap <leader>ds <Plug>VimspectorContinue
nmap <leader>dS <Plug>VimspectorRestart

"nmap <leader>s <Plug>VimspectorContinue
nmap <leader>S <Plug>VimspectorRestart

nmap <leader>dd :VimspectorReset<CR>
nmap <leader>dp <Plug>VimspectorPause
nmap <leader>dx <Plug>VimspectorStop

nmap <leader>da <Plug>VimspectorToggleBreakpoint
nmap <leader>dbc <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>dbf <Plug>VimspectorAddFunctionBreakpoint
nmap <leader>dB :call vimspector#ClearBreakpoints()<CR>
nmap <leader>dr <Plug>VimspectorRunToCursor
nmap <leader>J <Plug>VimspectorRunToCursor

nmap <F10> <Plug>VimspectorStepOver
nmap <leader>j <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <leader>l <Plug>VimspectorStepInto
nmap <F12> <Plug>VimspectorStepOut
nmap <leader>h <Plug>VimspectorStepOut


" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

nmap <Leader>de :VimspectorEval<space>
nmap <Leader>v :VimspectorEval<space>
nmap <Leader>dw :VimspectorWatch<space>
nmap <Leader>dw :VimspectorWatch<space>

let g:vimspector_sidebar_width = 35
let g:vimspector_bottombar_height = 10

let g:vimspector_code_minwidth = 100
let g:vimspector_terminal_maxwidth = 20
let g:vimspector_terminal_minwidth = 10

" -------- Choosewin --------
nmap - <Plug>(choosewin)
"nmap <leader>ss <Plug>(choosewin)

" ---------Autopep 8 settings---------
"let g:autopep8_aggressive=1
"let g:autopep8_disable_show_diff=1
"let g:autopep8_max_line_length=99
"" Autopep8 one line without fix line length
"nmap <leader>ap :<C-u>call Autopep8("--ignore=E501 --range " . line(".") . " " . line("."))<CR>
"" Autopep8 one line
"nmap <leader>aP :<C-u>call Autopep8("--range " . line(".") . " " . line("."))<CR>
"" Autopep8 selected lines without fix line length
"xmap <leader>ap :<C-u>call Autopep8("--ignore=E501 --range " . line("'<") . " " . line("'>"))<CR>
"" Autopep8 selected lines
"xmap <leader>aP :<C-u>call Autopep8("--range " . line("'<") . " " . line("'>"))<CR>

"nmap <leader><leader>ap :call Autopep8("--ignore=E501")<CR>
"nmap <leader><leader>aP :call Autopep8()<CR>

" ---------Else extention settings---------
" Ctags commang
"let g:vim_tags_project_tags_command='{CTAGS} -R {OPTIONS} --python-kinds=-i --exclude=pyvenv --exclude="*.min.js" --exclude=node_modules --exclude=build --exclude=dist --exclude=notebooks {DIRECTORY} 2>/dev/null'
"let g:vim_tags_ctags_binary='/usr/local/bin/ctags'

"vim-tags options
"let g:vim_tags_project_tags_command='{CTAGS} -R {OPTIONS} --languages=python --python-kinds=-i {DIRECTORY} 2>/dev/null'
"let g:vim_tags_directories = ['.git']
"let g:vim_tags_ignore_files = ['*pyvenv*', '*.min.js', '*node_models*', '*/.*', '*build*', '*dist', '*notebooks*']
"let g:vim_tags_auto_generate = 0

"let g:gutentags_exclude_filetypes = ['*pyvenv*', '*.min.js', '*node_models*', '*/.*', '*build*', '*dist', '*notebooks*']
"let g:gutentags_project_root = ['package.json', '.git']
""call add(g:gutentags_project_info, {'type': 'python', 'file': 'pyproject.toml'})
""let g:gutentags_ctags_executable_python = 'cscope'
"let g:gutentags_ctags_extra_args = [
"      \ '--tag-relative=yes',
"      \ '--python-kinds=-i',
"      \ '--fields=+imnS',
"      \ ]



" -------------------------------------------------------REMAPS-----------------------------------------------
"
" ---------All remaps---------
" Replace ex mode with gq
map Q gq

" Reset leader as easymotion key
"map <Leader> <Plug>(easymotion-prefix)
map <Leader>w <Plug>(easymotion-bd-w)
map <Leader>W <Plug>(easymotion-bd-W)
map <Leader>f <Plug>(easymotion-bd-f)
map <Leader>e <Plug>(easymotion-bd-e)
map <Leader>E <Plug>(easymotion-bd-E)
map <Leader>g <Plug>(easymotion-jumptoanywhere)
"let g:EasyMotion_keys = 'asdfghjkl;qwertyuiopzxcvbnm'
let g:EasyMotion_keys = 'asdfghjkl;qweruiopvncm'


" ---------Visual mode remaps---------
" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" ---------Command line mode remaps---------
" paste from +register with ctrl-p
cnoremap <c-p> <c-r>+


" ---------Normal mode remaps----------
" Shortcutting split navigation, saving a keypress:
"nmap <leader>h <C-w>h
"nmap <leader>j <C-w>j
"nmap <leader>k <C-w>k
"nmap <leader>l <C-w>l
" Goto difinition
"nmap <c-]> g<c-]>
"nmap <silent> <c-]> <Plug>(coc-definition)

"nmap <silent> <c-t> <c-o>
set tagfunc=CocTagFunc

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Grep
nmap <c-f> :tab Grep<Space>
" Move tabs right and left DEPRECATED
nmap <Leader>H :tabmove -1<CR>
nmap <Leader>L :tabmove +1<CR>

nmap \ :tabn"<CR>
nmap <Tab> :tabN<CR>
" Goto tabs
nmap <leader>1 :tabn 1<CR>
nmap <leader>2 :tabn 2<CR>
nmap <leader>3 :tabn 3<CR>
nmap <leader>4 :tabn 4<CR>
nmap <leader>5 :tabn 5<CR>
nmap <leader>6 :tabn 6<CR>
nmap <leader>7 :tabn 7<CR>
nmap <leader>8 :tabn 8<CR>
nmap <leader>9 :tabn 9<CR>
" Delete trailing spaces, tabs and mixing tabs
nmap <leader>qa :%s/\s\+$//ge<CR>:%s/\ \+\t/\t/ge<CR>
" Location list
nmap <leader>n :lnext<cr>
nmap <leader>n :lprevious<cr>
" Welcome panel to change projects
nmap <leader><leader>w :tabnew<CR>:Welcome<CR>
nmap <leader><leader>W :Welcome<CR>
" Copy to * clipboard
map <leader>y "*y
map <leader>p "*p

" Open .vimrc
nmap <leader><leader>v :tabedit $MYVIMRC<CR>
" Open local vimrc
nmap <leader><leader>l :tabedit ~/.config/nvim/init.vim.local<CR>

" Open terminal in directory of current open file
nmap <leader><leader>t :call system("ST_PATH=" . expand('%:p:h') . " " . $TERMINAL)<CR><CR>
" Open terminal in directory of current open file and start jupyter server if has one
nmap <leader><leader>s :call system("ST_PATH=" . expand('%:p:h') . " ST_COM='make start-jupyter' " . $TERMINAL)<CR><CR>

" make and install package in current working directory
nmap <leader><leader>i :!make && sudo make install<CR>
" Open terminal in directory of current open file and exec current python file
nmap <leader><leader>p :call system("ST_PATH=" . expand('%:p:h') . " ST_COM='python3 " . expand('%:t') . "' " . $TERMINAL)<CR><CR>

" Isort current file
"nmap <leader>s :!isort .<CR>
nmap <leader>s :!ruff check --fix .<CR>
" Equivivalent of source [current_dir]/pyvenv/bin/activate. add pyvenv/bin to
" $PATH. Replaces old path If executed multiple times
function! SetPyVenv()
  let $VIRTUAL_ENV = expand("%:p:h") . "/pyvenv"
  let s:bin_dir = $VIRTUAL_ENV . "/bin"
  if !exists("g:bin_dir")
    let $PATH = s:bin_dir . ':' . $PATH
  else
    let $PATH = substitute($PATH, g:bin_dir, s:bin_dir, "")
  endif
  let g:python3_host_prog = s:bin_dir . '/python3'
  let g:bin_dir = s:bin_dir
endfunction
nmap <leader><leader>e :call SetPyVenv()<CR>
"nmap <leader><leader>e :call system("source " . expand("%:p:h") . "/pyvenv/bin/activate")<CR>

" Open vim help for word under cursor
nmap <leader><leader>h :exec ("tab help " . expand("<cword>"))<CR>


" ----------------------------------------------------Abbrevs-----------------------------------------------
abclear
iabbrev /** /**<CR><CR>/<UP>
iabbrev pdb import pdb; pdb.set_trace()
iabbrev p_r print '<pre>' . print_r(, true) . '</pre>'; exit;

" ----------------------------------------------------Commands & Autocommands------------------------------
command! W write
" Save file as sudo on files that require root permission. short of sudo write
command! SW execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" apply local virtual env before open ipynv file. That allow gabenespoli/vim-jupycent plugin work because in
" local veirual env have installed its dependency - jupytext
autocmd BufReadPre *.ipynb :call SetPyVenv()


" clear useless spaces
autocmd BufWrite *.py,*.php,*.html,*.js,*.txt,*.ipynb,*.md,*.yaml,*.yml,*.sql :%s/\s\+$//ge
" before tab too
autocmd BufWrite *.py,*.php,*.html,*.js,*.txt,*.ipynb,*.md,*.yaml,*.yml,*.sql :%s/\ \+\t/\t/ge

" Autocompile dwmblocks on saving its conf file
autocmd BufWritePost ~/projects/dwmblocks/blocks.h !cd ~/projects/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

" Show welcome msg on start
if @% == ""
  autocmd VimEnter * :Welcome
endif

" --------------------------------------------------ELSE----------------------------------------

if filereadable(glob("~/.config/nvim/init.vim.local"))

    source ~/.config/nvim/init.vim.local
endif

"Commands
"replace all datetime
"s/\('[0-9- :.]\{16,}'\)/from_utc_timestamp(\1, 'UTC')


" Colemak in insept mode
"inoremap e f
"inoremap E F
"inoremap r p
"inoremap R P
"inoremap t g
"inoremap T G
"inoremap s r
"inoremap S R
"inoremap d s
"inoremap D S
"inoremap f t
"inoremap F T
"inoremap g d
"inoremap G D
"inoremap y j
"inoremap Y J
"inoremap u l
"inoremap U L
"inoremap i u
"inoremap I U
"inoremap o y
"inoremap O Y
"inoremap p ;
"inoremap P :
"inoremap j n
"inoremap J N
"inoremap k e
"inoremap K E
"inoremap l i
"inoremap L I
"inoremap ; o
"inoremap : O
"inoremap n k
"inoremap N K

" Colemak DH changes
" Up/down/left/righ
" nnoremap m h|xnoremap m h|onoremap m h|
" nnoremap n j|xnoremap n j|onoremap n j|
" nnoremap e k|xnoremap e k|onoremap e k|
" nnoremap i l|xnoremap i l|onoremap i l|
" Window handling
" nnoremap <C-W>m <C-W>h|xnoremap <C-W>m <C-W>h|
" nnoremap <C-W>n <C-W>j|xnoremap <C-W>n <C-W>j|
" nnoremap <C-W>e <C-W>k|xnoremap <C-W>e <C-W>k|
" nnoremap <C-W>i <C-W>l|xnoremap <C-W>i <C-W>l|
" Words forward/backward
" nnoremap k e|xnoremap k e|onoremap k e|
" nnoremap K E|xnoremap K E|onoremap K E|
" inSert/Replace/append (T)
"nnoremap l i|
"nnoremap L I|
" nnoremap s i|
" nnoremap S I|
" Search
"  nnoremap h n|xnoremap h n|onoremap h n|
" nnoremap H N|xnoremap H N|onoremap H N|
" todo filebrowser mappings
" join stings
" nmap <s-n> <s-j>

" map <Leader>k <Plug>(easymotion-bd-e)
" map <Leader>K <Plug>(easymotion-bd-E)

" nmap <c-n> :tabn<CR>
" nmap <c-e> :tabN<CR>
"nmap \ :tabn<CR>
"nmap <Tab> :tabN<CR>
" Move tabs right and left
" nmap <Leader><Tab> :tabmove -1<CR>
" nmap <Leader>\ :tabmove +1<CR>
" nmap <Leader>e :tabmove -1<CR>
" nmap <Leader>n :tabmove +1<CR>
"nmap <c-s-E> :tabmove -1<CR>
"nmap <c-s-N> :tabmove +1<CR>

" let NERDTreeMapOpenSplit='l'
" let NERDTreeMapOpenExpl='k'
" let NERDTreeMapMenu='j'
" let NERDTreeMenuDown='n'
" let NERDTreeMenuUp='e'
