" Author            : Xie Jin <xiejin@megvii.com>
" Date              : 01.08.2018
" Last Modified Date: 01.08.2018
" Last Modified By  : Xie Jin <xiejin@megvii.com>
" deoplete
let g:deoplete#enable_at_startup = 2
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:deoplete#sources = get(g:, 'deoplete#sources', {})
let g:deoplete#sources.f = ['file', 'buffer']
let g:deoplete#sources.f90 = ['file', 'buffer']

let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'


" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.html,*.js,*.css*.lua,*.bib,*.c,*.h,*.cpp,*.tex,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.f,*.f90,*.f03,*.f08,*.vim :call CleanExtraSpaces()
endif

" markdown
set number
set relativenumber
set nowrap


" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cco :botright copen<cr>
map <leader>ccl :ccl<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" ctags
:nnoremap <f5> :!ctags -R<CR>
" :autocmd BufWritePost * call system("ctags -R")

"resize window
:nnoremap <C-w>+ :resize +10<CR>
:nnoremap <C-w>- :resize -10<CR>
:nnoremap <C-w>> :vertical resize +15<CR>
:nnoremap <C-w>< :vertical resize -15<CR>
" notes:
"   <C-w>q: exit
"   <C-w>s: split
"   <C-w>v: vsplit
"   <C-w>H: move to the left
"   <C-w>L: move to the right


"jedi
let g:jedi#smart_auto_mappings = 0
"let g:jedi#completions_enabled = 0


" others
command! Notevim :e /home/jin/Documents/notes/vim-note.md

" vim-header
let g:header_field_author = 'Xie Jin'
let g:header_field_author_email = 'xiejin@megvii.com'
map <F4> :AddHeader<CR>
let g:header_auto_add_header = 0
let g:header_field_filename = 0


" ale
let g:ale_linters_explicit = 1
" let g:ale_linters = {'Python': ['pylint', 'flake8'],}
let g:ale_fixers = {
    \'Python': [
        \'isort',
    \],
\}
let g:ale_fix_on_save = 1
nnoremap <buffer> <silent> <LocalLeader>= :ALEFix<CR>

" autopep 8
" autocmd FileType python map <buffer> <F3> :call Autopep8()<CR>


" sort import
autocmd FileType python nnoremap <Leader>i :!isort %<CR><CR>

"
map <leader>s :e /home/xiejin/code_store/code_snippets.md<cr>


" ---------- auto paste image in vim mode -----------------
nnoremap <silent> <leader>p :call SaveFile()<cr>

function! SaveFile() abort
  let targets = filter(
        \ systemlist('xclip -selection clipboard -t TARGETS -o'),
        \ 'v:val =~# ''image''')
  if empty(targets) | return | endif

  let outdir = expand('%:p:h') . '/img'
  if !isdirectory(outdir)
    call mkdir(outdir)
  endif

  let mimetype = targets[0]
  let extension = split(mimetype, '/')[-1]
  let tmpfile = outdir . '/savefile_tmp.' . extension
  call system(printf('xclip -selection clipboard -t %s -o > %s',
        \ mimetype, tmpfile))

  let cnt = 0
  let filename = outdir . '/image' . cnt . '.' . extension
  while filereadable(filename)
    call system('diff ' . tmpfile . ' ' . filename)
    if !v:shell_error
      call delete(tmpfile)
      break
    endif

    let cnt += 1
    let filename = outdir . '/image' . cnt . '.' . extension
  endwhile

  if filereadable(tmpfile)
    call rename(tmpfile, filename)
  endif

  " let @* = '![](' . fnamemodify(filename, ':.') . ')'
  " let @* = '![](' . 'a/raw/b/img/image' . cnt . '.' . extension . ')'
  let @* = '![](' . 'img/image' . cnt . '.' . extension . ')'
  normal! "*p
endfunction
" ----------------------------------------------------------
"
"
"--------------------- markdown ---------------------------
nnoremap <leader><leader>m :!pandoc % --mathml -o .tmp.html && xdg-open .tmp.html<CR>

