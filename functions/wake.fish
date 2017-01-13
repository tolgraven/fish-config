function wake -d "alarm clock"
    #start playing spotify, and ramp its volume
    spotify volume 0
    spotify play
    ramp 100 "spotify volume" 180 100 #mod spotify script so returns volume when called bare
end
