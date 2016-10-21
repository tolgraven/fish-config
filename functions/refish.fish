function refish --description 'reset/reload fish without restarting it'
	history --merge
    source ~/.config/fish/conf.d/* #init_joen.config.fish
    source ~/.config/fish/config.fish
    tol_reload_key_bindings
end
