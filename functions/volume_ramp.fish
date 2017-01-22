function volume_ramp --description 'smoothly change volume' --argument vol time steps
    test -z "$vol"
    and return
    test -z "$time"
    and set -l time 1
    test -z "$steps"
    and set -l steps 10

    ramp $vol volume $time $steps #use the generic func..

    return $status
end
