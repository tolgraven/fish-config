function funcsearch --description 'searches for text in all function definitions' --argument search scope
test -z "$scope"
and set scope "all" #"user"
set -l paths
switch $scope
case 'user'
debug "user search"
set paths $fish_function_path[1..2] #user + fisherman
case 'all'
debug "all search"
set paths $fish_function_path #all
end
for path in $paths
not test -d $path
and continue
set hits (searchtext "$argv" $path ^&-)
test (count $hits) -gt 1 #always get one line with just the dir
#and echo $path: #ack already shows
and echo -ns $hits\n
end

#set -l functions (functions -a)
#for i in (seq 1 (count $functions))
##set __tol_funclist[$i] (functions functions[$i] | fish_indent --ansi | ack --context 3 $argv)
#functions functions[$i] | fish_indent --ansi | ack --context 3 $argv
#end
##echo -n $__tol_funclist\n
end
