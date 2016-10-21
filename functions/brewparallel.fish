function brewparallel
	set pipecmd "cat --color=always | grep --color=always -v '.rb' | grep --color=always --before-context 1 'http'"
    set results (spin "brew search $argv")
    set descriptions (echo $results | parallel -X brew info)

    for i in (count $results)
        set res $results[$i]
        set desc $descriptions[$i]
        if eval (echo $res | grep -v --silent cask; and echo $res | grep -v --silent homebrew/)
            inline: (tint: blue (bold: "BREW   ") (tint: lightgray "$res")) #| for arg in $argv
            #grep --color=always $arg
            #end
            echo $desc | eval $pipecmd
        else if eval (echo $res | grep --silent cask)
            inline: (tint: green (bold: "CASK   ") (tint: lightgray "$res")) #| for arg in $argv
            #grep --color=always $arg
            #end
            echo $desc | eval $pipecmd

        end
    end
end
