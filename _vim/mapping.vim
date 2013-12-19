" ---------------
" Window Movement
" ---------------
nnoremap <silent> gh :WriteBufferIfNecessary<CR>:wincmd h<CR>
nnoremap <silent> gj :WriteBufferIfNecessary<CR>:wincmd j<CR>
nnoremap <silent> gk :WriteBufferIfNecessary<CR>:wincmd k<CR>
nnoremap <silent> gl :WriteBufferIfNecessary<CR>:wincmd l<CR>

" 4 Window Splits
"
" -----------------
" g1 | g2 | g3 | g4
" -----------------
nnoremap <silent> g1 :WriteBufferIfNecessary<CR>:wincmd t<CR>
nnoremap <silent> g2 :WriteBufferIfNecessary<CR>:wincmd t<bar>:wincmd l<CR>
nnoremap <silent> g3 :WriteBufferIfNecessary<CR>:wincmd t<bar>:wincmd l<bar>
      \:wincmd l<CR>
nnoremap <silent> g4 :WriteBufferIfNecessary<CR>:wincmd b<CR>

" Previous Window
nnoremap <silent> gp :wincmd p<CR>
" Equal Size Windows
nnoremap <silent> g= :wincmd =<CR>
" Swap Windows
nnoremap <silent> gx :wincmd x<CR>

" Fixes common typos
command! W w
command! Q q

" my configuration which depends on bundles
set laststatus=2
set statusline=+%<\ %f\ %{fugitive#statusline()}

" Dark background color. Leads to brighter fonts.
set background=dark

" Tabs become 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

" History of 100 commands
set history=100

" it makes vim work like every other multiple-file editor on the planet.
" You can have edited buffers that aren't visible in a window somewhere.
set hidden

" filetype plugin on

" set wildmenu
" set incsearch
" autocmd FileType python set omnifunc=pythoncomplete#Complete


" set undolevels=100
" INFO
" :tab sball - this opens a new tab for each open buffer

" Mouse toggle enable/disable vim mouse handler
nnoremap <Leader>m :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    set nonumber
    set paste
    echo "Mouse usage disabled"
  else
    set mouse=a
    set number
    set nopaste
    echo "Mouse usage enabled"
  endif
endfunction

" Display commands as you type them
set showcmd

" Window minimum height set to zero, so that when you have multiple windows you
" are not forced to see one row for each file.
set wmh=0


" When inserting a closing parenthesis, briefly flash the closed one
set showmatch


" Persistent Undo
set undodir=~/.vim/undodir
set undofile

" Backspace key won't move from current line
" fix macosx backspace
set backspace=indent,eol,start
:fixdel
