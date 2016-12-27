function imgcat
	contains -- '-t' $argv #joen thumbnail mode
    and set -l flags -size 30, -p #preserve aspect ratio, size in rows, tho 30 turns into 7-8 for 16/9 img heh
    and set -l index (contains -i -- '-t' $argv)
    and set -e argv[$index]

    ~/.iterm2/imgcat $flags $argv ^&-
    and return 0 #skips past this one if passing flags etc cause it errors then obv

    if test -e ~/.local/go/bin/imgcat #breaks when libstderred loaded :( #well that fucker broke everything so fuck him
        ~/.local/go/bin/imgcat $flags $argv #fastest
    else if test -e /usr/local/bin/imgcat
        test -z $TERM_PROGRAM
        and set -gx TERM_PROGRAM iTerm.app
        /usr/local/bin/imgcat $argv ^&- #slow as baaaaalls
    else if test -e ~/.iterm2/imgcat
        ~/.iterm2/imgcat $argv
    end
end
