function get_row
	bash -c 'source ~/.config/fish/pos_row_col.bash && row' | read row
    echo $row
end
