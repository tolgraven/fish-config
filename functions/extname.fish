function extname --description 'gets extension part of file, after last dot'
set part '-1'
not test -z "$argv"
and switch $argv[1]
case '-r' '--reverse'
set part 1
case '-*'
return 1
case '*'
set -l output (string split -r -- . "$argv[-1]")
echo $output[$part]
end
or return 1
#if not test -z $argv[-1]
#set -l output (string split -r -- . "$argv[-1]")
#echo $output[$part] #[-1]
#else #; echoerr "no output"
#return 1
#end
end
