function columnize --argument ncols
	test (count $ncols) -eq 1
    or set ncols 1
    while read -a lines
        echo $line | pr -$ncols -w$COLUMNS -at
        printf "%s\n" $$listvarname | eval paste (yes - | head -n $ncols | tr '\n' " ") | column -t
    end
    #echo $lines | pr -$ncols -w$COLUMNS -at
end
