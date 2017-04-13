function bro
command bro $argv ^&- | grep -v upvote | grep -v downvote | grep -v 'submit your own example' | strip_ansi_color | strip_empty_lines | fish_indent --ansi
end
