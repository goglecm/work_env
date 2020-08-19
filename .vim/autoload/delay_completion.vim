let g:CUSTOM__prevChar = ' '
let g:CUSTOM__prevPrevChar = ' '


let g:CUSTOM__feedTriggered = 0

function! IsGoodChar(ch)
    return ((a:ch >= 'a' && a:ch <= 'z') || (a:ch == '_') || (a:ch >= '0' && a:ch <= '9') || (a:ch >= 'A' && a:ch <= 'Z'))
endfunction


" function! IsOmniChar(ch)
"     return (a:ch == '.') || (a:ch == '>' && g:CUSTOM__prevChar == '-')
" endfunction


function! OpenCompletion()

    if (g:CUSTOM__feedTriggered == 0) && (!pumvisible() && ((IsGoodChar(v:char) &&
                                                           \ IsGoodChar(g:CUSTOM__prevChar) &&
                                                           \ IsGoodChar(g:CUSTOM__prevPrevChar) &&
                                                           \ (g:CUSTOM__prevPrevChar > '9')))) " || IsOmniChar(v:char)))

        let g:CUSTOM__feedTriggered = 1

        " if IsOmniChar(v:char)
        "     call feedkeys("\<C-x>\<C-n>", "t")
        " else if
        if IsGoodChar(v:char) && IsGoodChar(g:CUSTOM__prevChar) && IsGoodChar(g:CUSTOM__prevPrevChar)
            call feedkeys("\<C-x>\<C-p>", "t")
        else
            let g:CUSTOM__feedTriggered = 0
        endif

    else

        let g:CUSTOM__feedTriggered = 0

    endif

    if !pumvisible()
        let g:CUSTOM__prevPrevChar = g:CUSTOM__prevChar
        let g:CUSTOM__prevChar = v:char
    endif

endfunction


function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction


function! delay_completion#Enable()

    inoremap <expr> <tab> InsertTabWrapper()
    inoremap <s-tab> <c-n>

    set completeopt+=menuone,noinsert
    set completeopt-=preview

    autocmd InsertCharPre * call OpenCompletion()

endfunction
