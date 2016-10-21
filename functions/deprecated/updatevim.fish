function updatevim
	profile vim
    set -lx SHELL (which sh)
    command nvim +BundleInstall! +BundleClean +qall
    profile $itermprofile_prev
    #"+BundleInstall! +BundleClean +qall"
end
