working_directory "~/cse_week_contest/lezyjudge"
#pid "~/learning/ruby/lezyjudge/tmp/pids/unicorn.pid"
#stderr_path "/tmp/unicorn/unicorn.log"
#stdout_path "/tmp/unicorn/unicorn.log"

listen "/tmp/unicorn.lezyjudge.sock"
worker_processes 2
timeout 30
