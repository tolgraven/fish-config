function get_col
	bash -c 'source ~/.config/fish/pos_row_col.bash && col' | read col
    echo $col
end
