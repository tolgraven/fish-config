function lunchy
if type -q highlight
command lunchy $argv | highlight
else
command lunchy $argv
end
end
