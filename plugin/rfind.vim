if exists("loaded_findr")
    finish
endif
let loaded_find = 1

function! s:RunFindCmd(cmd, ...)

    if a:0 == 0 
        echo 'Usage: ' . a:cmd . " <search_pattern> "
        return
    endif

    let pattern = a:{1}
    let num = 2
    while num <= a:0
        let pattern = pattern . " " . a:{num}
        let num = num + 1
    endwhile

    let cwd = '.'

    let txt = g:Grep_Skip_Dirs
    let find_prune = ''
    if txt != ''
        let txt = txt . ' '
        while txt != ''
            let one_dir = strpart(txt, 0, stridx(txt, ' '))
            if find_prune != ''
                let find_prune = find_prune . ' -o'
            endif
            let find_prune = find_prune . ' -name ' . one_dir
            let txt = strpart(txt, stridx(txt, ' ') + 1)
        endwhile
        let find_prune = '-type d \\\(' .
                         \ find_prune
        let find_prune = find_prune . ' \\\)'
    endif

    let txt = g:Grep_Skip_Files
    let find_skip_files = '-type f'
    if txt != ''
        let txt = txt . ' '
        while txt != ''
            let one_file = strpart(txt, 0, stridx(txt, ' '))
            let find_skip_files = find_skip_files . ' ! -name ' .
                                  \ "\'" . one_file .
                                  \ "\'" 
            let txt = strpart(txt, stridx(txt, ' ') + 1)
        endwhile
    endif

    let cmd = "all find " . cwd
    let cmd = cmd . " " . find_prune . " -prune -o"
    let cmd = cmd . " " . find_skip_files

    let exe = cmd . "  -name \'*" . pattern . "*\' -exec echo {}:0:0 \\\\\\;"

    let cmd_output = system(exe)

    if cmd_output == ""
        echohl WarningMsg | 
        \ echomsg "Error: Pattern " . pattern . " not found" | 
        \ echohl None
        return
    endif

    let tmpfile = tempname()

    let old_verbose = &verbose
    set verbose&vim

    exe "redir! > " . tmpfile
    silent echon '[Search results for pattern: ' . pattern . "]\n"
    silent echon cmd_output
    redir END

    let &verbose = old_verbose

    let old_efm = &efm
    set efm=%f:%\\s%#%l:%m

    if exists(":cgetfile")
        execute "silent! cgetfile " . tmpfile
    else
        execute "silent! cfile " . tmpfile
    endif

    let &efm = old_efm
    
    " Open the quickfix window below the current window
    botright copen 2

    call delete(tmpfile)

endfunction

" Define the set of grep commands
command! -nargs=* -complete=file Find
            \ call s:RunFindCmd('Find', <f-args>)
