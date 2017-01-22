function surround -d "surround text, using string replace" -a part pre post text
    string replace -- "$part" "$pre$part$post" $text
end
