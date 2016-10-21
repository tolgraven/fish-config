function mqtt --description 'publish mqtt message' --argument host topic message
	mosquitto_pub -h $host -t $topic -m $message
end
