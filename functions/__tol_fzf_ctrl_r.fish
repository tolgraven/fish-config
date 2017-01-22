function __tol_fzf_ctrl_r
    type -q fzf
    or return 1
    set colorcmd "fish_indent --ansi"
    set -l tmpfile "/tmp/fzfoutput"

    set linenr (commandline --line)
    and set cmdline (commandline | string split "\n")
    set cmdline (string trim -- "$cmdline[$linenr]")
    test -z "$cmdline" #just quote and these wont need redir to avoid spewing, dummy
    and set cmdquery ""
    or set cmdquery "-q $cmdline" #prepopulate search
    debug "cmdquery %s" -- $cmdquery
    #| ack -x {} | string split cmd: | grep -v cmd: | grep -v .config/fish/fish_history' \
    #--preview='fish -c mancat (string split \' \' -- {})[1]' --preview-window=right:40 \#2nd line below
    set -l preview 'history search --show-time --exact {} | fish_indent --ansi'
    set -l fzfopts "--no-sort +m --toggle-sort=ctrl-r --preview='$preview' --preview-window=down:3 \
--bind 'alt-p:toggle-preview,alt-enter:execute:/usr/local/bin/fish -c {}' $cmdquery"
    set -q fish_term24bit #need to flip off 24bit color because fzf bugs out...
    and set -l had24color $fish_term24bit
    and set fish_term24bit 0

    if set -q tol_fzf_tmux
        debug -- "tmux window go"
        tmux new-session fish -c "history | eval $colorcmd | eval  __fzfcmd $fzfopts | cgrep $cmdline > $tmpfile"
        and test -s $tmpfile
        and commandline -rb (cat $tmpfile)

    else
        debug -- "normal fzf window %s %s %s" $colorcmd $cmdline $fzfopts
        #history | string match "*$cmdline*" | eval $colorcmd | eval (__fzfcmd) "$fzfopts" | read -l --array fzf_last_select
        test -z "$cmdline"
        and set histcmd "history"
        or set histcmd "history search --contains '$cmdline'"
        debug "histcmd: %s" $histcmd

        eval $histcmd | eval $colorcmd | eval (__fzfcmd) "$fzfopts" | read -l --array fzf_last_select

        test $fzf_last_select[1]
        and commandline -rb -- "$fzf_last_select"
        #and if test (count (commandline -o)) -gt 2; commandline -rb -- (string join -- " " (commandline -o)[3..-1]); end #>2 tok use 3..last if inline timestamps
    end
    set -q had24color
    and set fish_term24bit $had24color
    commandline -f repaint
end
