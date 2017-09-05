function cd --description 'Change directory'
    set -l MAX_DIR_HIST 25
    if test (count $argv) -gt 1
        printf "%s\n" (_ "Too many args for cd command")
        return 1
    else if status --is-command-substitution # Skip history in subshells.
        builtin cd $argv
        return $status
    end
    set -l previous $PWD # Avoid set completions.

    if test "$argv" = "-"
        if test "$__fish_cd_direction" = "next"
            nextd
        else
            prevd
        end
        return $status
    end
    if test -f "$argv" #tol check, if is file
        set dir (dirname $argv)
        debug "hit file %s, cd to its dir %s" $argv $dir
        test -d "$dir"
        and set argv $dir
    end

    builtin cd $argv
    set -l cd_status $status
    set -lx CLICOLOR_FORCE 1
    set -l ls (ls -G); set -l lscount (count $ls)
    test $lscount -gt 20
    and set ls (set_color brred)$lscount" files, 20 most recent: "(set_color normal) (ls -Gtr)[-20..-1]
    and set -l lscount (count $ls)

    if status is-interactive
        clear_below_cursor
        tput cud1 #so we skip past out coming prompt and draw under it
        commandline -f repaint #why?
        set spaces 3 # 1 auto, 2 from added
        set lslines (math \($spaces\*$lscount + (string length -- (echo "$ls" | strip_ansi_color)) \) / $COLUMNS + 1) # lscount to take extra speces into count... +1 so rounds up

        # echo (set_color -b black)$ls(set_color normal)\ 
        set -l output (set_color -b black)$ls(set_color normal)\ \ 
        # set -l output (set_color -b black)$ls(set_color normal)\t
        # set lslines (math (string length -- (echo "$output" | strip_ansi_color)) / $COLUMNS + 1) # +1 so rounds up. string length on \t only gets one so prob off in some cases...
        echo $output
        tput cuu 1 #restore skip
        test $lslines -gt 0; and tput cuu $lslines #restore pos from any actually written lines

    end

    if test $cd_status -eq 0 -a "$PWD" != "$previous"
        set -q dirprev[$MAX_DIR_HIST]
        and set -e dirprev[1]
        set -g dirprev $dirprev $previous
        set -e dirnext
        set -g __fish_cd_direction prev
    end

    return $cd_status
end
