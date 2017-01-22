function psc --description 'grep a fancy ps' --argument process extracommand
    set basecmd "ps axo pid,user,start,%mem,time,ucomm"

    type -q grc
    and set cmd "grc -es --colour=on $basecmd"
    or set cmd "$basecmd | cat"
    set header '  PID ' # just one constant there to retain header
    set pipecmd 'grep -i --color=always -e $header -e $process'
    #set pipecmd "string match --all --ignore-case -- '*$process*'" #doesnt work when put in a var hmm

    set -l output
    if test -z "$process"
        #set output (eval $cmd)
    else if not test -z "$extracommand"
        set output (eval $cmd,(string replace --all " " ',' "$argv[2..-1]") | eval $pipecmd) #quoting the early part was actually what was breaking it earlier lol. the comma after $cmd is due to ps's arg list format..
    else
        set output (eval $cmd | eval $pipecmd)
    end
    if test (count $output) -eq 1 #if only header then no hits
        if not set -q __psc_level
            set -g __psc_level
            and pscc $process
            return
        else
            set -e __psc_level #removed after the pscc iteration..
            return
        end
    end
    set -l fancyout (string replace --all -r -- '(/usr)(.*?)(Python)(.*?)(-c)' 'Python -c' $output)
    set -l fancyout (echo -n -s $fancyout\n | string replace --all "/Applications" (set_color yellow)"/A"(set_color normal) | string replace --all "/Contents" (set_color black)"/C" | string replace --all "/MacOS" "/M"(set_color normal) | string replace --all "/Frameworks" (set_color brpurple)"/F"(set_color normal) | string replace --all "/Resources" "/R" | string replace --all "/Versions" "/V" | string replace --all "/System" (set_color yellow)"/S"(set_color normal) | string replace --all "/Library" "/L" | string replace --all "/usr/" (set_color brpurple)"/usr/" | string replace --all ".framework" ".f" | string replace --all $HOME '~')

    test (count $fancyout) -gt 1
    and echo -sn $fancyout\n
    or echo $output #fallback it filter is wanky
end
