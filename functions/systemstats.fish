function systemstats
    sudo systemstats $argv | strip_empty_lines | highlight | tint '=' blue
    #| surround "Ranked" "(tput smso)" "(tput rmso)" #| highlight
end
