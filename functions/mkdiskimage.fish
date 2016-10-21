function mkdiskimage --description 'make disk image from folder' --argument folderpath
	if test -z $folderpath
        return 1
    else
        set folder (basename $folderpath)
        hdiutil create -volname "$folder" -srcfolder "$folderpath" -ov $folder.dmg
    end
end
