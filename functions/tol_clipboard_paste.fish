function tol_clipboard_paste
	if type -q pbpaste
        commandline -i -- (pbpaste) | fish_indent
    else if type -q xsel
        commandline -i -- (xsel --clipboard) | fish_indent
    end
end
