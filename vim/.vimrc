" Vim config Gilles
" http://learnvimscriptthehardway.stevelosh.com/
" http://www.moolenaar.net/habits.html

set nocompatible                " annule compatibilité avec vi
filetype off  									" requis par Vundle

" Plugins management (Vundle) --- {{{
" require : git clone https://github.com/VundleVim/Vundle.vim.git  ~/.vim/bundle/Vundle.vim
" set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'epeli/slimux'
Plugin 'flazz/vim-colorschemes'
Plugin 'jalvesaq/Nvim-R'
Plugin 'jalvesaq/vimcmdline'
Plugin 'junegunn/fzf.vim'
" Plugin 'jupyter-vim/jupyter-vim'
Plugin 'goerz/jupytext'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
call vundle#end()
" }}}

" Basic settings --- {{{
filetype on                     " active la détection automatique de fichier
filetype plugin on              " active les plugins lors de la détection auto des fichiers
filetype indent on              " indentation auto en fonction du type de fichier
syntax enable                   " active la coloration syntaxique
set clipboard=unnamed						" copie depuis clipboard et non primary
set mouse=a                     " allow mouse mouvement in vim
set laststatus=2                " display status line always
" set noshowmode									" enlever la ligne INSERTION / VISUAL / etc
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
set hlsearch                  	" surligne durablement les résultats de recheche
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
set nofoldenable								" ne ferme pas les folds lors de chgment de buffer
set omnifunc=syntaxcomplete#Complete            " activer l'auto completion
colorscheme desertEx	          " couleur theme
" }}}

" Persistent undo --- {{{
set undofile                		" Save undos after file closes
set undodir=$HOME/.vim/undo 		" where to save undo histories
set undolevels=1000         		" How many undos
set undoreload=10000        		" number of lines to save for undo
" }}}

" Personnal keymaps --- {{{
let mapleader="\\"
let maplocalleader=","
inoremap ;; <Esc>
set pastetoggle=<F1>
nnoremap <F2> :set relativenumber! number! showmode! showcmd! hidden! ruler!<CR>
nnoremap <F3> :!pandoc -C "%:p" -o "%:r".pdf<CR>
nnoremap œ :bn<CR>
inoremap œ <Esc>:bn<CR>
nnoremap Œ :bp<CR>
inoremap Œ <Esc>:bp<CR>
" ctrl k to appen line upper cursor
nnoremap <C-k> :call append(line('.')-1, '')<CR>
" ctrl j to append line under cursor
nnoremap <C-j> :call append(line('.'), '')<CR>
" pair completion
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap (  		()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
" comments
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
" edit dotfiles
nnoremap <LocalLeader>ev :e ~/.vimrc<CR>
nnoremap <LocalLeader>sv :source ~/.vimrc<CR>:echo ".vimrc sourced!"<CR>
nnoremap <LocalLeader>eu :UltiSnipsEdit<CR>
" misc
nnoremap <LocalLeader>u :!urlscan -n % \| dmenu -l 10 \| xargs firefox &<CR>
nnoremap <localleader>nn :!R -e 'shiny::runApp("'%:p:h'", launch.browser=FALSE)'<CR>

" }}}

" FileType specific settings --- {{{
autocmd FileType c,cpp,java,scala 			let b:comment_leader = '// '
autocmd FileType sh,ruby,python,yml	   	let b:comment_leader = '# '
autocmd FileType conf,fstab,make,cfg   	let b:comment_leader = '# '
autocmd FileType tex,Rnw          			let b:comment_leader = '% '
autocmd FileType mail             			let b:comment_leader = '> '
autocmd FileType vim              			let b:comment_leader = '" '
autocmd FileType r,md              			let b:comment_leader = '# '
autocmd FileType xdefaults     					let b:comment_leader = '! '
autocmd FileType sql			     					let b:comment_leader = '-- '

" FileType vim tex sql r
augroup fileType_vim_tex_sql_r
	autocmd!
	autocmd FileType vim,xdefaults,tex,sh,r setlocal foldmethod=marker
augroup END

" }}}

" Plugins config --- {{{

" jupyter-vim --- {{{
" let g:jupyter_mapkeys = 0
" --- }}}

" jupytext --- {{{
let g:jupytext_enable = 1
let g:jupytext_fmt = 'md'

" --- }}}

" Nvim-r --- {{{
let R_external_term = 1
let R_synctex = 0
let R_show_arg_help = 0
let R_rconsole_width = 80
let R_min_editor_width = 18
let R_nvimpager = "tab"
let R_pdfviewer = "zathura"
let R_objbr_place = "script,below"
let R_set_omnifunc = ["r",  "rmd", "rnoweb", "rhelp", "rrst"]
let R_auto_omni = ["r",  "rmd", "rnoweb", "rhelp", "rrst"]
nnoremap <silent> <LocalLeader>h :call RAction("head")<CR>
nnoremap <silent> <LocalLeader>v :call RAction("View")<CR>
nnoremap <silent> <LocalLeader>mt :call RAction("tail")<CR>
nnoremap <silent> <LocalLeader>md :call RAction("dim")<CR>
" --- }}}

" vimcmdline --- {{{
" let cmdline_vsplit = 1
let cmdline_in_buffer = 0
" let cmdline_external_term_cmd = "st %s &"
let cmdline_external_term_cmd = "urxvt -e %s &"
let cmdline_app           = {}
let g:cmdline_app = {"python": "ipython"}
let cmdline_tmux_conf = "~/.tmux.conf"
let cmdline_map_start          = '<LocalLeader>pr'
let cmdline_map_send           = '<Space>'
let cmdline_map_send_and_stay  = '<LocalLeader><Space>'
let cmdline_map_source_fun     = '<LocalLeader>f'
let cmdline_map_send_paragraph = '<LocalLeader>p'
let cmdline_map_send_block     = '<LocalLeader>b'
let cmdline_map_send_motion    = '<LocalLeader>m'
let cmdline_map_quit           = '<LocalLeader>q'
" nnoremap <LocalLeader>pp viw:call VimCmdLineSendSelection()<CR>
nnoremap <LocalLeader>pp :call VimCmdLineSendCmd(expand('<cword>'))<CR>
nnoremap <LocalLeader>pi :call VimCmdLineSendCmd(expand('<cword>').".info()")<CR>
nnoremap <LocalLeader>ph :call VimCmdLineSendCmd(expand('<cword>').".head()")<CR>
nnoremap <LocalLeader>pt :call VimCmdLineSendCmd("type(".expand('<cword>').")")<CR>
" autocmd FileType python nmap <buffer> <LocalLeader>pp :call VimCmdLineSendCmd(expand('<cword>'))<CR>
" --- }}}

" Slimux --- {{{
let g:slimux_scheme_keybindings = 0
nnoremap <LocalLeader>s :SlimuxREPLSendLine<CR>j
inoremap <LocalLeader>s <Esc>:SlimuxREPLSendLine<CR>A
vnoremap <LocalLeader>s :SlimuxREPLSendSelection<CR>
nnoremap <LocalLeader>b :SlimuxREPLSendBuffer<CR>
nnoremap <LocalLeader>c :SlimuxShellRun clear<CR>
" --- }}}

" vim-airline --- {{{
" vim-airline
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = 'ln'
let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" --- }}}

" UltiSnips --- {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
" --- }}}

" fzf
nnoremap <LocalLeader>f :FZF ~<CR>
nnoremap <LocalLeader>fm :FZF /media/usb1/<CR>

" }}}

" Open url under cursor --- {{{
" https://github.com/vim/vim/issues/4738
function! OpenURLUnderCursor()
	let s:uri = expand('<cWORD>')
	let s:uri = matchstr(s:uri, "[a-z]*:\/\/[^ >,;)'\"]*")
	let s:uri = substitute(s:uri, '#', '\\#', '')
	if s:uri != ''
		silent exec "!xdg-open '".s:uri."' > /dev/null"
		:redraw!
	endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>
" }}}
