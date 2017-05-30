complete -xc contrast -a '(seq 0 20 100)' -d 'val'
#complete -xc contrast -a '{+,-}{5,10}' -d (contrast)
for amount in (seq 10 10 30)
    for direction in '+' '-'
        set new (math (contrast) $direction $amount)
        complete -xc contrast -n "test "$new" -gt 0 -a "$new" -le 100" -a $direction$amount -d $new
    end
end
complete -xc contrast -a '(contrast)' -d 'current val'

