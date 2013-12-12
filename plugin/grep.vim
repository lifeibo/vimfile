" File: grep.vim

if exists("loaded_grep")
    finish
endif
let loaded_grep = 1

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

" Location of the grep utility
if !exists("Grep_Path")
    let Grep_Path = 'grep'
endif

" Location of the find utility
if !exists("Grep_Find_Path")
    let Grep_Find_Path = 'find'
endif

" Location of the xargs utility
if !exists("Grep_Xargs_Path")
    let Grep_Xargs_Path = 'xargs'
endif

" Default grep file list
if !exists("Grep_Default_Filelist")
    let Grep_Default_Filelist = '*'
endif

" Default grep options
if !exists("Grep_Default_Options")
    let Grep_Default_Options = ''
endif

" NULL device name to supply to grep.  We need this because, grep will not
" print the name of the file, if only one filename is supplied. We need the
" filename for Vim quickfix processing.
if !exists("Grep_Null_Device")
    if has("win32") || has("win16") || has("win95")
        let Grep_Null_Device = 'NUL'
    else
        let Grep_Null_Device = '/dev/null'
    endif
endif

" Character to use to quote patterns and filenames before passing to grep.
if !exists("Grep_Shell_Quote_Char")
    if has("win32") || has("win16") || has("win95")
        let Grep_Shell_Quote_Char = ''
    else
        let Grep_Shell_Quote_Char = "'"
    endif
endif

" Character to use to escape special characters before passing to grep.
if !exists("Grep_Shell_Escape_Char")
    if has("win32") || has("win16") || has("win95")
        let Grep_Shell_Escape_Char = ''
    else
        let Grep_Shell_Escape_Char = '\'
    endif
endif

" The list of directories to skip while searching for a pattern. Set this
" variable to '', if you don't want to skip directories.
if !exists("Grep_Skip_Dirs")
    let Grep_Skip_Dirs = 'RCS CVS SCCS'
endif

" The list of files to skip while searching for a pattern. Set this variable
" to '', if you don't want to skip any files.
if !exists("Grep_Skip_Files")
    let Grep_Skip_Files = '*~ *,v s.*'
endif

" RunGrepCmd()
" Run the specified grep command using the supplied pattern
function! s:RunGrepCmd(cmd, pattern)
    let cmd_output = system(a:cmd)

    if cmd_output == ""
        echohl WarningMsg | 
        \ echomsg "Error: Pattern " . a:pattern . " not found" | 
        \ echohl None
        return
    endif

    let tmpfile = tempname()

    let old_verbose = &verbose
    set verbose&vim

    exe "redir! > " . tmpfile
    silent echon '[Search results for pattern: ' . a:pattern . "]\n"
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

    botright copen 2

    call delete(tmpfile)
endfunction

" RunGrepRecursive()
" Run specified grep command recursively
function! s:RunGrepRecursive(cmd_name, ...)
    let grep_opt = g:Grep_Default_Options
    let pattern     = ""
    let grep_path = g:Grep_Path
    let grep_expr_option = '--'

    if a:0 >= 1
        let pattern = a:{1}
        let num = 2
        while num <= a:0
            let pattern = pattern . " " . a:{num}
            let num = num + 1
        endwhile
    endif

    " No argument supplied. Get the identifier and file list from user
    if pattern == "" 
        let pattern = input("Search for pattern: ", expand("<cword>"))
        if pattern == ""
            return
        endif
        let pattern = g:Grep_Shell_Quote_Char . pattern . 
                        \ g:Grep_Shell_Quote_Char
    endif

    let startdir = getcwd()
    let filepattern = g:Grep_Default_Filelist

    let txt = filepattern . ' '
    let find_file_pattern = ''
    while txt != ''
        let one_pattern = strpart(txt, 0, stridx(txt, ' '))
        if find_file_pattern != ''
            let find_file_pattern = find_file_pattern . ' -o'
        endif
        let find_file_pattern = find_file_pattern . ' -name ' .
              \ g:Grep_Shell_Quote_Char . one_pattern . g:Grep_Shell_Quote_Char
        let txt = strpart(txt, stridx(txt, ' ') + 1)
    endwhile
    let find_file_pattern = g:Grep_Shell_Escape_Char . '(' .
                    \ find_file_pattern . ' ' . g:Grep_Shell_Escape_Char . ')'

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
        let find_prune = '-type d ' . g:Grep_Shell_Escape_Char . '(' .
                         \ find_prune
        let find_prune = find_prune . ' ' . g:Grep_Shell_Escape_Char . ')'
    endif

    let txt = g:Grep_Skip_Files
    let find_skip_files = '-type f'
    if txt != ''
        let txt = txt . ' '
        while txt != ''
            let one_file = strpart(txt, 0, stridx(txt, ' '))
            let find_skip_files = find_skip_files . ' ! -name ' .
                                  \ g:Grep_Shell_Quote_Char . one_file .
                                  \ g:Grep_Shell_Quote_Char
            let txt = strpart(txt, stridx(txt, ' ') + 1)
        endwhile
    endif

    let cmd = g:Grep_Find_Path . " " . startdir
    let cmd = cmd . " " . find_prune . " -prune -o"
    let cmd = cmd . " " . find_skip_files
    let cmd = cmd . " " . find_file_pattern
    let cmd = cmd . " | "
    let cmd = cmd . g:Grep_Xargs_Path . ' '
    let cmd = cmd . ' ' . grep_path . " " . grep_opt . " -n "
    let cmd = cmd . grep_expr_option . " '" . pattern . "'"
    let cmd = cmd . ' ' . g:Grep_Null_Device 

    call s:RunGrepCmd(cmd, pattern)
endfunction

" Define the set of grep commands
command! -nargs=* -complete=file Grepold
            \ call s:RunGrepRecursive('Rgrep', <f-args>)

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

