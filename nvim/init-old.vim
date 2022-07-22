:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/mg979/vim-visual-multi' " CTRL + N for multiple cursors
Plug 'https://github.com/jessekelighine/vindent.vim' " Text Objects


set encoding=UTF-8

call plug#end()

" Mappings for the Vindent plugin
let g:vindent_motion_OO_prev   = '[=' " jump to prev block of same indent.
let g:vindent_motion_OO_next   = ']=' " jump to next block of same indent.
let g:vindent_motion_more_prev = '[+' " jump to prev line with more indent.
let g:vindent_motion_more_next = ']+' " jump to next line with more indent.
let g:vindent_motion_less_prev = '[-' " jump to prev line with less indent.
let g:vindent_motion_less_next = ']-' " jump to next line with less indent.
let g:vindent_motion_diff_prev = '[;' " jump to prev line with different indent.
let g:vindent_motion_diff_next = '];' " jump to next line with different indent.
let g:vindent_motion_XX_ss     = '[p' " jump to start of the current block scope.
let g:vindent_motion_XX_se     = ']p' " jump to end of the current block scope.
let g:vindent_object_XX_ii     = 'll' " select current block.
let g:vindent_object_XX_ai     = 'al' " select current block + one extra line  at beginning.
let g:vindent_object_XX_aI     = 'aL' " select current block + two extra lines at beginning and end.

" REMAPPINGS
"
" Have n and e replace j and k to navigate logical lines and Caps visible ones
noremap N gk
noremap E gj
noremap n k
noremap e j
noremap zn zt
noremap ze zb

" Have s and i handle left and right instead of h and l
noremap s h
noremap i l

" Have - and _ handle backward navigation to beginning of words for b and B
noremap - b
noremap _ B

" Have b and B handle navigation to end of words for e and E
noremap b e
noremap B E

" Have L and l handle inserting for I and i
noremap L I
noremap l i
noremap gl gi

" Have h handle the functions of J (and give J a job)
noremap h J
noremap gh gJ
noremap J <C-r>

" Have k and j handle search navigation for N and n 
noremap k N
noremap j n

" Repairing the strangeness
noremap <Left> h
noremap <Right> l
noremap <Down> j
noremap <Up> k

" Have S and I handle moving to the top/bottom of the screen for H and L
noremap S H
noremap I L

" Have g- and g_ handle reverse end of word travel
noremap g- ge
noremap g_ gE

noremap x "_x
noremap X "_X
noremap <BS> X

" for command mode
nnoremap <S-Tab> <<
" for insert mode
inoremap <S-Tab> <C-d>

nnoremap <C-t> :NERDTreeToggle<CR>
