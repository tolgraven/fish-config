function get_label --description 'get finder label (aka. tag)' --argument file get_term_color
	if not type -q hfsdata
        echoerr "deps: osxutils / hfsdata" #switch to tag evt... its a bit annoying tho
        return 1
    end
    set -l error
    set -l output
    test -z "$argv[1]"
    and set output (hfsdata -L ./ ^&-)

    or for i in (seq 1 (count $argv))
        test -e "$argv[$i]"
        and test -r "$argv[$i]"
        and set output[$i] (hfsdata -L $argv[$i] ^&-; or echo "None")
        or set output[$i] "None"
        test "$status" -gt 0
        and set error $status
    end

    set -q label_colors #correct order..
    or set -U label_colors Red Orange Yellow Green Blue Purple Gray None #Blue Green Gray None Orange Purple Red Yellow
    set -q label_colors_fish
    or set -U label_colors_fish red brred yellow green blue purple black normal #blue green black normal brred purple red bryellow
    #status --is-command-substitution
    if isatty 1 #color output if stdout is tty
        and status --is-interactive
        for i in (seq 1 (count $label_colors))
            set output (string replace -a -- $label_colors[$i] (set_color $label_colors_fish[$i])$label_colors[$i](set_color normal) $output)
        end
        #else
        #for i in (seq 1 (count $label_colors))
        #set output (string replace -a $label_colors[$i] $label_colors_fish[$i] $output)
        #end
    else if string match -q "*term" -- $get_term_color
        for i in (seq 1 (count $label_colors))
            set output (string replace -a $label_colors[$i] $label_colors_fish[$i] $output)
        end
    end
    test (count $output) -gt 1
    and echo -sn $output\n
    or echo $output
    test -z "$error"
    or return $error
end
