function __tol_bind_mode_hook --on-variable fish_bind_mode
	#call other func really only right? and find other way to get call every keypress.
    set -q tol_auto_describe
    and __tol_desc_token

    #if set -q __tol_desc_second

    #commandline -f insert-; 
    #commandline -f force-repaint
    #set -e __tol_desc_second

    #set -g last_commandline (commandline)
    #set -g last_commandline_pos (commandline -C)
    #commandline -f repaint
    #else if not test (commandline -L) -gt 1
    #set -g __tol_desc_second

    #commandline -f self-insert

    #commandline -f force-repaint
    #__tol_desc_token
    #end
end
