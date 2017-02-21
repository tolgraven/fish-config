function fontpatcher
set -l fontdir ~/Library/Fonts
set -l patcherdir /V/SO-FUNKY/CODE/fonts-themes/nerd-fonts/
pushd $patcherdir
#set -l font_types --fontawesome --fontawesomeextension --fontlinux --powersymbols --octicons --pomicons --powerline --powerlineextra
set -l font_types --complete
for arg in $argv
./font-patcher --progressbars --careful $font_types --out $fontdir $fontdir/$arg
end
popd
end
