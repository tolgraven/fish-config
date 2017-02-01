function cat --description 'cancy cat with auto syntax coloring and stuff'
test -r $argv[-1]
and set -l file $argv[-1] #separate other args i guess as well

if not contains -- '--force' $argv
if not isatty 1 #regular if piped etc
or status --is-command-substitution
or not status --is-interactive
debug "not interactive, passing through, args %s" $argv
command cat $argv
return $status
end
else
set index (contains --index -- '--force' $argv)
and set -e argv[$index]
end

test (count $argv) -gt 0
and not string match -- '-*' $file
and if grep -q bplist00 $file
debug "binary plist, args %s" $argv
cat (plutil -p $argv | psub) #plutil -p $argv | cat #broken by fish
return $status
else if not test -e $file #not a file
if string match -r -q -- 'http?://*' $file #url
debug "url: %s" $file
cat (curl --quiet $file | psub) #curl $argv[-1] | cat
return $status
else if functions -q $file #function
debug "fish function: %s" $file
funcat $file
return $status
end
end
set -l ext (extname $file)
and switch "$ext"
case 'fish'
debug "fish, args %s" $argv
set color "--ansi"
test (count $argv) -eq 1
and command cat $argv | fish_indent $color
or command cat $file | fish_indent $color | command cat $argv[1..-2]
return $status
case 'png' 'jpg' 'jpeg' 'gif'
debug "imgcat, args %s" $argv
imgcat $file
return $status #case 'whatever apple stuff like .app'; quicklook? ;)
case '*'
debug "highlight, args %s, ext %s" $argv $ext
highlight $file ^&-
and return $status #and = so will continue below if highlight throws silent error.. smart!
end

if test -z "$argv"
debug "highlight, generic (piped)"
highlight #something is fucking broken in fish, piping to functions doesnt work anymore???
return $status
end

if type -q vimcat
debug "vimcat, args %s" $argv
vimcat $argv #fix args in vimcat func instead?
else if type -q ccat
debug "ccat, args %s" $argv
command cat $argv | ccat
else
debug "straight cat, args %s" $argv
command cat $argv
end
end
