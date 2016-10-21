function json_fetch_pretty --description 'download and print json' --argument url
	curl "$url" ^&- | js-beautify | vimcat -c "setfiletype json"
end
