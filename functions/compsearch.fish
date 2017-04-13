function compsearch --description 'searches for text in all function definitions' --argument search scope
test -z "$scope"
and set scope "all" #"user"
set -l paths
switch $scope
case 'user'
debug "user search"
set paths $fish_complete_path[1..2] #user + fisherman
case 'all'
debug "all search"
set paths $fish_complete_path #all
end
for path in $paths
not test -d $path
and continue
set hits (searchtext "$argv" $path ^&-)
test (count $hits) -gt 1 #always get one line with just the dir
and echo -ns $hits\n
end

end
