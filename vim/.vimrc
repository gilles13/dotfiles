" CONFIGURATION VIM : Gilles FIDANI

set nocompatible                " annule compatibilité avec vi

"" PATHOGEN
call pathogen#infect()

set mouse=a                     " allow mouse mouvement in vim
set laststatus=2                " display status line always
set noshowmode                  " remove default mode indicator
set wildmenu                    " command line completion
set wildmode=list:longest,full  " command line completion
set relativenumber							" numeros de ligne relatifs

" APPARENCE
set t_Co=256                    " set terminal color to 256
colorscheme fu             			" couleur theme

set encoding=utf-8              " encodage des fichiers == utf-8
set title                       " maj du titre de la fenêtre ou du terminal
set number                      " affiche les numéros de ligne
set ruler                       " affiche la position actuelle du curseur
set wrap                        " affiche les lignes trop longues sur plusieurs lignes
set scrolloff=3                 " affiche un minimum de 3 lignes autour du curseur

set ignorecase                  " ignorer la casse lors d'une recherche
set smartcase                   " réactive la sensibilité à la casse si MAJ dans recherche
set incsearch                   " recherche incrémentale
set hlsearch                    " surligne résultats de recheche

set visualbell                  " effectuer des alertes visuelles et non sonores
set backspace=indent,eol,start  " fixe comportement de la touche <- 
set hidden                      " cache les fichiers non sauvegardés lors ouverture de nouveaux fichiers

syntax enable                   " active la détection et coloration syntaxique

" tabulation
set tabstop=2
set shiftwidth=2
"set expandtab

" ouverture des nouveaux split à droite et au dessous
set splitbelow 
set splitright

filetype on                     " active la détection automatique de fichier
filetype plugin on              " active les plugin lors de la détection auto des fichiers
filetype indent on              " indentation auto en fonction du type de fichier

let mapleader=","
let maplocalleader="\\"

" PERSONNAL KEYMAPS

" échappement (2 fois ;)
:inoremap ;; <Esc>
:noremap ;; <Esc>

" Alt+n == next buffer
:nnoremap <A-n> :bn <CR>
:inoremap <A-n> <Esc> :bn <CR>

" Alt+p == previous buffer
:nnoremap <A-p> :bp <CR>
:inoremap <A-p> <Esc> :bp <CR>

" Ctrl+k == delete to end of line
:inoremap <C-k> <Esc>` d$i

" OUVERTURE ET FERMETURE AUTO DES ({

" Pair completion {
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"


"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType r                let b:comment_leader = '# '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" PLUGINS

" NVIM-R
let R_tmux_split = 1
let R_vsplit = 1
let R_notmuxconf = 1
let R_nvimpager = "tab"
let R_pdfviewer = "evince"

" AIRLINE
" Enable smart tab line (with buffers name)
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_skip_empty_sections = 1
if !exists('g:airline_symbols')
	    let g:airline_symbols = {}
		endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" TWITVIM
let twitvim_enable_perl = 1
let twitvim_browser_cmd = 'firefox'

" SLIMUX
map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>

" TO READ
" http://learnvimscriptthehardway.stevelosh.com/
