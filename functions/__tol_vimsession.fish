function __tol_vimsession
commandline_save before_vim
commandline 'vimsession '
commandline -f complete
commandline -f complete-and-search
end
