function imgcat
	~/.iterm2/imgcat $argv ^&-
    and return 0
    if test -e ~/.local/go/bin/imgcat #breaks when libstderred loaded :(
        ~/.local/go/bin/imgcat $argv #fastest
    else if test -e /usr/local/bin/imgcat
        test -z $TERM_PROGRAM
        and set -gx TERM_PROGRAM iTerm.app
        /usr/local/bin/imgcat $argv ^&- #slow as baaaaalls
    else if test -e ~/.iterm2/imgcat
        ~/.iterm2/imgcat $argv
    end
end
