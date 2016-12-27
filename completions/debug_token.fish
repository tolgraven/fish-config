function __complete_debug_token
for func in (grep -r --files-with-match debug ~/.config/fish/functions); echo (string split '/fish/functions/' $func)[2] | string replace -- '.fish' ''; end
end

complete -xc debug_token -a '(__complete_debug_token)'
#"(for func in (grep -r --files-with-match debug ~/.config/fish/functions); echo (string split '/fish/functions/' $func)[2] | string replace -- '.fish' ''; end)" #'(for func in (grep -r --files-with-match debug ~/.config/fish/functions); echo (string split '/fish/functions/' $func)[2] | string replace -- '.fish' ''; end)'
