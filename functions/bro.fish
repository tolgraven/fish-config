function bro
command bro $argv ^&- | grep -v upvote | grep -v downvote | strip_ansi_color | strip_empty_lines | fish_indent --ansi
end
