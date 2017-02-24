function refish --description 'reset/reload fish without restarting it'
history --merge
source ~/.config/fish/conf.d/* #init_joen.config.fish
source ~/.config/fish/config.fish
tol_reload_key_bindings
tput civis

#echo -n (tput hpa 3)"re-sourcing fish stuff..."
#spin "sleep 0.2"
echo -n (tput hpa 0)"re-sourcing fish stuff..."
sleep 0.2

commandline -f repaint
tput cnorm
end
