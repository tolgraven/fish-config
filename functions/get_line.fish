function get_line --description 'get current cursor line number'
bash -c 'source ~/.config/fish/pos_row_col.bash && row' #| read line
#echo $line
end
