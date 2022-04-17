" vim-plug
call plug#begin('~/.vim/plugged')
	Plug 'tpope/vim-surround'
	Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
call plug#end()

filetype plugin indent on

colorscheme challenger_deep
if has('nvim') || has('termguicolors')
  set termguicolors
endif

" --- end vim-plug
set nu
set rnu

set hlsearch

" 대소문자 무시
set ignorecase

set ts=2
set sw=2

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

" ToDo: coc.nvim 자동완성 (vscode language server 연동됨)
	" emmet - html 자동완성

