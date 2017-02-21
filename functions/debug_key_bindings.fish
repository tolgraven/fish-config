function debug_key_bindings -d 'meta-d-dtnf for token/notoken/on/off'
bind \ed\ef "debug_off; commandline -f repaint"
bind \ed\en "debug_on; commandline -f repaint"
bind \ed\et "debug_notoken; commandline -f repaint"
bind \ed\ed "debug_token; commandline -f repaint"
end
