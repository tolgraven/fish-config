function __complete_mas
    for line in (string trim (command mas help)[3..-1])
        echo -ns (string trim (string split " " (string trim $line))[1]) \t
        echo (string trim (string split " " (string trim $line))[2..-1])
    end
end
complete -xc mas -a '(__complete_mas)' #'(for line in (string trim (command mas help)[3..-1]); echo (string split " " (string trim $line))[1] \t (string split " " (string trim $line))[2..-1]; end)'
