filetype off
"{{{ plug
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree',{'on': 'NERDTreeToggle'}
Plug 'mbbill/fencview',{'on':'Fencview'}
Plug 'sheerun/vim-polyglot'
Plug 'Krasjet/auto.pairs'
Plug 'gruvbox-community/gruvbox'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 't9md/vim-choosewin'
Plug 'mg979/vim-visual-multi'
Plug 'ap/vim-css-color',{'for':'css'}
Plug 'jeffkreeftmeijer/vim-dim'

Plug 'voldikss/vim-translate-me'
Plug 'machakann/vim-sandwich'
Plug 'junegunn/vim-easy-align',{'on': 'EasyAlign'}

Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent' | Plug 'sgur/vim-textobj-parameter'

Plug 'tpope/vim-fugitive',{'on':'Gdiffsplit'}

Plug 'alcesleo/vim-uppercase-sql',{'for':'sql'}
"Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'OmniSharp/omnisharp-vim',{'for': 'cs'}
Plug 'pangloss/vim-javascript',{'for':'javascript'}
Plug 'vim-scripts/dbext.vim',{'for': 'sql'}

Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'rafi/awesome-vim-colorschemes'
call plug#end()
"}}}
filetype plugin indent on
packadd! matchit
source ~/.vim/commonmap
"{{{common map
nmap <leader>dc :Gdiffsplit<CR>
"}}}

"{{{command
command! -nargs=1 ES call es#search(<f-args>)
silent! command File call CopyFile()
command! -nargs=1 F call FindList(<f-args>)
command Sql set ft=sql
command Diff :Gina compare

"}}}

"{{{ DbExt
let g:dbext_default_usermaps = 0
"let g:dbext_default_profile_Server = 'type=SQLSRV:user=user_BFS:passwd=SFB_resu:srvname=www.businessfuture.com.cn:host=1433\SQLEXPRESS:dbname=db_BFS' "let g:dbext_default_profile_Local = 'type=SQLSRV:user=user_BFS:passwd=SFB_resu:srvname=192.168.1.250:host=1433\SQLEXPRESS:dbname=db_BFS' let g:dbext_default_profile_Local = 'type=SQLSRV:user=sa:passwd=my_5b20:srvname=192.168.1.250:host=1433\SQLEXPRESS:dbname=db_BFS'
let g:dbext_default_profile_debian = 'type=MYSQL:user=root:passwd=root:dbname=csm2014:host=127.0.0.1'
let g:dbext_default_profile_yhwms = 'type=MYSQL:user=root:passwd=root:dbname=yhwms:host=192.168.3.114'
let g:dbext_default_profile ='yhwms'
"let g:dbext_default_profile ='Server'
let g:dbi_max_column_width = 30
"}}}

"{{{ markdown
let g:vim_markdown_toc_autofit = 1
set conceallevel=0
let g:vim_markdown_fenced_languages = ['csharp=cs']
let g:vim_markdown_folding_disabled=1
"}}}

"{{{Snipmate
let g:snips_author='annbeing'
"}}}

"{{{ Comment
let g:tcomment_maps = 0
nmap <leader>cc :TComment<CR>
vmap <leader>cc :TComment<CR>
nmap <leader>cu :TComment<CR>
vmap <leader>cu :TComment<CR>
"}}}

"{{{ fuzzer_finder
"nmap q: :Clap command_history<CR>
"nmap q; :Clap command_history<CR>
"nmap <leader>, :Clap files --hidden<CR>
"noremap <leader>b :Clap buffers<CR>
"nmap <leader>y  :Clap yanks<CR>
"nmap <leader>m :Clap history<CR>

let g:Lf_WindowPosition = 'popup'
nmap q: :Leaderf cmdHistory<CR>
nmap q; :Leaderf cmdHistory<CR>
nmap q/ :Leaderf searchHistory<CR>
nmap <leader>m :Leaderf mru<CR>
nmap , :Leaderf command<CR>
let g:Lf_ShortcutF = '<leader>,'
let g:Lf_ShowDevIcons = 0
"let g:Lf_DefaultExternalTool = "fd"
let g:Lf_ExternalCommand = 'fdfind --type file "%s"'

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
"}}}

"{{{function
function! Everthing()
    let keyward= input('s:')
    if len(keyward)>0
        call es#search(keyward)
    endif
endfunction


function!FindList(value)
    exe "vimgrep /" . a:value ."/%"
    copen
endfunction


function! CopyFile()
    let path = expand('%:p')
    "call job_start("!powershell -command Set-Clipboard -Path " . path)
    execute "!powershell -command Set-Clipboard -Path " . path
endfunction
"}}}

"{{{"omnisharp
" Note: this is required for the plugin to work
filetype indent plugin on

" Use the stdio OmniSharp-roslyn server
" if has('unix')
"     let g:OmniSharp_translate_cygwin_wsl =1
"     let g:OmniSharp_server_path='/mnt/c/Users/annbe/.omnisharp/OmniSharp.exe'
" endif

"let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_stdio = 1
" Set the type lookup function to use the preview window instead of echoing it
let g:OmniSharp_typeLookupInPreview = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5

set completeopt=longest,menuone,preview
set previewheight=5
let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:OmniSharp_highlight_types = 1
let g:OmniSharp_highlight_groups = {
            \ 'csUserIdentifier': [
            \   'constant name', 'enum member name', 'field name', 'identifier',
            \   'local name', 'parameter name', 'property name', 'static symbol'],
            \ 'csUserInterface': ['interface name'],
            \ 'csUserMethod': ['extension method name', 'method name'],
            \ 'csUserType': ['class name', 'enum name', 'namespace name', 'struct name']
            \}

""}}}

"{{{ NERDTree
nnoremap <silent><leader>fl : NERDTreeToggle<cr>
let NERDTreeHijackNetrw=1
let NERDTreeIgnore=['\.class$','\.exe$','\.dll', '.\lnk','\.doc','\.jpg','\.png','\.xls','\.ppt','\.ldf','\.mdf', '\~$','\.swp','bin$[[dir]]','obj$[[dir]]','packages$[[dir]]','node_modules','dist']
let NERDTreeWinSize=24
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
"}}}
"{{{ ChooseWin

nmap  -  <Plug>(choosewin)

" use overlay feature
let g:choosewin_overlay_enable = 1

" workaround for the overlay font being broken on mutibyte buffer.
let g:choosewin_overlay_clear_multibyte = 1

" tmux-like overlay color
let g:choosewin_color_overlay = {
      \ 'gui': ['DodgerBlue3', 'DodgerBlue3'],
      \ 'cterm': [25, 25]
      \ }
let g:choosewin_color_overlay_current = {
      \ 'gui': ['firebrick1', 'firebrick1'],
      \ 'cterm': [124, 124]
      \ }
"}}}

"{{{airline
let g:airline_powerline_fonts =0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled=0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_skip_empty_sections = 1
let g:airline_section_z = '%3l/%L'
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0
"}}}
"{{{setting
"set shell=pwsh
"set hidden
set showtabline=1  "hide tabline
set updatetime=5000
"set signcolumn=yes
set tabstop =4 shiftwidth=4
set history=3000
set timeout timeoutlen=3000 ttimeoutlen=100
if has('unix')
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
endif
set bg=dark
color gruvbox
if !has('gui')
    set termguicolors
endif
"vim-only
set encoding=utf8
set cm=blowfish2
"set fillchars+=vert:|

set noea "不自动调整Window
"set ignorecase
set incsearch
set hlsearch
set expandtab
"set synmaxcol=200
set shortmess=actI   " don't show start message
"set cmdheight=2
"set novisualbell
set cc=80,120
set vb t_vb=
"set vb t_vb=[?5h$<100>[?5l
set undofile
set undodir=$VIM/\_undodir
set undolevels=1000 "maximum number of changes that can be undone
set imcmdline
set mouse=c "don't use mouse
set diffopt=internal,filler,vertical
if &diff
    exec "FileStyleDisable"
endif

"complete in command mode
if has("wildmenu")
    set wildignore+=*.a,*.o
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
    set wildmenu
endif



augroup au_annbeing
    autocmd!
    au BufNewFile,BufRead *.ejs set filetype=html
    au FileType toml,markdown,typescript,html,javascript,vue setlocal tabstop=2 shiftwidth=2
    au FileType sql vnoremap <Leader>se :DBExecVisualSQL<CR>
    \| noremap <Leader><Leader>r :DBExecSQLUnderCursor<CR>
    autocmd BufRead,BufNewFile *.xaml :set filetype=xml
    au FileType ejs autocmd BufRead,BufNewFile *.ejs :set filetype=html

    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> gi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
    autocmd FileType cs nnoremap <buffer> <leader>.  :OmniSharpGetCodeActions<CR>
    autocmd FileType cs nnoremap <buffer> gp :OmniSharpPreviewDefinition<CR>
    "autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
    autocmd FileType cs nnoremap <buffer> <F2> :OmniSharpRename<CR>
    autocmd FileType cs nnoremap <buffer> K :OmniSharpDocumentation<CR>
    autocmd FileType javascript,css,typescript setlocal iskeyword +=-
    autocmd FileType javascript,typescript,vue nmap <silent> <leader>. :CocFix<CR>
    \| nmap <silent> <F2> <Plug>(coc-rename)
    \| nmap gd <Plug>(coc-definition)
augroup end


"}}}

"{{{nickname
let $PROFILE = "~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1"
"}}}

"{{{easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <Leader>s <Plug>(easymotion-overwin-f2)
nmap <Leader>w <Plug>(easymotion-overwin-w)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
"}}}

"{{{coc
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"
 "Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

 "Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
"}}}

"{{{vim visual multi
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n
let g:VM_maps['skip and find next'] = '<C-k>'
"}}}

"{{{

let g:vimwiki_list = [
            \{'path':'E:\Notepad\Wiki\',
            \'path_html':'E:\Notepad\Wiki_html',
            \'ext':'.md',
            \'syntax':'markdown'}]
"}}}
"
"{{{ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" You can disable this option too
" " if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
"}}}

"{{{Tip
"guu :: make line lowercase
"gUU :: make line uppercase

"<c-x><c-f> complete file path

"if map is slow(like <leader>h)
"use :map <leader>h  to show all relate map

"c-f open command window
"t_kB shitf-Tab
":% g/foo/s/bar/zzz/g -- for every line containing "foo" substitute all "bar" with "zzz."
"
"K
"Run a program to lookup the keyword under the cursor.
"vimrctips
"https://www.reddit.com/r/vim/wiki/vimrctips#wiki_put_your_highlight_commands_in_an_autocmd

"show-current file full path
"C_G
"
"中文正则
"[^\x00-\xff]

"pedit preview

"hex
"%!xxd

"session
"mks  sessionpath
"source sessionPath

"copy math
"qaq
"g/regex/y A

"vim redir
"redir @a
"set guifont
"redir END

"clear history
"call histdel(':')

"clear message
"messages clear

"Type q: for commands, or q/ for searches; or
"Type : or / to start entering a command or search, then press the 'cedit' key
"}}}
