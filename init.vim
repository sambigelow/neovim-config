call plug#begin()

Plug 'pangloss/vim-javascript'      " standard javascript vim plugin - not sure what i get from it?
Plug 'mxw/vim-jsx'                  " jsx syntax highlighting and more
Plug 'mattn/emmet-vim'              " makes html easier
Plug 'kien/ctrlp.vim'               " fuzzy file searcher
Plug 'tmhedberg/SimpylFold'         " better cold folding 
Plug 'mhinz/vim-signify'            " git help
Plug 'vim-scripts/indentpython.vim' " better python indentation
Plug 'vim-syntastic/syntastic'
Plug 'elixir-editors/vim-elixir'    " elixir syntax support (maybe more?)
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'tpope/vim-endwise'            " adding automatic 'end'
Plug 'tpope/vim-surround'           " adding 'surround' operator
Plug 'tpope/vim-commentary'         " autocomment

call plug#end()


"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Plugin Configs +++++++++++++++++++++++++++++++++++++++++++++
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
let g:jsx_ext_required = 0 " jsx works in .js file

let g:deoplete#enable_at_startup = 1

" use the silver searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  " use ag in CtrlP for listing files
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  let g:ctrl_use_caching = 0
endif

" make signify work less
let g:signify_vcs_list=['git']

" ctrlp ignore these files
let g:ctrlp_custom_ignore = { 'dir': '\.git$\|node_modules$' }

" use emmet for jsx
let g:user_emmet_settings = {
  \   'javascript.jsx' : {
  \     'extends': 'jsx',
  \     'quote_char': "'",
  \   },
  \ }

" use tab key for emmet
" let g:user_emmet_expandabbr_key='<Tab>'
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" auto indent and make new line when hitting enter in parentheses
set autoindent
set smartindent

" autosave
set autowriteall

" some customization for youCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Key Mappings +++++++++++++++++++++++++++++++++++++++++++++++
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

let mapleader=","         " use space as leader key 

inoremap jk <Esc>	        " Remap jk to get out of insert mode
nnoremap rh :nohl<CR>     " use hh to turn off all highlighting

" Default tab setting 
set tabstop=2 
set shiftwidth=2 
set expandtab 

" better folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Better navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open splits below and to the right
set splitbelow
set splitright

" hybrid linenumber mode
set number relativenumber	  

" turn on syntax highlighting
syntax enable             

" toggle linenumber mode when buffer is inactive
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave  * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter    * set norelativenumber
augroup END

" source neovimrc
nmap <leader>s :source /home/sambigelow/.config/nvim/init.vim<CR>

" duplicate line with space-d
nmap <leader>d :t.<CR>

" use space w to write all buffers
nmap <leader>w :wa<CR>

" commenting blocks of code
autocmd FileType c,cpp,java,javascript let b:comment_leader = '// '
autocmd FileType sh,python     let b:comment_leader = '# '
autocmd FileType vim           let b:comment_leader = '" '
noremap <silent> /cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader, '\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> /dd :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader, '\/')<CR>//e<CR>:nohlsearch<CR>

" copy to system clipboard
vnoremap <C-c> "*y

" highlight bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" set utf8
set encoding=utf-8

