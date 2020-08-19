
let s:lastbname=""

func! TmuxBufferName()
    let l:list = systemlist('tmux list-buffers -F"#{buffer_name}"')
    if len(l:list)==0
        return ""
    else
        return l:list[0]
    endif
endfunc

func! TmuxBuffer()
    return system('tmux show-buffer')
endfunc

func! Update_from_tmux()
    "let buffer_name = TmuxBufferName()
    "if s:lastbname != buffer_name
        let @" = TmuxBuffer()
    "endif
    "let s:lastbname=TmuxBufferName()
endfunc

func! vimtmuxclipboard#Enable()

    if $TMUX==''
        " not in tmux session
        return
    endif


    " if support TextYankPost
    if exists('##TextYankPost')==1
        " @"
        augroup vimtmuxclipboard
            autocmd!
            autocmd FocusLost * call Update_from_tmux()
            autocmd	FocusGained   * call Update_from_tmux()
            autocmd TextYankPost * silent! call system('tmux loadb -',join(v:event["regcontents"],"\n"))
        augroup END
        let @" = TmuxBuffer()
    else
        " vim doesn't support TextYankPost event
        " This is a workaround for vim
        augroup vimtmuxclipboard
            autocmd!
            autocmd FocusLost     *  silent! call system('tmux loadb -',@")
            autocmd	FocusGained   *  let @" = TmuxBuffer()
        augroup END
        let @" = TmuxBuffer()
    endif

endfunc


