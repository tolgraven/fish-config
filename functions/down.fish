function down --description 'download url in clipboard to current folder' --argument url
test -z "$url"
and set url (pbpaste)
if not string match -q -- '*://*' $url
echoerr "not a valid url"
return 1
end
set -l filename (basename "$url")
test -e $filename
and set filename (extname --reverse $filename)_wget.(extname $filename)
wget -O "$filename" $url #(string escape -- (pbpaste)) #\"(pbpaste)\"
end
