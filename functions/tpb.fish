function tpb
set -l num_results 30

googler --json --site thepiratebay.se "$argv" #| highlight | fzf #| read -l url
not test -z "$url"
and set -l magnet (wget --quiet $url -O - | list_urls | grep magnet:)[1]
not test -z "$magnet"
and deluge add "$magnet"
end
