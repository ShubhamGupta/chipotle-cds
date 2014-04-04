@dir = "/var/www/chipotle/shared/"
@dir_home = "/var/www/chipotle/current"
worker_processes 4
working_directory "#{@dir_home}"
timeout 15
preload_app true

stderr_path "/var/www/chipotle/current/log/unicorn.log"
stdout_path "/var/www/chipotle/current/log/unicorn.log"

pid "#{@dir}tmp/pids/unicorn.pid"
preload_app true

GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

# Unicorn socket
listen "#{@dir}tmp/sockets/unicorn.sock", backlog: 64

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end