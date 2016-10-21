complete -c ccat -s C -l color -a "never always auto" -f
complete -c ccat -s bg -a "light dark" -f
complete -c ccat -s G -l "color-code" -d "set color codes. KEY=VALUE" -n "not __fish_contains_opt" -a "(__ccat_keys)" -f
complete -c ccat -s G -l "color-code" -d "set color codes. KEY=VALUE" -a "(__ccat_colors)" -f
#complete -c ccat
#complete -c ccat
function __ccat_keys
    set keys String= Keyword= Comment= Type= Literal= Punctuation= Plaintext= Tag= HTMLTag= HTMLAttrName= HTMLAttrValue= Decimal=

    echo -s -n $keys\t"key"\n
end
function __ccat_colors
    #set -l ctoken (commandline -ct)
    #switch $ctoken
        #case '*='
            set colors black, blink, blue, bold, brown, darkblue, darkgray, darkgreen, darkred, darkteal, darkyellow, faint, fuchsia, fuscia, green, lightgray, overline, purple, red, reset, standout, teal, turquoise, underline, white, yellow
            set colors (string replace "," "" $colors)

            echo -s -n $colors\t"color"\n
    #end
end
