function bid -d "find bundle id for string name"
	# combine all args as regex
	# (and remove ".app" from the end if it exists due to autocomplete)
	set -l shortname (echo "$argv%%.app"| sed 's/ /.*/g')
	set -l location 
	# if the file is a full match in apps folder, roll with it
	if [ -d "/Applications/$shortname.app" ]
		set location="/Applications/$shortname.app"
	else # otherwise, start searching
		set location (mdfind -onlyin /Applications -onlyin ~/Applications -onlyin /Developer/Applications 'kMDItemKind==Application'| awk -F '/' -v re="$shortname" 'tolower($NF) ~ re {print $0}'| head -n1)
	end
	test -z "$location"; and echo "no result for $argv..."; and return 1
	set bundleid (mdls -name kMDItemCFBundleIdentifier -r "$location")
	# return the result or an error message
	test -z "$bundleid"; and echo "Error getting bundle ID for $argv"
	or echo "$location: $bundleid"

# end

#original bash...
# bid() {
# 	local shortname location
# 	# combine all args as regex
# 	# (and remove ".app" from the end if it exists due to autocomplete)
# 	shortname=$(echo "${@%%.app}"|sed 's/ /.*/g')
# 	# if the file is a full match in apps folder, roll with it
# 	if [ -d "/Applications/$shortname.app" ]; then
# 		location="/Applications/$shortname.app"
# 	else # otherwise, start searching
# 		location=$(mdfind -onlyin /Applications -onlyin ~/Applications -onlyin /Developer/Applications 'kMDItemKind==Application'|awk -F '/' -v re="$shortname" 'tolower($NF) ~ re {print $0}'|head -n1)
# 	fi
# 	# No results? Die.
# 	[[ -z $location || $location = "" ]] && echo "$1 not found, I quit" && return
# 	# Otherwise, find the bundleid using spotlight metadata
# 	bundleid=$(mdls -name kMDItemCFBundleIdentifier -r "$location")
# 	# return the result or an error message
# 	[[ -z $bundleid || $bundleid = "" ]] && echo "Error getting bundle ID for \"$@\"" || echo "$location: $bundleid"
# 	}
end
