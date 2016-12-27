function contrast
	set -l output
    not test -z "$argv"
    and switch "$argv[1]"
        case 'up'
            test (contrast) -le 95
            and contrast (math (contrast) + 5)
            return
        case 'down'
            test (contrast) -ge 5
            and contrast (math (contrast) - 5)
            return
        case '*'
            set -U contrast_unscaled $argv[1]
            set scaled (math "$contrast_unscaled / 1.4")
            set asus (math "$scaled / 1.8 + 30")
            set output (echo (ddcctl -d 1 -c $scaled | string sub -s -3)[-1])
            and ddcctl -d 2 -c $asus >/dev/null
    end
    or set -q contrast_unscaled
    and echo $contrast_unscaled
    or begin
        set output[1] (echo (ddcctl -d 1 -c \? | string sub --start=-13 --length=3)[-1])
        set output[2] (echo (ddcctl -d 2 -c \? | string sub --start=-13 --length=3)[-1])
        set contrast_out (echo $output | string replace '>' '' | string trim)
        echo $contrast_out
    end
end
