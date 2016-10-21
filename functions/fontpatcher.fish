function fontpatcher
	pushd (pwd)

    set -l fontdir ~/Library/Fonts
    set -l patcherdir /V/SO-FUNKY/CODE/fonts-themes/nerd-fonts/
    cd $patcherdir
    ./font-patcher --out $fontdir --fontawesome --fontlinux --octicons --pomicons --powerline --powerlineextra --careful $fontdir/$argv[-1]
    popd
end
