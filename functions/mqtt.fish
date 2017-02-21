function mqtt --description 'publish mqtt message' --argument topic message host
test -z "$host"
and set host "paj" #default server
mosquitto_pub -h $host -t $topic -m $message
end
