function mkemojis
	for line in (cat ~/.config/tol/emojis)
        set line (string split " " $line)
        set line (echo -ns $line\n | strip_empty_lines)

        set newvar (echo e_$line[1])

        set -U $newvar $line[2..-1]
        echo $newvar "-" $$newvar\ \ 
        echo
    end
end
