function whatsmyip --description 'Shows external ip'
	dig +short myip.opendns.com @resolver1.opendns.com
end
