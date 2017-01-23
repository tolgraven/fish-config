function __tol_edit_token --description 'edit contents of current token interactively, funced, vared, etc' --argument force
set -l token (commandline -t)
test -z "$token"
and return 1 #set -l isarray #set -l cmdline (commandline); set -l cmdpos (commandline -C); commandline ""
if functions -q $token
func $token $force
else if set -q $token
debug "var, no dollar %s" $token
if test (count $$token) -eq 1
#vared $token
arred $token
else
arred $token
end
else if set -q (string sub -s 2 $token)
debug "var, with dollar %s" $token
set token (string sub -s 2 $token)
if test (count $$token) -eq 1
arred $token
#vared $token
else
arred $token #set isarray true
end
else if string match '$*' $token
debug "dollar, no var - make new, %s"
set token (string sub -s 2 $token)
set -g $token '' #init empty as global
arred $token

else if test -d (string replace -- '~' "$HOME" $token) #dir
cd (string replace -- '~' "$HOME" $token)
else if test -f (string replace -- '~' "$HOME" $token) #file
cd (dirname (string replace -- '~' "$HOME" $token))
else
debug "unknown, creating function"
func $token #maybe look up if its a content of a var or array? +if --thing find parent token and comped
end #commandline $cmdline; commandline -C $cmdpos
commandline -f repaint
end
