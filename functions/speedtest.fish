# Defined in /Users/tolgraven/.config/fish/functions/speedtest.fish @ line 2
function speedtest
status is-command-substitution
and speedtest-cli --simple
or speedtest-cli #| highlight # | ccze -A
end
