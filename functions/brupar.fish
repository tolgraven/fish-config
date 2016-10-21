function brupar
	set -l pipecmd 'cat --color=always | grep --color=always -v ".rb" | grep --color=always --before-context 1 "http"'
    begin
        if eval (echo {} | grep -v --silent cask; and echo {} | grep -v --silent homebrew/)
            inline: (tint: blue (bold: "BREW   ") (tint: lightgray {}   ))
            brew info {} | eval $pipecmd

        else if eval (echo {} | grep --silent cask)
            inline: (tint: green (bold: "CASK   ") (tint: lightgray (string split -r / {})[-1])   )
            brew cask info {} | eval $pipecmd
        end
    end
end
