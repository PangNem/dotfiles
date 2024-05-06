"-----------------------------------------------------------------------"
" Vundle 환경설정
"------------------------------------------------------------------------"
" filetype off                   " required!
set shell=/bin/bash
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	" let Vundle manage Vundle
	" required! 
	Plugin 'VundleVim/Vundle.vim'

	" vim 하단에 파일 정보 띄우기
	Plugin 'vim-airline/vim-airline' 
	" ...
call vundle#end()
filetype plugin indent on     " required!
	"
	" Brief help
	" :BundleList          - list configured bundles
	" :BundleInstall(!)    - install(update) bundles
	" :BundleSearch(!) foo - search(or refresh cache first) for foo
	" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
	"
	" see :h vundle for more details or wiki for FAQ
	" NOTE: comments after Bundle command are not allowed..


" vim-plug
call plug#begin('~/.vim/plugged')
	Plug 'tpope/vim-surround'
	Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
	Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
	Plug 'mhinz/vim-startify'
	Plug 'Valloric/YouCompleteMe'
	Plug 'johngrib/vim-f-hangul'

	Plug 'img-paste-devs/img-paste.vim'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

	" markdown 
	Plug 'godlygeek/tabular'
	Plug 'preservim/vim-markdown'
	Plug 'cespare/vim-toml'
call plug#end()

" filetype plugin indent on
set nocompatible
filetype plugin on
syntax on

" colorscheme challenger_deep
call plug#end()

filetype plugin indent on

colorscheme challenger_deep
if has('nvim') || has('termguicolors')
  set termguicolors
endif

" --- end vim-plug
set nu
set rnu

set ts=4
set sw=2

set hlsearch
set smartcase
" 대소문자 무시
set ignorecase

set visualbell
set noerrorbells

nnoremap <Enter> o<Esc>
" nnoremap <C-a> <C-u>

syntax on

set belloff=all

" 매치되는 괄호 표시
set showmatch

" Find Word
" 오름차순 1,2,3,4,5
func! N_find_word_asc()
    let l:toplinenum=winsaveview().topline
    call feedkeys("*N\<ESC>:call winrestview({'topline' : ".l:toplinenum."})\<CR>:\<BS>", 'n')
    let @/ = '\<'.expand('<cword>').'\>'
endfunc

func! N_find_word_desc()
 let l:toplinenum=winsaveview().topline
 call feedkeys("#N\<ESC>:call winrestview({'topline' : ".l:toplinenum."})\<CR>:\<BS>", 'n')
 let @/ = '\<'.expand('<cword>').'\>'
endfunc

func! V_find_word_asc()
 let l:newWord = Get_visual_selection()
 let l:newWord = substitute(l:newWord, "\\", "\\\\\\\\", "g")
 let @/ = l:newWord
endfunc

nnoremap <silent> # <ESC>:call N_find_word_asc()<CR>
nnoremap <silent> # <ESC>*Nzz
vnoremap <silent> # <ESC>:call V_find_word_asc()<CR>
nnoremap <silent> * <ESC>:call N_find_word_desc()<CR>

" 20230528 - intellij window resize 테스트

nmap <C-w>\| <Action>(MaximizeEditorInSplit)
" even though it's the same command map it for muscle memory
nmap <C-w>= <Action>(MaximizeEditorInSplit)

nmap <C-w><Down> <Action>(StretchSplitToBottom)
nmap <C-w><Left> <Action>(StretchSplitToLeft)
nmap <C-w><Right> <Action>(StretchSplitToRight)
nmap <C-w><Up> <Action>(StretchSplitToTop)


" ToDo: coc.nvim 자동완성 (vscode language server 연동됨)
	" emmet - html 자동완성
	"

" tmux 하이라이팅을 위한 설정
set t_Co=256
set term=xterm-256color

packadd! omni 
colorscheme omni

" --- vimwiki 설정 파일들 - https://johngrib.github.io/wiki/vimwiki/

let maplocalleader = "\\"

let wiki = {}
let wiki.path = '~/source/jxmen/wiki/_wiki'
let wiki.ext = '.md'
let diary_rel_path = '.'

let g:vimwiki_list = [wiki]

" vimwiki의 conceallevel 을 끄는 쪽이 좋다
let g:vimwiki_conceallevel = 0

" 자주 사용하는 vimwiki 명령어에 단축키를 취향대로 매핑해둔다
command! WikiIndex :VimwikiIndex
nmap <LocalLeader>ww <Plug>VimwikiIndex
nmap <LocalLeader>wi <Plug>VimwikiDiaryIndex
nmap <LocalLeader>w<LocalLeader>w <Plug>VimwikiMakeDiaryNote
nmap <LocalLeader>wt :VimwikiTable<CR>

" F4 키를 누르면 커서가 놓인 단어를 위키에서 검색한다.
nnoremap <F4> :execute "VWS /" . expand("<cword>") . "/" <Bar> :lopen<CR>

" Shift F4 키를 누르면 현재 문서를 링크한 모든 문서를 검색한다
nnoremap <S-F4> :execute "VWB" <Bar> :lopen<CR>

let g:ycm_filetype_blacklist = {}
let g:md_modify_disabled = 0

function! LastModified()
    if g:md_modify_disabled
        return
    endif
    if &modified
        " echo('markdown updated time modified')
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
            \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun

function! NewTemplate()
    let l:wiki_directory = v:false

    for wiki in g:vimwiki_list
        if expand('%:p:h') =~ expand(wiki.path)
            let l:wiki_directory = v:true
            break
        endif
    endfor

    if !l:wiki_directory
        return
    endif

    if line("$") > 1
        return
    endif

    let l:template = []
    call add(l:template, '---')
    call add(l:template, 'layout  : wiki')
    call add(l:template, 'title   : ')
    call add(l:template, 'summary : ')
    call add(l:template, 'date    : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'updated : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'tag     : ')
    call add(l:template, 'toc     : true')
    call add(l:template, 'public  : true')
    call add(l:template, 'parent  : ')
    call add(l:template, 'latex   : false')
    call add(l:template, 'resource: ' . substitute(system("uuidgen"), '\n', '', ''))
    call add(l:template, '---')
    call add(l:template, '* TOC')
    call add(l:template, '{:toc}')
    call add(l:template, '')
    call add(l:template, '# ')
    call setline(1, l:template)
    execute 'normal! G'
    execute 'normal! $'

    echom 'new wiki page has created'
endfunction

augroup vimwikiauto
    autocmd BufWritePre *wiki/*.md call LastModified()
    autocmd BufRead *wiki/*.md call NewTemplate()
    autocmd BufNewFile *wiki/*.md call NewTemplate()
augroup END

" Vim SYNTAX EXTENSIONS
" Disable Folding
let g:vim_markdown_folding_disabled = 1
" YAML Front Matter
let g:vim_markdown_frontmatter = 1

autocmd BufRead *.md setlocal syntax=markdown 

