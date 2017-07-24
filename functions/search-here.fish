function search-here
if mdfind -name "$argv" -onlyin ./ | read -la result
for line in $result
echo "File $result:"
#cat $result | grep -i "$argv"
#or cat $result
end
else
find . | string replace --all './' '' | grep $argv
end
end
