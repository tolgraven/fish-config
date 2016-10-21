function hp --description 'history search prefix'
	history --prefix $argv | ccat | grep $argv[(count $argv; or echo 1)] | fzf --ansi
end
