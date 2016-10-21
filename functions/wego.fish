function wego --argument days location
	set -l key 'fd4c9cad3618470ba6b182034161510'
    test -z "$location"
    and set location "Stockholm, Sweden"
    test -z "$days"
    and set days 5
    command wego -city $location -days $days -wwo-api-key $key
end
