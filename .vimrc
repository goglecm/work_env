" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
""""""""""""""""
" Basic config "
""""""""""""""""

" Detect file type
filetype on

" Load the plugin for that file type
filetype plugin on

" Load the indent plugin for that file type
filetype indent on

" Turn on syntax highlighting, using Vim defaults
syntax on

" Turn on syntax highlighting, using own colours
syntax enable

" Set the syntax/background colour
colorscheme koehler

" Also load the .vimrc present in the current directory
set exrc

" Limit the number of things the .vimrc from a directory can do
set secure

" Set the file encoding
set encoding=utf-8

" Set the left column numbering to be relative to the current line
set number relativenumber

" Do not disable features in order to be compatible with Vi
set nocompatible

" Make backspace work
set bs=2

" Make the buffer modifiable at startup
set modifiable

" Highlight search results
set hlsearch

" Jump to search result while typing
set incsearch

" Shows the command you are typing
set showcmd

" Set tab width
set tabstop=4
set softtabstop=4
autocmd FileType systemverilog,verilog setlocal tabstop=2 softtabstop=2

" Set left/right shift amount
set shiftwidth=4
autocmd FileType systemverilog,verilog setlocal shiftwidth=2

" Delete a 'tab' worth of spaces at a time
autocmd FileType systemverilog,verilog setlocal smarttab

" Insert spaces instead of tabs
set expandtab

" Do not wrap
set nowrap

" Allow multiple undos
if !isdirectory($HOME."/.vim_undo")
    call mkdir($HOME."/.vim_undo", "", 0770)
endif
set undodir=~/.vim_undo
set undofile

" Options to format the text when line-breaking
set formatoptions+=w,n,b,j

if v:version >= 801
    set formatoptions+=p
endif

" How often in ms to perform certain tasks/checks
set updatetime=1000

" Display current line/column.
set ruler

" Always display the status line
set laststatus=2

" When doing vertical splits, new win goes to the right
set splitright

" When doing horizontal splits, new win goes to the bottom
set splitbelow

" Indents a new line
set autoindent

" Same as autoindent, but smarter as it looks at the filetype
set smartindent

" Show visual effect instead of beeping
set visualbell

" Always have 5 visible lines.
set scrolloff=5

" How many columns to scroll horizontally at once
set sidescroll=1

" Number of columns between cursor and edge before scrolling starts
set sidescrolloff=5

" Set a colour column (specify multiple 10, 12, etc.)
set cc=80

" Set spelling language
set spelllang=en

" Specify where personal dictionary goes.
set spellfile=~/.vim/spell/en.utf-8.add

" Enable spelling. Use nospell to disable.
set nospell

" Automatically fold code where there are comment markers (such as {{{ }}}).
set fdm=marker

augroup bind_ft
    au!
    autocmd BufNewFile,BufRead *.bind   set syntax=verilog
augroup END

" The swap files are saved in a separate root (the '//' forces a full path).
if !isdirectory($HOME."/.vim_swp")
    call mkdir($HOME."/.vim_swp", "", 0770)
endif
set directory^=$HOME/.vim_swp//


" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
""""""""""""""""
" Key mappings "
""""""""""""""""
" When working with a tags file, <C-]> jumps to the first definition. <g-]>
" shows a list of the tag present in the tags. This mapping jumps to the
" definition if one definition exists, otherwise it shows a tag list.
nnoremap <C-]> g<C-]>


" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
""""""""""""""""""
" Simple plugins "
""""""""""""""""""
" Summary:
" - (*) Strip whitespace


"
" Strip whitespace
"
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()



" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
""""""""""""""""""""""""""""""""""
" Settings before pathogen loads "
""""""""""""""""""""""""""""""""""

"
" ALE
"

if v:version >= 801
    " Turn off ALE built-in completion.
    let g:ale_completion_enabled = 0
endif



" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
""""""""""""""""""""
" Autoload plugins "
""""""""""""""""""""

" These are vim files in the autoload directory.
" We need to call an some Enable function to start them.

" Summary:

" (*) Delayed completion (748+)
" (*) Integration with tmux (801+)
" (*) Pathogen (700+)


"
" Auto completion menu
"
if v:version >= 748
    execute delay_completion#Enable()
endif

"
" Integrate with tmux
"
if v:version >= 801
    execute vimtmuxclipboard#Enable()
endif

"
" Pathogen
"
if v:version >= 801
    execute pathogen#infect(
                \ '~/.vim/pathogen_common/{}',
                \ '~/.vim/pathogen_post_800/{}')
else
    execute pathogen#infect('~/.vim/pathogen_common/{}')
endif



" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
""""""""""""""""""""
" Pathogen plugins "
""""""""""""""""""""

" Legend:
" (*) Enabled - either in pathogen_common or pathogen_post_800
" (-) Disabled - in pathogen_disabled

" Summary:

" (*) Gitgutter - (730+) Shows git diff on left, hunk management.
" (*) Fugitive - (730+) Git commands from vim command line, Gblame, etc.
" (*) tmux-focus-events - (800+) Allow tmux to work properly with vim.
" (*) Tagbar - (731+) Display a tag bar on the right.
" (*) Auto save - (730+) Automatically saves the file, see update time.
" (*) Grep - (700+) Grepping tools in vim, Egrep.
" (*) Undotree - (700+) Show edit history tree.
" (*) Table mode - (700+) Create tables, "\tm" to toggle.
" (*) Line diff - (700+) Diff tool between 2 selections, :Linediff.
" (*) ALE - (801+) Linter
" (*) Operator user - (700+) Define own operators, needed by clang-format.
" (*) Clang format - (700+) Format code using clang-format.
" (*) Unimpaired - (700+) Allow back/forth keys ]c [c, etc.
" (*) C++ highlighting - (700+) Better syntax highlighting for C++.
" (*) Gutentags - (801+) Regenerate tags.
" (*) Comfortable motion - (801+) Allow smooth scrolling.
" (*) FZF - (700+) Fuzzy searcher commands, such as :Bu, :Tags, etc.
" (*) Latex Live Preview - (730+) Automatically call pdflatex when not in insert.
" (*) GPU PG - (700+) Allow reading encrypted files.
" (*) C++ omnicomplete - (700+) Auto-completion for C/C++.
" (*) vimwiki - (740+) Personal wiki.


"
" Gitgutter
"

let g:gitgutter_max_signs = 5000 " Allow lots of signs on the left column.
" let g:gitgutter_diff_args = '-w' " Ignore white space diffs.


"
" Tagbar
"

" autocmd FileType * nested :TagbarOpen " Open tag bar for all ext.
autocmd FileType c,cc,h,py,hpp,cpp nested :TagbarOpen " Open tag bar for these ext.

let g:tagbar_show_linenumbers = 1


"
" Autosave
"
let g:auto_save = 0 " Enable at startup
let g:auto_save_write_all_buffers = 1 " Save all buffers every updatetime
let g:auto_save_no_updatetime = 1 " Do not modify updatetime
let g:auto_save_in_insert_mode = 0


"
" Undotree
"
let g:undotree_WindowLayout = 2 " Diff goes at the bottom.


"
" Table mode
"
let g:table_mode_corner_corner = '+'
let g:table_mode_header_fillchar = '='


"
" Clang format
"
let g:clang_format#style_options = {
            \ "AlignTrailingComments" : "true",
            \ "BreakBeforeBraces" : "Allman",
            \ "ColumnLimit" : "120"
            \ }

"
" C++ highlighting
"
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_member_variable_highlight = 1
" let g:cpp_experimental_simple_template_highlight = 1
" let g:cpp_concepts_highlight = 1
let c_no_curly_error = 1


"
" Gutentags
"

" Look for .gutctags in the current directory and parse it.
let g:gutentags_project_root = ['.gutctags']
let g:gutentags_cache_dir="~/.vim_tags"


"
" FZF
"

" Point to the FZF installation.
set rtp+=~/.fzf


"
" Latex Live Preview
"

" Set default previewer.
let g:livepreview_previewer = 'okular'


"
" Vim wiki
"

let g:vimwiki_list = [
            \ {'path'      : '~/repos/work_env/wikis',
            \  'path_html' : '~/repos/work_env/wikis_html'}]
autocmd Filetype vimwiki setlocal tw=80


" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
""""""""""""""""""""""""
" Host specific config "
""""""""""""""""""""""""

if filereadable(expand("~/.vimrc_private"))
    source ~/.vimrc_private
endif
