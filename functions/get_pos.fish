function get_pos
#echo -n -e '\e[6n' | read -g curpos
#tput u7 | read -g curpos #tput u7 seems does same
commandline_save get_pos
#echo -n (tput u7)
set -l IFS ';'
tput u7 | read -g row line
set row (string sub --start 2 "$row")
set line (string sub --length (math (string length -- "$line") - 1) "$line")
echo $row
echo $line
#echo -n $curpos
#set -g splitpos (string split -- ';' (commandline))
#commandline | pbcopy
#set -g splitpos (commandline) #(string escape -- (commandline))
#echo -E -ns $splitpos\n
#commandline ""
commandline_restore get_pos

#bass pos #bash -c 'source ~/.config/fish/functions/pos_row_col.bash && pos' | read curpos
#set curpos (string split ';' $curpos) #set curpos (bash -c 'echo -en "\E[6n";read -sdR CURPOS; CURPOS=${CURPOS#*[};echo "${CURPOS}"')
#echo $curpos
end
