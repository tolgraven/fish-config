function appstore --description 'list app store-bought apps'
	find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print | \sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'
end
