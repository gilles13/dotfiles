" Vim config Gilles

set nocompatible                " annule compatibilité avec vi

filetype off  									" requis par Vundle

" Plugins management (Vundle) --- {{{
" à faire avant tout :
" git clone https://github.com/VundleVim/Vundle.vim.git  ~/.vim/bundle/Vundle.vim

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin 'bronson/vim-trailing-whitespace'
Plugin 'epeli/slimux'
Plugin 'flazz/vim-colorschemes'
Plugin 'jalvesaq/Nvim-R'
Plugin 'junegunn/fzf.vim'
" Plugin 'jpalardy/vim-slime'
" Plugin 'gaalcaras/ncm-R'
" Plugin 'honza/vim-snippets'
" Plugin 'kshenoy/vim-signature'
Plugin 'SirVer/ultisnips'
" Plugin 'sukima/xmledit'
" Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
" Plugin 'vim-syntastic/syntastic'
Plugin 'VundleVim/Vundle.vim'
" Plugin 'yggdroot/indentline'
" Plugin 'w0rp/ale'

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
set noshowmode									" enlever la ligne INSERTION / VISUAL / ...
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
" }}}

" Persistent undo --- {{{
set undofile                		" Save undos after file closes
set undodir=$HOME/.vim/undo 		" where to save undo histories
set undolevels=1000         		" How many undos
set undoreload=10000        		" number of lines to save for undo
" }}}

" Astyle --- {{{
" sudo pacman -Sy astyle
" set equalprg=/user/bin/astyle\ --style=google
" set formatprg=astyle
" --mode=c --style=ansi -s2
" set formatprg=astyle\ -T4pb
" usage : gg gqG : format all file
" usage : gg=G
" https://stackoverflow.com/questions/2355834/how-can-i-autoformat-indent-c-code-in-vim
" nnoremap <LocalLeader>as :!astyle --mode=c --style=ansi<CR>
nnoremap <LocalLeader>as :!astyle --mode=java<CR>
" }}}

" Appearance --- {{{
autocmd ColorScheme * highlight LineNr ctermbg=None
autocmd ColorScheme * highlight LineNr ctermfg=None
autocmd ColorScheme * highlight Normal ctermbg=None
colorscheme desert256v2          " couleur theme
" autocmd ColorScheme * highlight Title ctermbg=None
" autocmd ColorScheme * highlight StatusLine ctermbg=None
" }}}

" " Statusline --- {{{
" set statusline=
" set statusline+=\[%n]                                  "buffernr
" set statusline+=\ %<%F\                                "File+path
" set statusline+=\ %y\                                  "FileType
" set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
" set statusline+=\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
" set statusline+=\ %{&ff}\                              "FileFormat (dos/unix..)
" set statusline+=\ %{&spelllang}\  										 "Spellanguage & Highlight on?
" set statusline+=\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
" set statusline+=\ col:%03c\                            "ColNumber
" set statusline+=\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
" " }}}

" Personnal keymaps --- {{{

" Leader & LocalLeader
let mapleader="\\"
let maplocalleader=","

inoremap ;; <Esc>
nnoremap <F1> :w<CR>:make<CR>
inoremap <F1> <esc>:w<CR>:make<CR>
nnoremap <F2> :!pandoc % -s -o '%:r'.pdf<CR>
set pastetoggle=<F3>
nnoremap <F4> :!cat % \| iconv -c -f utf-8 -t ISO-8859-1 \| enscript -o - \| ps2pdf - '%:r'.pdf<CR>
nnoremap œ :bn<CR>
inoremap œ <Esc>:bn<CR>
nnoremap Œ :bp<CR>
inoremap Œ <Esc>:bp<CR>
nnoremap <C-k> :call append(line('.')-1, '')<CR>
nnoremap <C-j> :call append(line('.'), '')<CR>

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

nnoremap <LocalLeader>ev :e ~/dotfiles/vim/.vimrc<CR>
nnoremap <LocalLeader>sv :source ~/dotfiles/vim/.vimrc<CR>:echo ".vimrc sourced!"<CR>
nnoremap <LocalLeader>er :e ~/dotfiles/config/.config/ranger/rc.conf<CR>
nnoremap <LocalLeader>ew :e ~/dwm/config.def.h<CR>
nnoremap <LocalLeader>et :e ~/dotfiles/tmux/.tmux.conf<CR>
nnoremap <LocalLeader>ed :e ~/dotfiles/config/.config/dunst/dunstrc<CR>
" nnoremap <LocalLeader>ex :e ~/dotfiles/xresources/.Xresources.d/urxvt<CR>
nnoremap <LocalLeader>ex :e ~/.xinitrc<CR>
nnoremap <LocalLeader>sx :!xrdb ~/.Xresources<CR>
nnoremap <LocalLeader>ep :e ~/dotfiles/config/.config/picom/picom.conf<CR>
nnoremap <LocalLeader>ef :e ~/.sfeed/sfeedrc<CR>
nnoremap <LocalLeader>ea :e ~/dotfiles/bash/.bash_aliases<CR>
nnoremap <LocalLeader>ez :e ~/dotfiles/zsh/.zshrc<CR>
nnoremap <LocalLeader>ca :e /media/usb1/unix/arch/01_config<CR>
nnoremap <LocalLeader>eu :UltiSnipsEdit<CR>
nnoremap <LocalLeader>Sw :w !sudo tee % >/dev/null<CR>
nnoremap <LocalLeader>u :!urlscan -n % \| dmenu -l 10 \| xargs firefox &<CR>

" launch shiny app
" https://www.howtoforge.com/tutorial/how-to-access-shell-or-run-external-commands-from-within-vim/
nnoremap <localleader>nn :!R -e 'shiny::runApp("'%:p:h'", launch.browser=FALSE)'<CR>
" nnoremap <localleader>nn :silent !R -e 'shiny::runApp("'%:p:h'", launch.browser=TRUE)'<CR>
" nnoremap <localleader>nn :execute 'silent !R -e 'shiny::runApp("'%:p:h'", " launch.browser=TRUE) &'<CR>'

" }}}

" FileType specific settings --- {{{
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
	autocmd FileType vim,xdefaults,tex,sh setlocal foldmethod=marker
augroup END

" FileType xml html
augroup fileType_xml
	autocmd!
	autocmd FileType xml,html setlocal foldmethod=syntax
augroup END

" }}}

" Plugins config --- {{{

" Nvim-r
let R_in_buffer = 0
let R_term = "urxvt"
" let R_term_cmd = "urxvt -title monNvimR -e"
let R_synctex = 0
let R_show_args = 0
let R_show_arg_help = 0
let R_complete = 2
let R_rconsole_width = 80
let R_min_editor_width = 18
let R_nvimpager = "tab"
let R_pdfviewer = "zathura"
let R_objbr_place = "script,below"
" let_R_df_viewer = "utils::View(%s)"
nnoremap <silent> <LocalLeader>h :call RAction("head")<CR>
nnoremap <silent> <LocalLeader>v :call RAction("View")<CR>

" Slimux
let g:slimux_scheme_keybindings = 0
nnoremap <LocalLeader>s :SlimuxREPLSendLine<CR>j
inoremap <LocalLeader>s <Esc>:SlimuxREPLSendLine<CR>A
vnoremap <LocalLeader>s :SlimuxREPLSendSelection<CR>
nnoremap <LocalLeader>b :SlimuxREPLSendBuffer<CR>
nnoremap <LocalLeader>c :SlimuxShellRun clear<CR>

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

" UltiSnips
" set runtimepath+=~/.vim/UltiSnips/
let g:UltiSnipsSnippetsDir="/home/gilles/.vim/mysnips"
let g:UltiSnipsSnippetDirectories=["/home/gilles/.vim/mysnips", "UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" fzf
nnoremap <LocalLeader>f :FZF ~<CR>
nnoremap <LocalLeader>fm :FZF /media/usb1/<CR>

" }}}

" " PEP8 python indentation --- {{{
" au BufNewFile,BufRead *.py
"     set tabstop=4
"     set softtabstop=4
"     set shiftwidth=4
"     set textwidth=79
"     set expandtab
"     set autoindent
"     set fileformat=unix
" " --- }}}

" vimteractive
" https://github.com/williamjameshandley/vimteractive
let g:vimteractive_default_shells = { 'python': 'ipython' }
let g:vimteractive_vertical = 1

" slime
" https://github.com/jpalardy/vim-slime
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1
xmap <LocalLeader>d <Plug>SlimeRegionSend
nmap <LocalLeader>p <Plug>SlimeParagraphSend
nmap <LocalLeader>d :SlimeSend<CR>j
" xmap creates a mapping for just Visual mode whereas vmap creates one for both Visual mode and Select mode.

" :nmap - Display normal mode maps
" :imap - Display insert mode maps
" :vmap - Display visual and select mode maps
" :smap - Display select mode maps
" :xmap - Display visual mode maps
" :cmap - Display command-line mode maps
" :omap - Display operator pending mode maps

" Misc --- {{{

" A lire
" http://learnvimscriptthehardway.stevelosh.com/
" http://www.moolenaar.net/habits.html

" Twitvim
" let twitvim_enable_perl = 1
" let twitvim_browser_cmd = 'firefox'

" Code Formatter/Beautifier
" https://stackoverflow.com/questions/2506776/is-it-possible-to-format-c-code-with-vim
" HOW TO : :%!astyle --mode=c --style=ansi -s2
" HOW TO : :%!astyle -A2 -s4 -xc -xj -c

" }}}

" Open url under cursor --- {{{
" https://github.com/vim/vim/issues/4738
function! OpenURLUnderCursor()
	let s:uri = expand('<cWORD>')
	let s:uri = matchstr(s:uri, "[a-z]*:\/\/[^ >,;)'\"]*")
	let s:uri = substitute(s:uri, '#', '\\#', '')
	" let s:uri = substitute(s:uri, '?', '\\?', '')
	" let s:uri = shellescape(s:uri, 1)
	if s:uri != ''
		silent exec "!xdg-open '".s:uri."' > /dev/null"
		:redraw!
	endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>
" }}}

