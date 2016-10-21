display_right(){
    columns="$(tput cols)"
    while IFS= read -r line; do
        printf "%*s\n" $columns "$line"
    done < "$1"
}
