""
" Donald Ephraim Curtis
" vimrc
"
" Organization:
" Load_Pathogen
" Global_Settings
" FileType_Settings
" Plugin_Settings
" Mappings
" Abbreviations
" Functions
" Colorscheme_and_Syntax_Highlighting
" Last_Chance
"

"" Load_Pathogen

" select the plugins we want enabled or disabled.
" WARNING: don't enable both neocomplcache and supertab, gets messy
let g:pathogen_disabled = []

" if curl is not available we must disable gist.
if !executable('curl')
  let g:pathogen_disabled += ["gist-vim"]
endif

" if this is not a gui then don't even bother with CSApprox
if !has("gui")
  let g:pathogen_disabled += ["csapprox"]
endif

" init pathogen shit
"call pathogen#infect()


""" Global_Settings

"" general
set nocompatible
set hlsearch
set backspace=2
set autowrite
set esckeys
set grepprg=grep\ -nH\ $*
set nospell
set nostartofline
" mark end of change text
set cpoptions+=$
" virtual delete in insert mode
set cpoptions+=v
set formatoptions+=t
set splitright

set hidden
set wildmenu
set report=0
set wildmode=list:longest,full
set virtualedit=block
set completeopt=menu ",longest


"" ui
set cursorline
set encoding=utf-8
set laststatus=2
set showcmd
set list
"set listchars=tab:»·,trail:·,extends:~,precedes:~,nbsp:·
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,nbsp:·
",eol:⏎
"set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
"set showbreak=↪
set shortmess=aItoOA
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%f\ %y%m%r\ %=%<-14.(%03.3b\ %02.2B%)\ %-14.(%l,%c%V%)\ %P
set statusline=%f\ %y%m%r\ %{exists('*fugitive#statusline')?fugitive#statusline():''}\ %#warningmsg#%{exists('*SyntasticStatuslineFlag')?SyntasticStatuslineFlag():''}%*%=%<\ %-14.(%l,%c%V%)\ %P

" let mapleader=","

"" visual
set incsearch
set scrolloff=5
set showmatch
set viewoptions=folds,cursor
set visualbell


"" formatting
set autoindent
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4


"" folding
set foldenable
set foldcolumn=0
set foldmethod=indent
set foldlevel=100
set foldopen-=search
set foldopen-=undo


"" backup settings
set backup
set backupskip=/tmp/*,/private/tmp/*
set backupdir=$HOME/.vim/vimfiles/bak
set directory=$HOME/.vim/vimfiles/tmp
set viewdir=$HOME/.vim/vimfiles/view
"set makeef=$TMPDIR/errors.err



"" FileType_Settings
filetype plugin indent on
if has("autocmd")
  " return to the last save point
  augroup milk
    autocmd!
    " enable markdown mode
    au BufNewFile,BufRead *.txt set ft=markdown

    " restore position in file based on session info
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    " some binary fixes
    au BufWritePre * set binary
    au BufWritePost * set nobinary
  augroup END
  augroup filetypedetect
    au FileType python          setl et makeprg=python\ setup.py\ build
    au FileType c,cpp           setl et cindent cinkeys+=;
    au FileType wiki,pmwiki     setl et tw=2 sw=2 sts=2 tw=79

    au FileType markdown        setl tw=79 noeol sw=4 ts=4 sts=4
    au FileType markdown        map <leader>m :Preview<CR>
    au FileType htmldjango,html,markdown,sh   setl et
    au FileType conque_term     setl nolist
    au FileType git             setl tw=76
    au FileType ruby,vim,tex,plaintex        setl et ts=2 sw=2 sts=2 tw=78
    au FileType vim             setl tw=0

    au FileType python imap <D-S-CR> <Esc>A:<CR>
    au FileType python          nmap <silent> <leader>rr :RopeRename<CR>

    au FileType c,cpp imap <D-S-CR> <Esc>A{<CR>}<C-o>O
    au FileType python,c,cpp,java,php,ruby autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
  augroup END
endif



""" Plugin_Settings

" align 
" don't load align bindings (too many!)
let g:loaded_AlignMapsPlugin = "v41"


"" taglist
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let Tlist_Sort_Type="name"
let Tlist_Compact_Format=1
let Tlist_Exit_OnlyWindow=1
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


""" Mappings

"" toggle folding with space
nnoremap <space> :

"" quick disable of highlighting, until I search again
nnoremap <silent> <leader>/ :nohl<CR>

"" change to current directory
"nmap <leader>cd :cd %:p:h<CR>

"" make mapping
map <leader>m :wa<CR>:make<CR>

"" Command-Return makes a new line
imap <D-CR> <C-o>o

"" Make Y behave as expected.
noremap Y y$

"" Simple bindings for command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

cmap w!! w !sudo tee % >/dev/null

nmap <silent> <leader>va :keepalt vsp<Bar>b#<CR>
nmap <silent> <C-w><C-^> :vsplit #<CR>

"Araxia_: milkpost_: i use this mapping, myself: map <Leader><CR> 0"ty$:<C-r>t<CR>:echo "Executed: " . @t<CR>



""" Abbreviations
iab recieved received

"" this expands ww/ee to include the current directory in command mode
" adapted from Eatchar in :h abbreviations
function! s:ExpandPath(cmd)
    let c = nr2char(getchar(0))
    "nr2char(getchar()) =~ '\s' ? '' : c
    return a:cmd." ".expand("%:p:h")."/"
endfunction

cabbrev ww <c-r>=getcmdpos()==1 && getcmdtype() == ":" ? <SID>ExpandPath("w") : "ww"<cr>
cabbrev ee <c-r>=getcmdpos()==1 && getcmdtype() == ":" ? <SID>ExpandPath("e") : "ee"<cr>



""" Functions

"" Sum the numbers in a line.
let g:S = 0  "result in global variable S
function! s:Sum(number)
  let g:S = g:S + a:number
  return a:number
endfunction
command! -bar SumNumberInLine let S=0|s/\d\+/\=s:Sum(submatch(0))/g

command! MakeExecutable silent execute '!chmod u+x %' | e %

function! Synname()
  if exists("*synstack")
    return map(synstack(line('.'),col('.')),'synIDattr(v:val,"name")')
  else
    return synIDattr(synID(line('.'),col('.'),1),'name')
  endif
endfunction

map <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),3),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>



""" Colorscheme_and_Syntax_Highlighting

if has("syntax")
  syntax on
endif

syntax enable
set background=dark
"hi SpellBad gui=underline


""" GUI_Configuration
if has('gui_running')
  colorscheme molokai
  "" no toolbar
  set go-=T
  "" go back to hell scrollbars!
  set go-=r
  set go-=l
  set go-=R
  set go-=L

  "" concealment only works nice in gvim
  let g:tex_conceal="adgm"
  set cole=2

  set guifont=Inconsolata:h13
  "set guifont=Monaco:h12
endif


