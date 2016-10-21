function __tol_fzf_ctrl_r
	type -q fzf
    or return 1 #type -q ccat; and 
    set colorcmds "ccat --color=always" "ccze -A" "fish_indent --ansi" "cat" "vimcat -c 'setfiletype \"fish\"'"
    set colorcmd $colorcmds[1]
    set -l tmpfile "/tmp/fzfoutput"
    set linenr ( commandline --line )

    and set cmdline (commandline | string split "\n") #[ $linenr ] #| read -l cmdline #
    set cmdline (string trim -- "$cmdline[$linenr]")
    if not test -z "$cmdline" #oh yeah just quote and these wont need redirection to avoid it spewing, dummy. gah
        set cmdquery "-q $cmdline" #prepopulate search
    else
        set cmdquery ""
    end ##'echo /Users/tolgraven/.config/fish/fish_history \ #was below
    #| ack -x {} | string split cmd: | grep -v cmd: | grep -v .config/fish/fish_history' \
    set -l fzfopts "--no-sort +m --toggle-s ort=ctrl-r --preview='man {} \

--preview-window=right:40 \
--bind 'esc:toggle-preview,alt-enter:execute:/usr/local/bin/fish -c {}' $cmdquery" #(test -z $cmdquery; or echo -n $cmdquery)"
    if set -q tol_fzf_tmvux
        tmux new-session fish -c "history | eval $colorcmd | __fzfcmd $fzfopts | cgrep $cmdline > $tmpfile"
        and test -s $tmpfile
        and commandline -rb (cat $tmpfile)
    else
        history | eval $colorcmd | cgrep $cmdline | eval __fzfcmd "$fzfopts"
        c | read -l fzf_last_select
        test $fzf_last_select
        and commandline -rb -- "$fzf_last_select"
        and if test (count (commandline -o)) -gt 2
            commandline -rb -- (string join -- " " (commandline -o)[3..-1]) # > 2 tokens grab 3rd til last
        end
    end
    commandline -f repaint
end
