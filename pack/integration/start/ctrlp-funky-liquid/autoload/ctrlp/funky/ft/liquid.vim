" Language: Liquid Markdown and HTML

function! ctrlp#funky#ft#liquid#filters()
    if b:liquid_subtype == 'markdown'
        return ctrlp#funky#ft#markdown#filters()
    elseif b:liquid_subtype == 'html'
        return ctrlp#funky#ft#html#filters()
    endif
endfunction

function! ctrlp#funky#ft#liquid#post_extract_hook(list)
    if b:liquid_subtype == 'markdown'
        return ctrlp#funky#ft#markdown#post_extract_hook(a:list)
    else
        return a:list
    endif
endfunction
