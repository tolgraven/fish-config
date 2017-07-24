function dequarantine -d "strip quarantine extended attribute"
xattr -rd com.apple.quarantine ./
end
