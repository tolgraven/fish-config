function __tol_fzf_ctrl_r
    type -q fzf
    or return 1
    set colorcmd "fish_indent --ansi --no-indent"
    set -l tmpfile "/tmp/fzfoutput"

    set linenr (commandline --line)
    set cmdline (commandline | string split "\n") #set cmdline (string trim -- (commandline | string split "\n")[$linenr]\n)
    set cmdline (string trim -- "$cmdline[$linenr]")
    test -z "$cmdline" #just quote and these wont need redir to avoid spewing, dummy
    and set cmdquery ""
    or set cmdquery "-q $cmdline\ " #prepopulate search
    debug "linenr %s, cmdquery %s" -- $linenr $cmdquery

    set -l preview 'history search --show-time --exact {} | fish_indent --ansi'
    set -l fzfopts "--no-sort +m --toggle-sort=ctrl-r --preview='$preview' --preview-window=down:3 \
--bind 'alt-p:toggle-preview,alt-enter:execute:/usr/local/bin/fish -c {}' $cmdquery"

    set -l fish_term24bit 0
    #set -l had24color $fish_term24bit
    #set fish_term24bit 0

    #if set -q tol_fzf_tmux
    #debug -- "tmux window go"
    #tmux new-session fish -c "history | eval $colorcmd | eval (__fzfcmd) '$fzfopts' | cgrep $cmdline > $tmpfile"
    #and test -s $tmpfile
    #and commandline -rb (cat $tmpfile)
    #return
    #end
    debug -- "normal fzf window %s %s %s" $colorcmd $cmdline $fzfopts

    if test -z "$cmdline"
        set hist (history)
        set histsize (count $hist)
        set incr 10000
        if test $histsize -gt $incr
            set from 1
            set to $incr
            while test $to -ne $histsize #debug "from %s, to %s, incr %s" $from $to $incr
                set lines $lines (echo -ns $hist[$from..$to]\n | fish_indent --ansi --no-indent)

                set from (math "$to+1")
                set to (math "$to+$incr")
                test $to -gt $histsize
                and set to $histsize
            end
            echo -ns $lines\n | eval (__fzfcmd) "$fzfopts" | read --array fzf_last_select
        end
    else
        history search --contains $cmdline | eval $colorcmd | eval (__fzfcmd) "$fzfopts" | read --array fzf_last_select
    end

    debug "fzf selection: %s" $fzf_last_select
    test $fzf_last_select[1]
    and commandline -rb -- "$fzf_last_select" #and if test (count (commandline -o)) -gt 2; commandline -rb -- (string join -- " " (commandline -o)[3..-1]); end #>2 tok use 3..last if inline timestamps

    #set fish_term24bit $had24color
    commandline -f repaint
end
