function cat --description 'cancy cat with auto syntax coloring and stuff'
set -l arguments $argv
not test -z "$argv[-1]"
and for i in (seq (count $argv))
if test -r $argv[$i] #file, readable
or functions -q -- $argv[$i]

set file $argv[$i]
set -e arguments[$i]
end
end
if not contains -- '--force' $argv
if not isatty 1 #regular if piped etc
or status is-command-substitution
or not status is-interactive
command cat $argv
debug "not interactive, passing through, args %s" $argv
return $status
end
else
set i (contains --index -- '--force' $argv)
and set -e argv[$i] #removing my own "--force" param, should it exist
set i (contains --index -- '--force' $arguments)
and set -e arguments[$i]
end

not test -z "$file"
and not string match -- '-*' $file
and if not test -e $file #not a file
if string match -r -q -- 'http?://*' $file #url #debug "url: %s" $file
cat (curl --quiet $file | psub) #curl $argv[-1] | cat
return $status
else if functions -q $file
funcat $file
debug "fish function: %s" $file
return $status
end
else if grep -q bplist00 $file #binary plist
cat (plutil -p $file | psub) #plutil -p $argv | cat #broken by fish
debug "binary plist, args %s" $argv
return $status
end

debug "looking at extname for file %s, full argv %s" $file $argv
set -l ext (extname $file)
and switch "$ext"
case 'fish'
test (count $arguments) -eq 0
and command cat $file | fish_indent --ansi
or command cat $file | fish_indent --ansi | command cat $arguments #pass through if passed like -n etc
debug "fish, args %s" $argv
return $status
case 'png' 'PNG' 'jpg' 'JPG' 'jpeg' 'JPEG' 'gif' 'GIF' #debug "imgcat, args %s" $argv
imgcat $file
return $status
case 'whatever apple stuff like .app' #quicklook? ;)
case '*'
debug "highlight, args %s, ext %s" $argv $ext
highlight $file ^&-
or highlight $file --syntax=conf ^&-
and return $status #and, so will continue below if highlight lacks def and throws.. smart!
end

if test -z "$argv"
#OI!!! add check for ansi escapes and cat clean in that case
highlight #something is fucking broken in fish, piping to functions doesnt work anymore???
debug "highlight, generic (piped)"
return $status
end
#if type -q vimcat #debug "vimcat, args %s" $argv
#vimcat $argv #fix args in vimcat func instead?
#else 
if type -q ccat #debug "ccat, args %s" $argv
command cat $argv | ccat
else #debug "straight cat, args %s" $argv
command cat $argv
end
end
