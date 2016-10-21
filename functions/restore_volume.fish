function restore_volume --description 'write disk image to volume' --argument source_img destination_volume
	sudo asr -restore -noverify -source "$source_img" -target "$destination"
end
