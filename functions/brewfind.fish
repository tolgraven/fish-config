function brewfind
	set -l pipecmd "cat --color=always | grep --color=always -v '.rb' | grep --color=always --before-context 1 'http'"

    if eval (echo $argv | grep -v --silent cask; and echo $argv | grep -v --silent homebrew/)
        inline: (tint: blue (bold: "BREW   ") (tint: lightgray "$argv")) | grep --color=always $argv
        brew info $argv | eval $pipecmd
    else if eval (echo $argv | grep --silent cask)
        inline: (tint: green (bold: "CASK   ") (tint: lightgray (string split -r / $argv)[-1]) ) | grep --color=always $argv
        brew cask info $argv | eval $pipecmd

    end
end
