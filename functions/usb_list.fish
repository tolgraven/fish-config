function usb_list --description 'list connected USB devices on macOS'
#    ioreg -p IOUSB -w0 | sed 's/[^o]*o //; s/@.*$//' | grep -v '^Root.*'
ioreg -p IOUSB -w0 | string replace -ar '@.*' '' | highlight --syntax=sh
end
