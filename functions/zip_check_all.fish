function zip_check_all
find . -name '*.zip' -exec unzip -tq '{}' \; | highlight
end
