function __tol_get_longest_common
#echo -ns $argv\n | sed -e 'N;s/^\(.*\).*\n\1.*$/\1/' #dumb for two strings
echo -ns $argv\n | gsed -e 'N;s/^\(.*\).*\n\1.*$/\1\n\1/;D' #good, for N strings
end
