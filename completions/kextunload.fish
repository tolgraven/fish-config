function __complete_kexts
    set kexts_sle (ls /System/Library/Extensions/)
    set kexts_lib (ls /Library/Extensions/)
    set -l loaded (kextstat -l -k)
    set -l loaded (string split "." $loaded)
    #set files_loaded (string match *(extname --reverse $kexts_sle\n)* ) )
    for kext in $kexts_sle $kexts_lib
        #echo $loaded\n
        contains (extname --reverse $kext) $loaded
    end
#blablalba
    echo -s $kexts_sle\t\ 'system'\n
    echo -s $kexts_lib\t\ 'library'\n

end
complete -xc kextunload -a '(__complete_kexts)'
