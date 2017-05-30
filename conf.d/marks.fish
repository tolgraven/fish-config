set -q markpath, or set -U markpath $XDG_CONFIG_HOME/.marks
function jump
  cd -P "$markpath/$argv" 2>/dev/null
	or echo "No such mark: $argv"
end
function mark
	ls -l "$markpath" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- \
	| awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
  # mkdir -p "$markpath"
	# ln -s "(pwd)" "$markpath/$argv"
end
function unmark
  rm -i "$markpath/$argv"
end
function marks
  ls -l "$markpath" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g'
	and echo
end
