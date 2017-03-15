function cat --description 'cancy cat with auto syntax coloring and stuff'
not test -z "$argv[-1]" #and test -r $argv[-1]; #and set -l file $argv[-1]
and for i in (seq (count $argv))
test -r $argv[$i] #file, readable
and set file $argv[$i]
and set -e argv[$i]
end #set -q file; and debug "got file $file"
if not contains -- '--force' $argv
if not isatty 1 #regular if piped etc
or status --is-command-substitution
or not status --is-interactive #debug "not interactive, passing through, args %s" $argv
command cat $argv
return $status
end
else
set index (contains --index -- '--force' $argv)
and set -e argv[$index]
end

set -q file #test (count $argv) -gt 0
and not string match -- '-*' $file
and if not test -e $file #not a file
if string match -r -q -- 'http?://*' $file #url #debug "url: %s" $file
cat (curl --quiet $file | psub) #curl $argv[-1] | cat
return $status
else if functions -q $file #function #debug "fish function: %s" $file
funcat $file
return $status
end
else if grep -q bplist00 $file #binary plist #debug "binary plist, args %s" $argv
cat (plutil -p $argv | psub) #plutil -p $argv | cat #broken by fish
return $status
end

set -l ext (extname $file)
and switch "$ext"
case 'fish' #debug "fish, args %s" $argv
test (count $argv) -eq 0
and command cat $file | fish_indent --ansi
or command cat $file | fish_indent --ansi | command cat $argv #pass through if passed like -n etc
return $status
case 'png' 'PNG' 'jpg' 'JPG' 'jpeg' 'JPEG' 'gif' 'GIF' #debug "imgcat, args %s" $argv
imgcat $file
return $status
case 'whatever apple stuff like .app' #quicklook? ;)
case '*' #debug "highlight, args %s, ext %s" $argv $ext
highlight $file ^&-
and return $status #and, so will continue below if highlight throws silent error.. smart!
end

if test -z "$argv" #debug "highlight, generic (piped)"
highlight #something is fucking broken in fish, piping to functions doesnt work anymore???
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
