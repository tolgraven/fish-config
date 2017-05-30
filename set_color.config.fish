# NAME
#   set_color [options] [COLOR]
#
# SYNOPSIS
#   Extend set_color with new colors and options.
#
# OPTIONS
#   --pretty  Use with [-c --print-colors] to display colors in their actual
#             color.

function set_color -d "Set the terminal color." --shadow-builtin
    if test (count $argv) -gt 0
        set -l orange FFA500
        set -l Orange $orange
        set -l gold FFD700
        set -l lime 00FF00
        set -l teal 008080
        set -l violet EE82EE
        set -l pink FFC0CB
        set -l Pink $pink
        set -l gray 808080
        set -l Gray $gray
        
        set -l new_colors Orange orange gold lime teal violet Pink pink Gray gray

        switch $argv[1]
            case -c --print-colors
                contains -- --pretty in $argv
                and set -l pretty
                for color in (builtin set_color -c) $new_colors
                    set -q pretty
                    and set_color $color
                    echo $color
                end
                set -q pretty
                and set_color normal
                return 0
        end

        for color in $new_colors
            if set -l index (contains -i $color $argv)
                set argv[$index] $$color
                break
            end
        end
    end

    builtin set_color $argv
end
