function __tol_edit_token --description 'edit contents of current token interactively, funced, vared, etc' --argument force
set -l token (commandline -t)
test -z "$token"
and set token (commandline --tokenize)[-1] #check last token in case we just got a space after it. should actually check the relevant token based on pos, rather than just last...
test -z "$token"
and return 1
#set -l cmdline (commandline)
#set -l cmdpos (commandline -C)
commandline_save edit_token #for proper refresh after return (ie show new function as blue not orange)
if functions -q $token
func $token $force
else if set -q $token #debug "var, no dollar %s" $token
set isvar
else if set -q (string sub -s 2 $token) #debug "var, with dollar %s" $token
set token (string sub -s 2 $token)
set isvar
else if string match '$*' $token #debug "dollar, no var - make new, %s"
set token (string sub -s 2 $token)
set -g $token '' #init empty as global
set isvar #arred $token
else if test -d (string replace -- '~' "$HOME" $token) #dir, cd there
cd (string replace -- '~' "$HOME" $token)
else if test -f (string replace -- '~' "$HOME" $token) #file, cd there. or maybe: open small text file in toled, open large in $EDITOR
#cd (dirname (string replace -- '~' "$HOME" $token))
eval $EDITOR (string replace -- '~' "$HOME" $token)
else #debug "unknown, creating function"
func $token #maybe look up if its a content of a var or array? +if --thing find parent token and comped
end
if set -ql isvar
arred $token #if test (count $$token) -eq 1; arred $token; else; arred $token; end
end
commandline_restore edit_token
#commandline $cmdline
#commandline -C $cmdpos
#commandline -f repaint
end
