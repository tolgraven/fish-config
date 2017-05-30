function locate
if status is-interactive
command locate $argv | highlight
else
command locate $argv
end
end
