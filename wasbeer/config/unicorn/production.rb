# Set the working application directory
working_directory "/apps/wasbeer"

# Unicorn PID file location
pid "/apps/wasbeer/shared/pids/unicorn.pid"

# Path to logs
stderr_path "/apps/wasbeer/shared/log/unicorn.log"
stdout_path "/apps/wasbeer/shared/log/unicorn.log"

# Unicorn socket
listen "/apps/wasbeer/shared/web.sock"

# Number of processes
worker_processes 2

# Time-out
timeout 30
