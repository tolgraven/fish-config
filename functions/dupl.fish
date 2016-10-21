function dupl --description 'duplicate file or folder'
	set name (string split --right --max=1 . $argv)[1]
    set ext (string split --right . $argv)[-1]
    #echo $name; echo $ext; echo {$name}__COPY.{$ext}
    cp "$argv" {$name}__COPY.{$ext}
end
