function get
	set -l url (pbpaste)
    wget "$url"
end
