function __deluge_prompt --on-variable deluge_prompt
set -l deluge "/Applications/Deluge.app/Contents/MacOS/deluge-console"
tol_reload_key_bindings
read --prompt 'printf "deluge command > "' out
and eval $deluge $out
commandline -f repaint #k
end
