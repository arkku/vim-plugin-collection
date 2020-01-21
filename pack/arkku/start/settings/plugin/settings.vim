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

if empty(mapcheck('<C-N>', 'n'))
    map <C-N> :NERDTreeToggle<CR>
endif

" Shortcut for the handy ^R=
if empty(mapcheck('<C-_>', 'i'))
    inoremap <C-_> <C-R>=
endif
"if empty(mapcheck('<C-S>', 'i'))
"endif

" Make p in visual mode paste over the selection without yanking it
vnoremap p "_dP

" \y and \p to copy/paste system clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p

" \Y and \P to copy/paste tmux clipboard (vim-tbone plugin)
noremap <Leader>Y :Tyank<CR>
noremap <Leader>P :Tput<CR>
vnoremap <Leader>Y :Tyank<CR>
vnoremap <Leader>P :Twrite<Space>

" Make vb to be like sb but for vertical splits
cabbrev vb vert sb

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

