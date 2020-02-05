function! ctrlp#funky#ft#man#filters()
    let filters = [
            \ { 'pattern': '^[A-Z0-9]',
            \   'formatter': ['', '', ''] }
    \ ]
    return filters
endfunction
