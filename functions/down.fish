function down --description 'download url in clipboard to current folder'
    wget -O (basename (pbpaste)) (pbpaste) #(string escape -- (pbpaste)) #\"(pbpaste)\"
end
