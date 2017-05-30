complete -xc brightness -a '(seq 0 20 100)' -d "val"
#complete -xc brightness -a '{+,-}{5,10}' -d 'rel'
for amount in (seq 10 10 30)
    for direction in '+' '-'
        set new (math (brightness) $direction $amount)
        complete -xc brightness -n "test "$new" -gt 0 -a "$new" -le 100" -a $direction$amount -d $new
    end
end
complete -xc brightness -a '(brightness)' -d "current"

