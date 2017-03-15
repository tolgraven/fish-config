function __tol_run_commandline
set -l cmdline (commandline)
set -l cmdpos (commandline -C)
commandline $cmdline
commandline -C $cmdpos
end
