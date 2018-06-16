" Vim config
" Gilles
" last modified: 2018-01-21

set nocompatible                " annule compatibilité avec vi
filetype off  									" requis par Vundle

" Plugins management (Vundle) ---------- {{{
" à faire avant tout :
" git clone https://github.com/VundleVim/Vundle.vim.git  ~/.vim/bundle/Vundle.vim

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'bronson/vim-trailing-whitespace'
Plugin 'epeli/slimux'
Plugin 'flazz/vim-colorschemes'
" Plugin 'gaalcaras/ncm-R'
" Plugin 'honza/vim-snippets'
Plugin 'jalvesaq/Nvim-R'
" Plugin 'jimhester/lintr'
" Plugin 'kshenoy/vim-signature'
" Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
" Plugin 'roxma/nvim-completion-manager'
" Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'SirVer/ultisnips'
Plugin 'sukima/xmledit'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'vim-syntastic/syntastic'
" Plugin 'vim-scripts/dbext.vim'
Plugin 'VundleVim/Vundle.vim'
" Plugin 'w0rp/ale'

call vundle#end()

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" }}}

" fzf --------------------- {{{

" --- }}}

" Basic settings ---------- {{{
filetype on                     " active la détection automatique de fichier
filetype plugin on              " active les plugins lors de la détection auto des fichiers
filetype indent on              " indentation auto en fonction du type de fichier

syntax enable                   " active la coloration syntaxique

set mouse=a                     " allow mouse mouvement in vim
set laststatus=2                " display status line always
set noshowmode                  " remove default mode indicator
set wildmenu                    " command line completion
set wildmode=list:longest,full  " command line completion
set relativenumber							" numeros de ligne relatifs
set autochdir										" se mettre dans le rep du fichier en cours d'édition
set encoding=utf-8              " encodage des fichiers == utf-8
set title                       " maj du titre de la fenêtre ou du terminal
set number                      " affiche les numéros de ligne
set ruler                       " affiche la position actuelle du curseur
set wrap                        " affiche les lignes trop longues sur plusieurs lignes
set scrolloff=3                 " affiche un minimum de 3 lignes autour du curseur
set ignorecase                  " ignorer la casse lors d'une recherche
set smartcase                   " réactive la sensibilité à la casse si MAJ dans recherche
set incsearch                   " recherche incrémentale
set nohlsearch                  " ne surligne pas durablement les résultats de recheche
set visualbell                  " effectuer des alertes visuelles et non sonores
set backspace=indent,eol,start  " fixe comportement de la touche <-
set hidden                      " cache les fichiers non sauvegardés lors ouverture de nouveaux fichiers
set autoindent
set tabstop=2
set shiftwidth=2
" set expandtab
set splitbelow									" ouverture des nouveaux split en dessous
set splitright									" ouverture des nouveaux split à droite
set modeline										" active la fonctionalité modeline
set modelines=4									" lire les modelines dans les 4 premières lignes
" }}}

" Persistent undo ---------- {{{
set undofile                		" Save undos after file closes
set undodir=$HOME/.vim/undo 		" where to save undo histories
set undolevels=1000         		" How many undos
set undoreload=10000        		" number of lines to save for undo
" }}}

" Appearance ---------- {{{
colorscheme wombat256i          " couleur theme
autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight Title ctermbg=None
autocmd ColorScheme * highlight StatusLine ctermbg=None
autocmd ColorScheme * highlight LineNr ctermbg=None
let g:airline_theme='dark'
" }}}

" Personnal keymaps ---------- {{{

" Leader & LocalLeader
let mapleader="\\"
let maplocalleader=","

" esc
inoremap ;; <Esc>

" F1 to make file
nnoremap <F1> :w<CR>:make<CR>
inoremap <F1> <esc>:w<CR>:make<CR>

" F2 to pandoc file.md
nnoremap <F2> :!pandoc % -s -o '%:r'.pdf<CR>

" F3 to execute current shell script
nnoremap <F3> :silent :w !bash<CR>
inoremap <F3> <esc>:w !bash<CR>

" F5 to open current buffer in firefox
nnoremap <F5> :!firefox %<CR>

" F7 to xsltproc from xsl : TAB
nnoremap <F7> :!xsltproc % allTEF.xml > allTEF.html; firefox allTEF.html<CR>

" F8 to xsltproc from xml : TAB
nnoremap <F8> :!xsltproc /media/gilles/7871-5411/insee/edore/tests/web4ginseeTab4.xsl % > myfile.html; firefox myfile.html<CR>

" F9 to xsltproc from xsl : GRAPH
nnoremap <F9> :!xsltproc % /media/gilles/7871-5411/insee/edore/tests/graphTEF.xml > myGraph.html; firefox myGraph.html<CR>

" F10 to xsltproc from xml : GRAPH
nnoremap <F10> :!xsltproc /media/gilles/7871-5411/insee/edore/tests/web4ginseeGraph1.xsl % > myGraph.html; firefox myGraph.html<CR>

" F12 to concentration_mode (black background)
nnoremap <F12> :highlight Normal ctermbg=black<CR>
inoremap <F12> <esc>:highlight Normal ctermbg=black<CR>a

" touche (shift) exposant 2 : (previous) next buffer
nnoremap œ :bn<CR>
inoremap œ <Esc>:bn<CR>
nnoremap Œ :bp<CR>
inoremap Œ <Esc>:bp<CR>

" Ctrl-k : insérer une ligne vide au dessus du curseur
nnoremap <C-k> :call append(line('.')-1, '')<CR>

" Ctrl-o : insérer une ligne vide sous le curseur
nnoremap <C-j> :call append(line('.'), '')<CR>

" LocalLeader+p : insert r-cran pipe %>%
inoremap <LocalLeader>p %>%

" localleader+sh : lancer une appli shiny depuis vim
nnoremap <LocalLeader>sh :!R -e "shiny::runApp('%:p:h', launch.browser=TRUE)" <CR>

" Pair completion
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap (  		()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

" Comments
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" .vimrc
nnoremap <LocalLeader>ev :e $MYVIMRC<CR>
nnoremap <LocalLeader>sv :source $MYVIMRC<CR>:echo ".vimrc sourced!"<CR>

" i3config
nnoremap <LocalLeader>ei :e ~/.config/i3/config<CR>

" Xresources
nnoremap <LocalLeader>ex :e ~/.Xresources<CR>
" nnoremap <LocalLeader>sx

" .bash_functions
nnoremap <LocalLeader>ef :e ~/.bash_functions<CR>

" UltiSnips
nnoremap <LocalLeader>eu :UltiSnipsEdit<CR>

" }}}

" FileType specific settings ---------- {{{
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex,Rnw          let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType r                let b:comment_leader = '# '
autocmd FileType xdefaults     		let b:comment_leader = '! '
autocmd FileType sql			     		let b:comment_leader = '-- '

" FileType vim tex sql r
augroup fileType_vim_tex_sql_r
	autocmd!
	autocmd FileType vim,xdefaults,tex setlocal foldmethod=marker
augroup END

" FileType xml html
augroup fileType_xml
	autocmd!
	autocmd FileType xml,html setlocal foldmethod=syntax
augroup END

" " FileType Rmd
" augroup fileType_Rmd
" 	autocmd!
" 	autocmd BufNewFile,BufRead *.Rmd setlocal filetype=markdown
" augroup END

" }}}

" Plugins config ---------- {{{

" Nvim-r
let R_in_buffer = 0
let R_synctex = 0
let R_tmux_split = 1
let R_show_args = 0
let R_show_arg_help = 0
let R_complete = 2
let R_args_in_stline = 1
let R_rconsole_width = 80
let R_min_editor_width = 18
let R_notmuxconf = 1
let R_nvimpager = "tab"
let R_pdfviewer = "evince"
let R_objbr_place = "script,bottom"
map <silent> <LocalLeader>h :call RAction("head")<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" Powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" " Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" " lintr
" let g:syntastic_enable_r_lintr_checker = 1
" let g:syntastic_r_checkers = ['lintr']

" Slimux
nnoremap <LocalLeader>s :SlimuxREPLSendLine<CR>j
inoremap <LocalLeader>s <Esc>:SlimuxREPLSendLine<CR>A
vnoremap <LocalLeader>s :SlimuxREPLSendSelection<CR>
nnoremap <LocalLeader>b :SlimuxREPLSendBuffer<CR>
nnoremap <LocalLeader>a :SlimuxShellLast<CR>
nnoremap <LocalLeader>k :SlimuxSendKeysLast<CR>
nnoremap <LocalLeader>c :SlimuxShellRun clear<CR>

" xmledit
let g:xml_syntax_folding=1

" vim-markdown
let g:markdown_folding=2

" UltiSnips
set runtimepath+=~/.vim/UltiSnips/
" let g:UltiSnipsSnippetDirectories=["~/.vim/UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" }}}

" Functions ---------- {{{

" "Use TAB to complete when typing words, else inserts TABs as usual.
" "Uses dictionary and source files to find matching words to complete.
" "See :help completion for source,
" "Note: usual completion is on <C-n> but more trouble to press all the time.
" "Never type the same word twice and maybe learn a new spellings!
" "Use the Linux dictionary when spelling is in doubt.
" "Window users can copy the file to their machine.
" function! Tab_Or_Complete()
"   if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
"     return "\<C-N>"
"   else
"     return "\<Tab>"
"   endif
" endfunction
" :inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

" }}}

" Misc --- {{{

" A lire
" http://learnvimscriptthehardway.stevelosh.com/
" http://www.moolenaar.net/habits.html

" Twitvim
" let twitvim_enable_perl = 1
" let twitvim_browser_cmd = 'firefox'

" Leader or LocalLeader ?
" https://www.reddit.com/r/vim/comments/4ks9le/do_you_use_localleader_if_yes_how/

" Le remaping des touches Ctrl-Enter / Ctrl-Shift-Enter / Ctrl-m, ...
" http://vim.wikia.com/wiki/Smart_mapping_for_tab_completion
" https://stackoverflow.com/questions/15643234/remapping-tab-completions-in-vim
" https://vi.stackexchange.com/questions/14379/separate-c-m-and-enter
" https://groups.google.com/forum/#!msg/vim_dev/2bp9UdfZ63M/sajb9KM0pNYJ
" When you have a problem about vim mappings.
" Check :verbose inoremap at the first.
" If you know the keys which have problem, then do it with specified key, for
" example :verbose inoremap <esc>.

" Workflow R+vim
" Nvim-r + neocomplete
" https://qiita.com/sk427/items/b7fce4813c85f590d1aa
" voir aussi le plugin SuperTab

" Code Formatter/Beautifier
" https://stackoverflow.com/questions/2506776/is-it-possible-to-format-c-code-with-vim
" HOW TO : :%!astyle --mode=c --style=ansi -s2
" HOW TO : :%!astyle -A2 -s4 -xc -xj -c

" --- }}}
