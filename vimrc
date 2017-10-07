" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
"if &shell =~# 'fish$'
"    set shell="/usr/bin/env bash --login"
"endif
set shell=/bin/bash

" Move all swap files to a single directory
"set directory=~/.vim/swap,.

" Limit to 72 columns in mutt
au BufRead /tmp/mutt-* set tw=72
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

execute pathogen#infect()
execute pathogen#helptags()
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
"
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
"set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmode=longest,list,full
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Turn off search hightlighting
map // :nohlsearch<CR> " Double Tap the / (slash key)

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

:autocmd!
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number
set relativenumber

" Set splits to open on the right and bottom
set splitright
set splitbelow

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=50

" Use <F2> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F2>

set completeopt=longest,menuone,preview
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds
:let g:session_autosave = 'no'
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2

"-----------------------------------------------------------
"Functions

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! CloseIDE()
    tabdo TagbarClose
    :NERDTreeTabsClose
    tabdo SyntasticToggleMode
endfunction
com! CloseIDE call CloseIDE()

function! EnableIDE()
    tabdo TagbarOpen
    :NERDTreeTabsOpen
    tabdo SyntasticCheck
endfunction
com! EnableIDE call EnableIDE()

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

"Moves by virtual lines without a count, but physical lines with a count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Map w!! to write using sudo
cmap w!! w !sudo tee %

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Swap line down
nmap - ddp
" Swap line up
nmap _ ddkP

" Delete line in insert mode
imap <c-d> <esc>ddi

" Convert word to upper-case in INSERT mode and normal mode
imap <c-u> <esc>vawUi
nmap <c-u> vawU

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-l> :nohl<CR>


"------------------------------------------------------------
set runtimepath^=~/.vim/bundle/ctrlp.vim

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
endif

nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

nnoremap <silent> <leader>k :SetLinuxFormatting<cr><cr>

map <Leader>l :setlocal number!<CR>
map <Leader>o :set paste!<CR>

map <Leader>e :NERDTreeTabsToggle<CR>

map <F6> :tabp<CR>
map <F7> :tabn<CR>
map <F5> :tabe<CR>
nmap <F4> :TagbarToggle<CR>
map <C-e> :e#<CR>
map <C-n> :bnext<CR>
map <C-p> :bprev<CR>

" vimrc quick edits
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" Spell check
nnoremap <leader>sc :setlocal spell spelllang=en_us<cr>
nnoremap <leader>ns :setlocal nospell<cr>

" Paragraph
nnoremap <leader>pm :set tw=119 <bar> :set formatoptions+=t<cr>

"##############################################################################
" Easier split navigation                                                      
"##############################################################################

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>

"Set shortcuts for most frequently used commands
nnoremap <leader>2 :Accordion 2<CR>
nnoremap <leader>3 :Accordion 3<CR>
noremap <leader>0 :AccordionStop<CR>
"More shortcuts, without a good available <C-w> option
nnoremap <leader>d :AccordionDiff<CR>
nnoremap <leader>= :AccordionZoomIn<CR>
nnoremap <leader>- :AccordionZoomOut<CR>

"Change forward/back slashes
nnoremap <silent> <Leader>/ :let tmp=@/<Bar>s:\\:/:ge<Bar>let @/=tmp<Bar>noh<CR>
nnoremap <silent> <Leader><Bslash> :let tmp=@/<Bar>s:/:\\:ge<Bar>let @/=tmp<Bar>noh<CR>

"Vimux Keybindings
" Run the current file with rspec
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

map ; :CtrlPMixed<CR>
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open = 1
let g:syntastic_loc_list_height=3

let g:syntastic_python_checkers=['flake8']
let g:syntastic_c_include_dirs = [ '../include', 'include' ]
let g:syntastic_c_checkers=['gcc', 'make']
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_checkers=['cpplint']
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1

let g:easytags_async=1
let g:easytags_auto_highlight=0

set rtp+=/home/kyoungmeyer/.local/lib/python2.7/site-packages/powerline/bindings/vim
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
syntax enable
set background=dark
let g:solarized_termcolors=16
colorscheme solarized
set background=dark
"let g:solarized_visibility="low"
let g:solarized_termtrans=1
highlight clear SignColumn 

let NERDTreeShowHidden=1

"Highlight characters past column 80
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
"match Error /\%81v.\+/
"set colorcolumn=81
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=lightgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%121v.\+/
augroup END

nohl
