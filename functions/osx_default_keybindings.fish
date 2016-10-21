function osx_default_keybindings
	plutil -convert xml1 /System/Library/Frameworks/AppKit.framework/Resources/StandardKeyBinding.dict -o - | pl | grep -v noop: | ruby -pe'$_.gsub!(/[^ -~\n]/){"\\U%04x"%$&.ord}' | cat
end
