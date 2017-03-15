function __tol_job_eval_replace
set -l job_output (eval (commandline --current-job))
test "$job_output"
and commandline --current-job $job_output
commandline -f repaint
end
