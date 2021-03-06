" vim/neovim settings by Kimmo Kulovesi <https://arkku.dev/>

if exists('g:loaded_arkku_settings') || &compatible
    finish
else
    let g:loaded_arkku_settings = 'yes'
endif

let g:surround_65 = "<a href=\"\">\r</a>"   " yssA to wrap sentence as link
let g:surround_66 = "{\n\t\r\n}"            " SB in V mode to wrap as a block
let g:surround_68 = "do\n\t\r\nend"         " cs{D to change {} into do/end

if has("autocmd")
    " VSB to wrap selection in a block ({}, begin/end) for the current language:
    au FileType ruby,eruby let surround_66 = "begin\n\t\r\nend"
    au FileType c,java,objc,cpp,javascript,go,cs,sh,bash,zsh let surround_66 = "{\n\t\r\n}"
    au FileType swift let surround_66 = "do {\n\t\r\n}"
    au FileType lua let surround_66 = "do\n\t\r\nend"
    au FileType html let surround_66 = "<div>\n\t\r\n</div>"

    " VSE to wrap selection in exception handling for the current language:
    au FileType ruby,eruby let surround_69 = "begin\n\t\r\nrescue Exception => e\nend"
    au FileType eiffel let surround_69 = "do\n\t\r\nrescue\nend"
    au FileType ada let surround_69 = "begin\n\t\r\nexception\nend;"
    au FileType java let surround_69 = "try {\n\t\r\n} catch (Exception e) {\n}"
    au FileType objc let surround_69 = "@try {\n\t\r\n} @catch (NSException *e) {\n}"
    au FileType cs let surround_69 = "try {\n\t\r\n} catch (System.Exception e) {\n}"
    au FileType javascript let surround_69 = "try {\n\t\r\n} catch (err) {\n}"
    au FileType cpp let surround_69 = "try {\n\t\r\n} catch (const std::exception& e) {\n}"
    au FileType swift let surround_69 = "do {\n\t\r\n} catch {\n}"
    au FileType python let surround_69 = "try:\n\t\r\nexcept Exception as e:\n"
    au FileType erlang let surround_69 = "try\n\t\r\ncatch\nend"

    " VSF to wrap selection in the equivalent of 'if false then ... endif':
    au FileType c,objc,cpp let surround_70 = "#if 0\n\r\n#endif"
    au FileType vim let surround_70 = "if 0\n\r\nendif"
    au FileType swift let surround_70 = "#if false\n\r\n#endif"
    au FileType ruby,eruby let surround_70 = "=begin\n\t\r\n=end"
    au FileType java,javascript,go,cs let surround_70 = "if (false) {\n\t\r\n}"
    au FileType python let surround_70 = "if False:\n\t\r\n"
    au FileType eiffel let surround_70 = "if False then\n\t\r\nend"
    au FileType lua let surround_70 = "if false then\n\t\r\nend"
    au FileType sh,bash,zsh let surround_70 = "if false; then\n\t\r\nfi"

    " Prefer new-style comments in C-like languages
    au FileType c,objc,cpp,swift setlocal commentstring=//%s
end

if exists('g:vscode')
    finish
endif

" Cycle windows if there are more than one, otherwise cycle buffers
" The argument is one of 'n', 'p', 'n!', or 'p!' (equivalent to the
" commands 'bn', 'bp', etc.
function! BufferCycleTab(direction)
    let wincount = winnr("$")
    if wincount > 1
        " There are several windows, cycle them
        if a:direction == "p" || a:direction == "p!"
            exe "wincmd W"
        else
            exe "wincmd w"
        endif
    else
        " Only one window, cycle buffers instead
        exe "silent! b" . a:direction
    endif
endfunction

" Tab to cycle windows or buffers
if empty(mapcheck('<Tab>', 'n'))
    nnoremap <silent> <Tab> <Esc>:call BufferCycleTab("n")<CR>
    nnoremap <silent> <S-Tab> <Esc>:call BufferCycleTab("p")<CR>

    " Map C-K to the old C-I (same as Tab)
    " mnemonic: OK - C-O / C-K jump cursor (Kursor?) locations
    if empty(mapcheck('<C-K>', 'n'))
        nnoremap <silent> <C-K> <C-I>
    endif
endif

" CtrlPFunky function search
if empty(mapcheck('<Leader>u', 'n'))
    nnoremap <Leader>u :CtrlPFunky<CR>
endif

" CtrlPFunky function search with word under cursor
if empty(mapcheck('<Leader>U', 'n'))
    nnoremap <Leader>U :execute 'CtrlPFunky ' . expand('<cword>')<CR>
endif

" \y and \p to copy/paste system clipboard
if empty(mapcheck('<Leader>y', 'n')) && empty(mapcheck('<Leader>p', 'n'))
    noremap <Leader>y "+y
    noremap <Leader>p "+p
endif

" \Y and \P to copy/paste tmux clipboard (vim-tbone plugin)
if empty(mapcheck('<Leader>Y', 'n')) && empty(mapcheck('<Leader>P', 'n'))
    noremap <Leader>Y :Tyank<CR>
    nnoremap <Leader>P :Tput<CR>
    vnoremap <Leader>P :Twrite<Space>
endif

if executable('fd') && !exists("g:ctrlp_user_command")
    " Use fd in CtrlP for listing files
    let g:ctrlp_user_command='fd -c never -- . %s 2>/dev/null'
endif

if executable('rg')
    " Use ripgrep over grep
    let g:ackprg='rg --vimgrep --no-heading'
elseif executable('ag')
    " Use Ag over grep
    let g:ackprg='ag --vimgrep'
endif

if executable('rg') || executable('ag') || executable('ack')
    if empty(mapcheck('<Leader>a', 'n')) || mapcheck('<Leader>a', 'n') =~ ':Ack'
        nnoremap <Leader>a :Ack!<Space>
    endif
    if empty(mapcheck('<Leader>A', 'n'))
        nnoremap <Leader>A :execute 'Ack! ' . expand('<cword>')<CR>
    endif
endif

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif
