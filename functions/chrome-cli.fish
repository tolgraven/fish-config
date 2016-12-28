function chrome-cli
    isatty 1
    and command chrome-cli $argv | highlight #ccze -A #cat #| ccat
    or command chrome-cli $argv
end
