function set_label --argument label files
	if not type -q hfsdata
        echo "deps: osxutils / hfsdata"
        return 1
    end
    if test -z $label
        echo "must specify a label. oh wait maybe get and set should be in the same function lol"
        return 1
    end
    test -z $files
    and set files (pwd)

    #count $files #apparently extra args don't get appended to last arg so only argv then :(
    set output (test (count $argv) -gt 2; and for file in $argv[2..-1]; command setlabel $label $file; end; or command setlabel $label $files)
    set output (echo $output\t | paste - - -)
    set -q label_colors
    or set -U label_colors Blue Green Gray None Orange Purple Red Yellow
    set -q label_colors_fish
    or set -U label_colors_fish blue green black normal brred purple red yellow
    isatty 1
    and for i in (seq 1 (count $label_colors))
        set output (string replace -a $label_colors[$i] (set_color $label_colors_fish[$i])$label_colors[$i](set_color normal) $output)
    end
    echo -n $output\n
end
