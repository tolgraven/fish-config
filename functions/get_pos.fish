function get_pos
	bass pos
    #bash -c 'source ~/.config/fish/functions/pos_row_col.bash && pos' | read curpos
    set curpos (string split ';' $curpos)

    #set curpos (bash -c 'echo -en "\E[6n";read -sdR CURPOS; CURPOS=${CURPOS#*[};echo "${CURPOS}"')
    echo $curpos
end
